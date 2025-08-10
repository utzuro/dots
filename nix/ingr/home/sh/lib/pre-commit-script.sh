#!/usr/bin/env bash

# Multi-language pre-commit formatter for *staged* files.
# Re-adds any modified files to the index.
set -euo pipefail

have() { command -v "$1" >/dev/null 2>&1; }

# Gather staged files (Added, Copied, Modified, Renamed)
mapfile -d '' STAGED < <(git diff --cached --name-only -z --diff-filter=ACMR)

# Nothing staged? bail early
[ "${#STAGED[@]}" -gt 0 ] || exit 0

# Buckets
py=() js=() ts=() json=() yaml=() md=() html=() css=()
go=() rs=() hs=() rb=() c_cpp=() java=() kt=() cs=()
php=() swift=() scala=() sh=() sql=() tf=()
lisp=() scheme=() rkt=() proto=() docker=() xml=() nix=()

# Sort staged files by extension (ignore deleted/renamed targets that no longer exist)
for f in "${STAGED[@]}"; do
	# only operate on files that exist in the working tree (some tools need content)
	[ -e "$f" ] || continue
	case "$f" in
	*.py) py+=("$f") ;;
	*.js) js+=("$f") ;;
	*.jsx) js+=("$f") ;;
	*.ts) ts+=("$f") ;;
	*.tsx) ts+=("$f") ;;
	*.json) json+=("$f") ;;
	*.yml | *.yaml) yaml+=("$f") ;;
	*.md | *.markdown) md+=("$f") ;;
	*.html | *.htm) html+=("$f") ;;
	*.css) css+=("$f") ;;
	*.go) go+=("$f") ;;
	*.rs) rs+=("$f") ;;
	*.hs) hs+=("$f") ;;
	*.rb) rb+=("$f") ;;
	*.c | *.h | *.cc | *.cpp | *.cxx | *.hpp | *.hh) c_cpp+=("$f") ;;
	*.java) java+=("$f") ;;
	*.kt | *.kts) kt+=("$f") ;;
	*.cs) cs+=("$f") ;;
	*.php) php+=("$f") ;;
	*.swift) swift+=("$f") ;;
	*.scala | *.sc) scala+=("$f") ;;
	*.sh | *.bash | *.zsh) sh+=("$f") ;;
	*.sql) sql+=("$f") ;;
	*.tf | *.tfvars) tf+=("$f") ;;
	*.lisp | *.cl | *.el) lisp+=("$f") ;;
	*.scm) scheme+=("$f") ;;
	*.rkt) rkt+=("$f") ;;
	*.proto) proto+=("$f") ;;
	Dockerfile | *Dockerfile* | *.dockerfile) docker+=("$f") ;;
	*.xml) xml+=("$f") ;;
	*.nix) nix+=("$f") ;;
	esac
done

run_and_add() {
	local tool="$1"
	shift
	local args=()
	while [[ "$#" -gt 0 && ! "$1" =~ ^[^-].*\. ]]; do
		args+=("$1")
		shift
	done
	local -a files=("$@")
	[ "${#files[@]}" -gt 0 ] || return 0
	echo "→ ${tool} ${args[*]}: ${#files[@]} file(s)"
	"$tool" "${args[@]}" "${files[@]}"
	git add -- "${files[@]}"
}

# ---- Formatters / Linters by language --------------------------------------

# Python: ruff format (you asked for this explicitly)
if [ "${#py[@]}" -gt 0 ]; then
	if have ruff; then
		run_and_add "ruff" format "${py[@]}"
	else
		echo "⚠️  ruff not found; skip Python. Install: pipx install ruff"
	fi
fi

# JS/TS/JSON/YAML/MD/HTML/CSS: prettier
prettier_bins=()
have npx && prettier_bins+=("npx" "prettier" "--")
have prettier && prettier_bins=("prettier")
if [ "${#prettier_bins[@]}" -eq 0 ]; then
	[ "${#js[@]}${#ts[@]}${#json[@]}${#yaml[@]}${#md[@]}${#html[@]}${#css[@]}" != "0000000" ] &&
		echo "⚠️  prettier not found; skip web/config files. Install: npm i -D prettier"
