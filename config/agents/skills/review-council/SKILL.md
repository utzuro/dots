---
name: review-council
description: Runs a parallel council of read-only Pi code reviewers with distinct perspectives and returns their findings. Use when the user asks for code review, PR review, bug-finding, architecture review, QA/test review, overengineering review, or a multi-perspective review of current changes.
---

# Review Council

Use this skill to review current code changes when user asks for a final review by delegating to separate read-only Pi subprocesses. The caller agent must not perform the review itself and must not modify files while using this skill.
This is heavy task, so run it only for a final review.
When user asks for "review council" or "final review", use this skill.

## Quick start

From the repository root or current working directory:

```bash
bash ~/.agents/skills/review-council/scripts/run-review-council.sh
```

With extra review instructions:

```bash
bash ~/.agents/skills/review-council/scripts/run-review-council.sh "focus on subscription restore flows"
```

## Workflow for the caller agent

1. Run the helper script.
2. Wait for completion.
3. Display the script output to the user. Minor formatting is okay, but do not invent extra findings.
4. If a reviewer times out or fails, show that reviewer failure and any successful reviewer output.

## Configuration

Environment variables:

- `PI_REVIEW_BASE`: base branch/ref. Default: `main`, falling back to `origin/main`.
- `PI_REVIEW_TIMEOUT`: per-reviewer timeout. Default: `900s`.
- `PI_REVIEWERS`: comma-separated reviewer ids to run. Default: all reviewers.
- `PI_REVIEW_MODEL`: optional model passed to each `pi` subprocess.

Reviewer ids: `pragmatic`, `clean-architecture`, `edge-reliability`, `security`, `qa`.

Examples:

```bash
PI_REVIEWERS=pragmatic,qa PI_REVIEW_TIMEOUT=300s \
  bash ~/.agents/skills/review-council/scripts/run-review-council.sh
```
