---
name: review-council
description: Runs a parallel council of read-only Pi code reviewers with distinct perspectives and returns their findings. Use when the user asks for code review, PR review, bug-finding, architecture review, QA/test review, overengineering review, or a multi-perspective review of current changes.
---

# Review Council

Use this skill to review current code changes by delegating to separate read-only Pi subprocesses. The caller agent must not perform the review itself and must not modify files while using this skill.

## Quick start

From the repository root or current working directory:

```bash
bash ~/.agents/skills/review-council/scripts/run-review-council.sh
```

With extra review instructions:

```bash
bash ~/.agents/skills/review-council/scripts/run-review-council.sh "focus on subscription restore flows"
```

## What it runs

The helper launches these reviewers in parallel:

1. **Pragmatic reviewer**: obvious bugs, missing implementation, misunderstood requirements, broken handling, and whether the implementation is complete enough to work.
2. **Clean architecture reviewer**: maintainability, separation of concerns, naming, reuse, coupling, observability, hidden side effects, unnecessary duplication or fragmentation.
3. **Paranoid reviewer**: edge cases, failure modes, state transitions, unexpected inputs, and unhappy paths.
4. **Reliability reviewer**: retries, concurrency, timeouts, idempotency, cancellation, resource leaks, partial failure, rollback, data loss, and degraded dependencies.
5. **Security reviewer**: trust boundaries, auth/authz, secrets, injection, unsafe IO/shell/network usage, dependency and supply-chain exposure.
6. **Adversary reviewer**: counterexamples, exploit cases, malicious inputs, worst-case sequences, invalid states, and violated invariants.
7. **Wise reviewer**: big-picture fit, system direction, missed simpler/product/domain concerns, out-of-the-box connections.
8. **Simple dude**: overengineering, accidental complexity, code/tests/config that can be safely removed or simplified.
9. **QA reviewer**: tests derived from specs and business requirements rather than implementation details; removes unnecessary, broad, brittle, duplicated, or cheating tests.
10. **Rockstar reviewer**: ambitious creative alternatives that may fit the problem substantially better.
11. **Product manager**: checks implementation against specs, requirements, invariants, risk assumptions, and user/client expectations.
12. **Grumpy critic**: aggressively attacks anything not written well enough or likely to cause production issues.
13. **Arbiter reviewer**: evidence-checks its own claims against the diff, context files, and read-only tool results; prefers no finding over speculation.

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

Reviewer ids: `pragmatic`, `clean-architecture`, `paranoid`, `reliability`, `security`, `adversary`, `wise`, `simple-dude`, `qa`, `rockstar`, `product-manager`, `grumpy-critic`, `arbiter`.

Examples:

```bash
PI_REVIEWERS=pragmatic,qa PI_REVIEW_TIMEOUT=300s \
  bash ~/.agents/skills/review-council/scripts/run-review-council.sh
```

## Safety

The helper starts Pi with `--no-session --no-skills --no-extensions --no-prompt-templates` and read-only tools: `read`, `grep`, `find`, `ls`. It gathers diff context, AGENTS.md files, and root `PLAN.md`, `SPEC.md`, `ADR.md` when present, then instructs reviewers not to edit files or run fix commands.
