---
agent: agent
description: Create the initial C++ Hello World project using the project-scaffold skill.
---
# Command: create-project

## Preconditions
- `git-init` has been run (a `.gitignore` exists).

## Actions
1. Read and follow `.github/skills/project-scaffold/SKILL.md`.
2. Create `src/`, `docs/`, `README.md` and `.gitignore` entries as described. Do not overwrite existing correct files.

## Expected files
`src/hello_lib.h`, `src/hello_lib.cpp`, `src/main.cpp`, `docs/architecture.md`, `docs/usage.md`, `README.md`.

## Verification
All expected files exist; README contains the run command.

## On error
Stop, print which file could not be created and why. Do not continue to the next command.
