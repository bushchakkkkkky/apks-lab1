---
agent: agent
description: Check the Git repository, create or update .gitignore, show Git status.
---
# Command: git-init

## Preconditions
- The workspace is a Git repository (`git rev-parse --is-inside-work-tree`). If not, run `git init` and tell the user.

## Actions
1. Show the current branch and `git status --short`.
2. Create `.gitignore` if missing; otherwise append only the missing lines: `build/`, `dist/`, `out/`, `.vscode/`, `.idea/`, `*.log`, `.env`, `*.pem`, `*.key`.
3. Warn if the current branch is `master` or `develop` and the user is about to generate the project (recommend a `feature/...` branch).
4. Never run destructive commands (reset --hard, push --force, clean -fd).

## Expected result
`.gitignore` contains `build/` and `dist/`; Git status is printed.

## Verification
`git check-ignore build dist` prints both paths.

## On error
Stop and print the failing command and its output.