else
	# group by tool invocation to reduce overhead
	for group in js ts json yaml md html css; do
		arr_name="$group[@]"
		files=("${!arr_name}")
		[ "${#files[@]}" -gt 0 ] || continue
		echo "→ prettier: ${#files[@]} $group file(s)"
		"${prettier_bins[@]}" --write "${files[@]}"
		git add -- "${files[@]}"
	done
fi

# Go: gofmt (per-file)
if [ "${#go[@]}" -gt 0 ]; then
	if have gofmt; then
		run_and_add "gofmt" -w "${go[@]}"
	elif have go; then
		# fallback, though gofmt should exist with go
		run_and_add "go" fmt "${go[@]}"
	else
		echo "⚠️  go/gofmt not found; skip Go."
	fi
fi

# Rust: rustfmt (prefer cargo fmt if present)
if [ "${#rs[@]}" -gt 0 ]; then
	if have cargo; then
		echo "→ cargo fmt (Rust): project-wide (staged files touched)"
		cargo fmt --quiet || true
		git add -- "${rs[@]}"
	elif have rustfmt; then
		run_and_add "rustfmt" "${rs[@]}"
	else
		echo "⚠️  rustfmt not found; skip Rust. Install: rustup component add rustfmt"
	fi
fi

# Haskell: fourmolu → ormolu → stylish-haskell
if [ "${#hs[@]}" -gt 0 ]; then
	if have fourmolu; then
		run_and_add "fourmolu" -i "${hs[@]}"
	elif have ormolu; then
		run_and_add "ormolu" -i "${hs[@]}"
	elif have stylish-haskell; then
		run_and_add "stylish-haskell" -i "${hs[@]}"
	else
		echo "⚠️  Haskell formatter not found (fourmolu/ormolu/stylish-haskell)."
	fi
fi

# Ruby: rubocop -A (autocorrect)
if [ "${#rb[@]}" -gt 0 ]; then
	if have bundle && [ -f Gemfile.lock ] && grep -qi rubocop Gemfile.lock; then
		echo "→ bundle exec rubocop -A"
		bundle exec rubocop -A -- "${rb[@]}" || true
		git add -- "${rb[@]}"
	elif have rubocop; then
		run_and_add "rubocop" -A -- "${rb[@]}"
	else
		echo "⚠️  rubocop not found; skip Ruby."
	fi
fi

# C/C++: clang-format
if [ "${#c_cpp[@]}" -gt 0 ]; then
	if have clang-format; then
		run_and_add "clang-format" -i "${c_cpp[@]}"
	else
		echo "⚠️  clang-format not found; skip C/C++."
	fi
fi

# Java: google-java-format
if [ "${#java[@]}" -gt 0 ]; then
	if have google-java-format; then
		run_and_add "google-java-format" -i "${java[@]}"
	elif have java && have jar && [ -f ".tools/google-java-format.jar" ]; then
		echo "→ java -jar .tools/google-java-format.jar -i"
		java -jar .tools/google-java-format.jar -i "${java[@]}"
		git add -- "${java[@]}"
	else
		echo "⚠️  google-java-format not found; skip Java. Install: brew install google-java-format (or download JAR)."
	fi
fi

# Kotlin: ktlint
if [ "${#kt[@]}" -gt 0 ]; then
	if have ktlint; then
		run_and_add "ktlint" -F "${kt[@]}"
	else
		echo "⚠️  ktlint not found; skip Kotlin. Install: brew install ktlint (or SDKMAN)."
	fi
fi

# C#: dotnet format (project/solution-wide)
if [ "${#cs[@]}" -gt 0 ]; then
	if have dotnet; then
		echo "→ dotnet format (may touch more than staged files)"
		dotnet format || true
		git add -A
	else
		echo "⚠️  dotnet CLI not found; skip C#."
	fi
fi

# PHP: php -l + php-cs-fixer
if [ "${#php[@]}" -gt 0 ]; then
	if have php; then
		echo "→ php -l (syntax check)"
		for f in "${php[@]}"; do php -l "$f" >/dev/null; done
	fi
	if have php-cs-fixer; then
		echo "→ php-cs-fixer fix (no cache) on staged PHP files"
		php-cs-fixer fix --using-cache=no -- "${php[@]}" || true
		git add -- "${php[@]}"
	else
		echo "ℹ️  php-cs-fixer not found; formatting skipped (lint ran if PHP present)."
	fi
