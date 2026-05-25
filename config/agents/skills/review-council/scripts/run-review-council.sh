#!/usr/bin/env bash
set -euo pipefail

extra_instructions="$*"
base_ref="${PI_REVIEW_BASE:-main}"
reviewer_filter="${PI_REVIEWERS:-all}"
review_timeout="${PI_REVIEW_TIMEOUT:-900s}"
model_arg=()

if [[ -n "${PI_REVIEW_MODEL:-}" ]]; then
	model_arg=(--model "$PI_REVIEW_MODEL")
fi

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
	cat <<'HELP'
Usage: run-review-council.sh [extra review instructions]

Runs parallel read-only Pi reviewer subprocesses against the diff from main.

Environment:
  PI_REVIEW_BASE      Base ref to compare against. Default: main, then origin/main.
  PI_REVIEW_TIMEOUT   Per-reviewer timeout. Default: 900s.
  PI_REVIEWERS        Comma-separated ids, or all. Default: all.
                      ids: pragmatic, clean-architecture, paranoid,
                           reliability, security, adversary, wise,
                           simple-dude, qa, rockstar, product-manager,
                           grumpy-critic, arbiter
  PI_REVIEW_MODEL     Optional model passed to each pi subprocess.
HELP
	exit 0
fi

if ! command -v pi >/dev/null 2>&1; then
	echo "Error: pi command not found in PATH" >&2
	exit 127
fi

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

if ! git rev-parse --verify "$base_ref" >/dev/null 2>&1; then
	if git rev-parse --verify "origin/$base_ref" >/dev/null 2>&1; then
		base_ref="origin/$base_ref"
	else
		echo "Error: neither $base_ref nor origin/$base_ref exists; cannot review diff" >&2
		exit 1
	fi
fi

merge_base="$(git merge-base HEAD "$base_ref" 2>/dev/null || true)"
if [[ -z "$merge_base" ]]; then
	echo "Error: failed to find merge base between HEAD and $base_ref" >&2
	exit 1
fi

status_output="$(git status --short 2>&1 || true)"
diff_stat="$(git diff --stat "$merge_base" -- 2>&1 || true)"
diff_output="$(git diff --find-renames --find-copies --submodule=diff "$merge_base" -- 2>&1 || true)"
untracked_files="$(git ls-files --others --exclude-standard 2>&1 || true)"
context_files="$({
	dir="$repo_root"
	while true; do
		[[ -f "$dir/AGENTS.md" ]] && echo "$dir/AGENTS.md"
		[[ "$dir" == "/" ]] && break
		dir="$(dirname "$dir")"
	done
	find "$repo_root" -name AGENTS.md -print 2>/dev/null || true
} | awk '!seen[$0]++' | sort)"
project_docs="$({
	for file in PLAN.md SPEC.md ADR.md; do
		if [[ -f "$repo_root/$file" ]]; then
			echo "$repo_root/$file"
		fi
	done
} | sort)"
run_id="$(date +%Y%m%d-%H%M%S)"
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/pi-review-council-$run_id.XXXXXX")"

cleanup() {
	rm -rf "$tmp_dir"
}
trap cleanup EXIT

system_prompt_file="$tmp_dir/system-prompt.md"
cat >"$system_prompt_file" <<'SYSTEM_PROMPT'
You are a read-only code reviewer subprocess. Review only from your assigned perspective. Do not modify files or run non-read-only commands.

Report only concrete, actionable issues introduced by this patch that the author would likely fix. Ignore taste/style unless it hides a real correctness, maintainability, test, product, or production risk. If claiming breakage, name the affected path/scenario. Keep line ranges short and preferably on changed lines.

Priorities: P0 blocking, P1 urgent, P2 normal, P3 low.

Return Markdown exactly:

## Reviewer
`<reviewer name>`

## Findings
`No findings.` or findings like:
### [P<0-3>] <title>
- Location: `<path>:<start>-<end>`
- Confidence: `<0.0-1.0>`
- Body: <one concise paragraph: why this matters and when it happens>

## Overall correctness
`patch is correct`, `patch has risks`, or `patch is incorrect`

## Overall explanation
1-3 sentences.

## Overall confidence score
<number 0.0-1.0>
SYSTEM_PROMPT

