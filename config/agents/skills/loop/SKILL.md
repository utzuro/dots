---
name: loop
description: "Runs an iterative PLAN.md loop: parent reads the plan, delegates one small chunk to a Pi worker subprocess, verifies/reviews, sends fixes to that same subprocess, closes it, then repeats with a fresh subprocess."
argument-hint: "Loop goal or constraints"
---

# Loop

Advance `PLAN.md` in small review-driven cycles. User arguments are goals, priorities, or stop constraints.

The parent agent orchestrates only: read plan, choose scope, launch worker, verify/review, update `PLAN.md`, decide next step. Do not implement the selected chunk in the parent session except for `PLAN.md` bookkeeping or explicit user-approved emergency fixes.

## Cycle contract

For each chunk:

1. Re-read root `PLAN.md` plus `SPEC.md` / `ADR.md` if present.
2. Pick one small required open item with clear acceptance/verification.
3. Update `PLAN.md` progress briefly.
4. Launch a new Pi `worker` subprocess for that item.
5. Parent verifies the worker's changes and runs focused checks.
6. Run `review-council` on the current changes.
7. Triage findings; send valid major fixes back to the same worker subprocess.
8. Re-verify after fixes.
9. Update `PLAN.md` with results, remaining blockers, and next recommended item.
10. Close the worker subprocess; start a fresh one for the next chunk.

Repeat while required work remains, no user decision is blocked, and context/time are safe. Stop after updating `PLAN.md` if the next change would be too large, rushed, ambiguous, or context-heavy.

## Subprocess rules

Use `pi-subagents` for worker lifecycle. Before first launch, list available agents/chains and prefer packaged `worker`.

- One active worker subprocess per chunk.
- Reuse that same subprocess only for verification/review follow-ups for the current chunk.
- Never reuse it for another `PLAN.md` item.
- If it is still running or paused when the chunk is done, interrupt/kill it with subagent control; if completed, treat it as closed and do not resume it.
- Do not ask the worker to launch subagents, manage the loop, or choose broader scope.

Worker prompts must include: repo root, plan/spec/ADR paths, selected item, allowed scope/non-goals, relevant files if known, acceptance criteria, expected checks, instruction to make real edits, and instruction to stop/escalate on unclear product/architecture/scope decisions.

If the worker reports a blocker needing user input, record it in `PLAN.md` and ask one focused question.

## Review triage

Treat a finding as major only when it involves:

- failing build/tests or missing required coverage
- behavior wrong versus `PLAN.md`, `SPEC.md`, ADRs, or user requirements
- data loss, security, privacy, race, or reliability risk
- architecture drift that makes the plan harder to finish
- unhandled core-flow edge case

Send a fix request only when the fix is in scope, protects a real requirement or safety/maintainability property, and stays small/direct. Defer or reject speculative, out-of-scope, high-complexity, or low-impact findings. Record the rationale briefly in `PLAN.md`.

## Workflow

### 1. Orient

Find repo root. Read `PLAN.md`; if missing, ask whether to create it or use another file. Read root `SPEC.md` / `ADR.md` if present. Inspect git status with read-only commands. Notice human changes.

### 2. Select and mark

Pick the smallest clear open item. If none is clear, update `PLAN.md` with the ambiguity and ask one focused question.

Progress section shape, following existing style when possible:

```md
## Loop Progress

- Current focus: ...
- Active subprocess: ...
- Completed this run: ...
- Review status: ...
- Remaining major issues: ...
- Next recommended focus: ...
```

### 3. Delegate

Launch `worker` for only the selected chunk. Prefer foreground unless the parent has useful independent work while it runs.

### 4. Verify and review

After worker completion, inspect changed files and run the narrowest useful checks first. If checks fail in scope, resume the same worker with a focused fix request.

Load and follow `review-council`; focus it on the selected item and note that implementation was delegated. Triage output, then send valid major fixes to the same worker. Re-run relevant checks after fixes. Re-run council only when major fix changes need confirmation.

### 5. Close and continue

Re-read and update `PLAN.md` with what changed, checks/results, review decisions, blockers, next item, and whether the plan is complete. Close/kill the active worker as described above before starting another chunk.

Stop only when no required work remains, checks pass or limitations are documented, `review-council` has no unresolved major findings, and the active worker is closed.
