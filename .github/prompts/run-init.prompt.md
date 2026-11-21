---
agent: agent
description: Orchestrator - run git-init, create-project, create-build, create-actions and check in order, stopping at the first failure.
---
# Command: run-init (orchestrator)

## Preconditions
- Open workspace is a Git repository; the user is on a `feature/...` branch (warn otherwise).
- `cmake` and a C++ compiler are available.

## Steps (strict order)
1. Run `/git-init`. If it fails, stop.
2. Run `/create-project`. If it fails, stop.
3. Run `/create-build`. If it fails, stop.
4. Run `/create-actions`. If it fails, stop.
5. Run `/check`. If any check is FAIL, finish with an error report.

## Rules
- Fail-fast: never run a step after a failed one; never report success without running `/check`.
- Each step receives the files created by the previous steps; nothing is deleted or force-overwritten.
- Running `/run-init` a second time must not break or duplicate anything (idempotent).

## Final report
A summary table: step, status, created/updated files, time. End with "RUN-INIT: SUCCESS" only if all five steps passed.