write_prompt() {
	local prompt_file="$1"
	local reviewer_name="$2"
	local reviewer_focus="$3"

	cat >"$prompt_file" <<PROMPT
Review the current code changes in this repository against the base branch.

Repository root:
$repo_root

Base ref:
$base_ref

Merge base:
$merge_base

Assigned reviewer:
$reviewer_name

Reviewer focus:
$reviewer_focus

Additional user review instructions:
${extra_instructions:-None.}

Process:
- Stay in your reviewer role and report only concrete, actionable findings.
- Read listed AGENTS.md and root PLAN.md/SPEC.md/ADR.md when useful.
- Start from the diff; inspect surrounding code with read-only tools as needed.
- Treat untracked files as new files.
- Do not edit, format, or run fix commands.

Context files that may be relevant:

--- BEGIN CONTEXT FILES ---
$context_files
--- END CONTEXT FILES ---

Project docs, if any:

--- BEGIN PROJECT DOCS ---
$project_docs
--- END PROJECT DOCS ---

Git status --short:

--- BEGIN GIT STATUS ---
$status_output
--- END GIT STATUS ---

Git diff --stat $merge_base:

--- BEGIN DIFF STAT ---
$diff_stat
--- END DIFF STAT ---

Untracked files:

--- BEGIN UNTRACKED FILES ---
$untracked_files
--- END UNTRACKED FILES ---

Tracked diff against $merge_base:

--- BEGIN TRACKED DIFF ---
$diff_output
--- END TRACKED DIFF ---
PROMPT
}

run_pi() {
	local prompt_file="$1"
	if command -v timeout >/dev/null 2>&1; then
		timeout "$review_timeout" pi \
			--print \
			--no-session \
			--no-skills \
			--no-extensions \
			--no-prompt-templates \
			--tools read,grep,find,ls \
			"${model_arg[@]}" \
			--append-system-prompt "$system_prompt_file" \
			"Run the delegated code review using the full review context provided on stdin." \
			<"$prompt_file"
	else
		pi \
			--print \
			--no-session \
			--no-skills \
			--no-extensions \
			--no-prompt-templates \
			--tools read,grep,find,ls \
			"${model_arg[@]}" \
			--append-system-prompt "$system_prompt_file" \
			"Run the delegated code review using the full review context provided on stdin." \
			<"$prompt_file"
	fi
}

reviewer_selected() {
	local id="$1"
	if [[ "$reviewer_filter" == "all" || -z "$reviewer_filter" ]]; then
		return 0
	fi
	local item
	IFS=',' read -ra items <<<"$reviewer_filter"
	for item in "${items[@]}"; do
		item="${item//[[:space:]]/}"
		if [[ "$item" == "$id" ]]; then
			return 0
		fi
	done
	return 1
}

start_reviewer() {
	local id="$1"
	local name="$2"
	local focus="$3"

	if ! reviewer_selected "$id"; then
		return 0
	fi

	local prompt_file="$tmp_dir/$id.prompt.md"
	local out_file="$tmp_dir/$id.out.md"
	local err_file="$tmp_dir/$id.err.md"
	local exit_file="$tmp_dir/$id.exit"

	write_prompt "$prompt_file" "$name" "$focus"

	(
		set +e
		run_pi "$prompt_file" >"$out_file" 2>"$err_file"
		echo "$?" >"$exit_file"
	) &

	pids+=("$!")
	ids+=("$id")
	names+=("$name")
	out_files+=("$out_file")
	err_files+=("$err_file")
	exit_files+=("$exit_file")
}

pids=()
ids=()
names=()
out_files=()
err_files=()
exit_files=()

