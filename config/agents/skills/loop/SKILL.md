---
name: loop
description: "Runs an iterative PLAN.md execution loop: pick one small issue, run it in an isolated subprocess, review, address major findings, update the plan, and repeat until complete. Use when the user invokes /loop, asks to work through PLAN.md iteratively, or wants review-driven plan completion."
argument-hint: "Loop goal or constraints"
---

# Loop

Use this skill to advance `PLAN.md` with tight review-driven cycles. Treat user arguments as the loop goal, priority, or stopping constraint.

## Loop contract

Each cycle must:

1. Re-read `PLAN.md` and any present root `SPEC.md` / `ADR.md` before choosing work.
2. Pick exactly one small required issue from `PLAN.md`.
3. Implement that issue with the smallest clean change and relevant tests/checks.
4. Run `review-council` for the current changes.
5. Address all major review findings related to the cycle.
6. Update `PLAN.md` with progress, review outcome, remaining work, and the next recommended issue.

Repeat while the plan still has required work, no blocker needs user input, and there is enough context/time to continue safely. If continuing would risk a rushed or oversized change, stop after updating `PLAN.md` so the next `/loop` can resume cleanly.

## Major issue definition

Treat a finding as major when it involves any of:

- failing build, failing tests, or missing required test coverage
- incorrect behavior versus `PLAN.md`, `SPEC.md`, or user requirements
- data loss, security, privacy, race, or reliability risk
- architectural inconsistency that would make the plan harder to complete
- unhandled edge case in the core flow being changed

Minor style, naming, documentation, optional refactor comments, and valid-but-low-impact findings whose fix would add disproportionate complexity must not block the loop. Record them in `PLAN.md` only if they are useful future context.

## Proportionality filter

Before fixing any council finding, decide whether the fix is worth its complexity.

Fix the finding only when:

- it protects a stated requirement, core user flow, safety property, or maintainability constraint
- the implementation remains small, direct, and consistent with the current design
- the expected risk reduction is greater than the complexity introduced

Defer or reject the finding when:

- it is speculative, only theoretically possible, or outside the current plan scope
- fixing it requires broad abstraction, redesign, new dependencies, or significant extra surface area
- the current simpler behavior is acceptable for `PLAN.md` / `SPEC.md` requirements

When deferring or rejecting a council finding, briefly record the rationale in `PLAN.md` under review status. Do not implement complexity just to satisfy a reviewer.

## Workflow

### 1. Orient

- Find the repository root.
- Read root `PLAN.md`; if it is missing, ask the user whether to create it or use another plan file.
- Read root `SPEC.md` and `ADR.md` if present.
- Inspect current git status only with read-only commands.
- Identify already completed work and any human changes since the last cycle.

### 2. Select one issue

Choose the smallest open required item that moves the plan toward completion. Prefer items with clear acceptance criteria and a fast verification path.

If no item is small or clear enough, update `PLAN.md` with the ambiguity and ask the user one focused question.

### 3. Mark progress in PLAN.md

Identify the selected issue and pass it to the loop subprocess. If needed, the subprocess can also create/update the concise progress section to keep the parent context clean.

```md
## Loop Progress

- Current focus: ...
- Completed this run: ...
- Review status: ...
- Remaining major issues: ...
- Next recommended focus: ...
```

Keep this section factual and short. Preserve existing plan structure and user edits.

### 4. Implement and verify (isolated subprocess)

- Delegate the actual implementation and verification to an isolated pi subprocess to keep the main context clean:

```bash
bash ~/.agents/skills/loop/scripts/run-loop-cycle.sh "<selected issue text>"
```

The worker will:

- make the smallest clean change for the selected issue,
- add/update required tests and checks,
- run narrow checks first, then broader checks if cheap,
- update `PLAN.md` progress for this run.

Optional tuning environment variables:

- `PI_LOOP_TIMEOUT` (default: `900s`)
- `PI_LOOP_MODEL` (model passed to worker subprocess)
- `PI_LOOP_TOOLS` (tools for worker; default: `read,edit,write,grep,find,ls,bash`)

If verification cannot run, record why in `PLAN.md`.

### 5. Review council

Load and follow the `review-council` skill. Run it after implementation and verification, passing a short focus string that names the selected issue.

Do not treat the council output as automatically correct. Triage findings against the major issue definition and the proportionality filter.

### 6. Address review

- Fix every major finding that is valid, in scope, and proportionate.
- Reject or defer findings whose fix would add unjustified complexity, even if the finding is technically valid.
- Re-run relevant tests/checks after fixes (preferably by re-running `run-loop-cycle.sh` with a focused task).
- Re-run `review-council` if major code changes were made in response to review or if any major finding needs confirmation.
- Record fixed, deferred, and rejected findings in `PLAN.md` with short rationale.

### 7. Prepare next run

Before stopping or starting the next cycle, re-read `PLAN.md` and update it with:

- what changed
- checks run and results
- review findings addressed
- unresolved major blockers, if any
- the next smallest recommended issue
- whether the plan appears complete

Stop only when `PLAN.md` has no remaining required work, checks pass or limitations are documented, and `review-council` has no unresolved major findings.