fi

# Swift: swiftformat
if [ "${#swift[@]}" -gt 0 ]; then
	if have swiftformat; then
		run_and_add "swiftformat" "${swift[@]}"
	else
		echo "⚠️  swiftformat not found; skip Swift. Install: mint or Homebrew."
	fi
fi

# Scala: scalafmt
if [ "${#scala[@]}" -gt 0 ]; then
	if have scalafmt; then
		run_and_add "scalafmt" -i "${scala[@]}"
	else
		echo "⚠️  scalafmt not found; skip Scala."
	fi
fi

# Shell: shfmt (format) + optional shellcheck (lint-only; does not modify)
if [ "${#sh[@]}" -gt 0 ]; then
	if have shfmt; then
		run_and_add "shfmt" -w "${sh[@]}"
	else
		echo "⚠️  shfmt not found; skip shell formatting."
	fi
	if have shellcheck; then
		echo "→ shellcheck (lint)"
		shellcheck --shell=sh -- "${sh[@]}" || true
	fi
fi

# SQL: sqlfluff (requires config/dialect) – will skip if not installed
if [ "${#sql[@]}" -gt 0 ]; then
	if have sqlfluff; then
		echo "→ sqlfluff fix"
		sqlfluff fix --processes 0 --nocolor -- "${sql[@]}" || true
		git add -- "${sql[@]}"
	else
		echo "⚠️  sqlfluff not found; skip SQL."
	fi
fi

# Terraform: terraform fmt per-file
if [ "${#tf[@]}" -gt 0 ]; then
	if have terraform; then
		echo "→ terraform fmt (per-file)"
		for f in "${tf[@]}"; do terraform fmt -no-color "$f" >/dev/null || true; done
		git add -- "${tf[@]}"
	else
		echo "⚠️  terraform not found; skip Terraform."
	fi
fi

# Lisp / Scheme / Racket
if [ "${#lisp[@]}" -gt 0 ]; then
	if have lisp-format; then
		run_and_add "lisp-format" -i "${lisp[@]}"
	else
		echo "ℹ️  lisp-format not found; skipping Common Lisp/Emacs Lisp formatting."
	fi
fi
if [ "${#scheme[@]}" -gt 0 ] || [ "${#rkt[@]}" -gt 0 ]; then
	rkt_all=("${scheme[@]}" "${rkt[@]}")
	if have raco; then
		run_and_add "raco" fmt -i "${rkt_all[@]}"
	else
		echo "ℹ️  raco (Racket) not found; skipping Scheme/Racket formatting."
	fi
fi

# Protobuf: buf format preferred → clang-format fallback
if [ "${#proto[@]}" -gt 0 ]; then
	if have buf; then
		echo "→ buf format (may be repo-wide)"
		buf format -w || true
		git add -A
	elif have clang-format; then
		run_and_add "clang-format" -i "${proto[@]}"
	else
		echo "⚠️  neither buf nor clang-format found; skip .proto."
	fi
fi

# Dockerfile: hadolint (lint-only) if available
if [ "${#docker[@]}" -gt 0 ]; then
	if have hadolint; then
		echo "→ hadolint (lint)"
		# shellcheck disable=SC2068
		hadolint ${docker[@]} || true
	else
		echo "ℹ️  hadolint not found; no Dockerfile checks."
	fi
fi

# XML: xmllint --format
if [ "${#xml[@]}" -gt 0 ]; then
	if have xmllint; then
		echo "→ xmllint --format"
		for f in "${xml[@]}"; do
			tmp="$f.tmp.__precommit"
			xmllint --format "$f" >"$tmp" && mv "$tmp" "$f"
		done
		git add -- "${xml[@]}"
	else
		echo "ℹ️  xmllint not found; skip XML formatting."
	fi
fi

# Nix: nixpkgs-fmt
if [ "${#nix[@]}" -gt 0 ]; then
	if have nixpkgs-fmt; then
		run_and_add "nixpkgs-fmt" "${nix[@]}"
	else
		echo "⚠️  nixpkgs-fmt not found; skipping .nix formatting. Install via: nix-env -iA nixpkgs.nixpkgs-fmt (or flakes)."
	fi
fi

# Done
exit 0