start_reviewer "pragmatic" "Pragmatic reviewer" "Check for obvious errors, missing implementation, misunderstood requirements, broken handling, incorrect assumptions, and code paths that simply will not work. Think like a builder validating that the implementation is complete enough to run. Prefer concrete bugs over taste."
start_reviewer "clean-architecture" "Clean architecture reviewer" "Check maintainability, separation of concerns, responsibility boundaries, naming, reuse, coupling, observability, hidden side effects, unnecessary duplication, unnecessary fragmentation, and whether the code is simple to understand and reason about."
start_reviewer "paranoid" "Paranoid reviewer" "Analyze edge cases, failure modes, all important flows, unexpected inputs, state transitions, invalid states, and whether behavior remains acceptable when things go wrong."
start_reviewer "reliability" "Reliability reviewer" "Attack retries, concurrency, idempotency, timeouts, cancellation, resource leaks, partial failure, rollback/partial-success behavior, data loss/corruption, degraded dependencies, and race-prone state transitions."
start_reviewer "security" "Security reviewer" "Attack trust boundaries, auth/authz, secrets, injection, deserialization, unsafe file/network/shell usage, dependency and supply-chain exposure, and places where a malicious user can cross privilege or data boundaries."
start_reviewer "adversary" "Adversary reviewer" "Try to produce concrete counterexamples and exploit cases. Look for malicious inputs, worst-case sequences, invalid states, invariant violations, and the smallest scenario that breaks the patch's assumptions."
start_reviewer "wise" "Wise reviewer" "Take a bird's-eye view. Check whether the implementation fits the system, domain, and direction; notice missed obvious product/domain/system concerns; call out when the change moves in the wrong direction."
start_reviewer "simple-dude" "Simple dude" "Protect against overengineering. Point out code, tests, abstractions, configuration, branching, or workflows that are too complex and can be reasonably safely simplified or removed."
start_reviewer "qa" "QA reviewer" "Review tests derived from specs and business requirements rather than implementation-detail coupling. Flag missing requirement coverage, cheating, brittle, excessive, too-broad, duplicated, or unnecessary tests. Prefer small, generalized, clearly necessary tests."
start_reviewer "rockstar" "Rockstar reviewer" "Look for creative, powerful, elegant, high-leverage alternatives that could fit the problem much better. Only report ideas grounded in this patch and likely worth author attention."
start_reviewer "product-manager" "Product manager" "Check whether the implementation follows specs, business requirements, invariants, risk assumptions, and user/client expectations. Focus on gaps that could make clients angry, confused, blocked, unsupported, or unhappy even if the code technically works."
start_reviewer "grumpy-critic" "Grumpy critic" "Be strict, tired, and hard to impress. Attack anything that is not written in the best reasonable way or could cause production issues. Still report only concrete, actionable findings grounded in the patch."
start_reviewer "arbiter" "Arbiter reviewer" "Act as an evidence auditor. Compare every potential claim against the diff, context files, and read-only tool results before reporting it; reject speculation, overclaims, and findings that cannot be tied to an actual path/scenario."

if [[ "${#pids[@]}" -eq 0 ]]; then
	echo "Error: no reviewers selected by PI_REVIEWERS=$reviewer_filter" >&2
	exit 1
fi

for pid in "${pids[@]}"; do
	wait "$pid" || true
done

failures=0

cat <<HEADER
# Review council results

Repository: $repo_root
Base ref: $base_ref
Merge base: $merge_base
Reviewers: ${ids[*]}
Per-reviewer timeout: $review_timeout

HEADER

for i in "${!ids[@]}"; do
	id="${ids[$i]}"
	name="${names[$i]}"
	out_file="${out_files[$i]}"
	err_file="${err_files[$i]}"
	exit_file="${exit_files[$i]}"
	exit_code="missing"

	if [[ -f "$exit_file" ]]; then
		exit_code="$(<"$exit_file")"
	fi

	echo "---"
	echo
	echo "# $name ($id)"
	echo

	if [[ "$exit_code" == "0" ]]; then
		if [[ -s "$out_file" ]]; then
			cat "$out_file"
		else
			echo "Reviewer completed with no output."
		fi
	else
		failures=$((failures + 1))
		if [[ "$exit_code" == "124" ]]; then
			echo "Reviewer timed out after $review_timeout."
		else
			echo "Reviewer failed with exit code $exit_code."
		fi
		if [[ -s "$err_file" ]]; then
			echo
			echo "stderr:"
			cat "$err_file"
		fi
		if [[ -s "$out_file" ]]; then
			echo
			echo "partial stdout:"
			cat "$out_file"
		fi
	fi

	echo
done

if [[ "$failures" -gt 0 ]]; then
	echo "Review council completed with $failures failed reviewer(s)." >&2
	exit 1
fi
