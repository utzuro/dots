#!/usr/bin/env bash
set -euo pipefail

usage() {
	cat <<'USAGE'
Usage: run-loop-cycle.sh <task>

Run one /loop implementation cycle in an isolated pi subprocess.
Pass the selected issue/task text as the single argument.

Environment:
  PI_LOOP_TIMEOUT   Per-subprocess timeout (default: 900s).
  PI_LOOP_MODEL     Optional model passed to the pi subprocess.
  PI_LOOP_TOOLS     Comma-separated tools list (default: read,edit,write,grep,find,ls,bash).
USAGE
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
	usage
	exit 0
fi

if [[ $# -lt 1 ]]; then
	usage >&2
	exit 1
fi

if ! command -v pi >/dev/null 2>&1; then
	echo "Error: pi command not found in PATH" >&2
	exit 127
fi

task="$*"
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

timeout_value="${PI_LOOP_TIMEOUT:-900s}"
loop_tools="${PI_LOOP_TOOLS:-read,edit,write,grep,find,ls,bash}"
model_arg=()

if [[ -n "${PI_LOOP_MODEL:-}" ]]; then
	model_arg=(--model "$PI_LOOP_MODEL")
fi

status_output="$(git status --short 2>&1 || true)"
diff_stat="$(git diff --stat 2>&1 || true)"
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
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/pi-loop-cycle-$run_id.XXXXXX")"
cleanup() {
	rm -rf "$tmp_dir"
}
trap cleanup EXIT

system_prompt_file="$tmp_dir/system-prompt.md"
cat >"$system_prompt_file" <<'SYSTEM_PROMPT'
You are a read/write /loop execution subprocess.
Make only one small, clean change set for the selected task.
Use root PLAN.md, SPEC.md, and ADR.md for scope if they exist.
Prefer minimal direct fixes over abstractions.
Run concise, narrow verification for this task.
If work is unsafe or underspecified, report blockers clearly.
Do not run review-council from within this subprocess.

Return a short markdown report with:
- Files changed
- Checks run (command + result)
- Plan updates
- Any blockers or assumptions
SYSTEM_PROMPT

prompt_file="$tmp_dir/loop-cycle.prompt.md"
cat >"$prompt_file" <<PROMPT
Run the selected /loop cycle task in this repository.

Repository root:
$repo_root

Task:
$task

Context files that may be relevant:
$context_files

Project docs:
$project_docs

Current git status:
$status_output

Current git diff --stat:
$diff_stat

Untracked files:
$untracked_files

Constraints:
- Keep work scoped to exactly one required PLAN item.
- Make the smallest clean implementation change and any required test/check updates for that item.
- Update PLAN.md with loop progress for this run.
- Keep the parent process clean by doing all implementation and verification inside this subprocess.
PROMPT

run_pi() {
	if command -v timeout >/dev/null 2>&1; then
		timeout "$timeout_value" pi \
			--print \
			--no-session \
			--no-skills \
			--no-extensions \
			--no-prompt-templates \
			--tools "$loop_tools" \
			"${model_arg[@]}" \
			--append-system-prompt "$system_prompt_file" \
			"Execute this /loop task end-to-end."
	else
		pi \
			--print \
			--no-session \
			--no-skills \
			--no-extensions \
			--no-prompt-templates \
			--tools "$loop_tools" \
			"${model_arg[@]}" \
			--append-system-prompt "$system_prompt_file" \
			"Execute this /loop task end-to-end."
	fi
}

run_pi <"$prompt_file"
