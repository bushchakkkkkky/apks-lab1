---
agent: agent
description: Create the GitHub Actions matrix workflow using the github-actions skill.
---
# Command: create-actions

## Preconditions
- `scripts/ci.sh` and `scripts/ci.bat` exist.

## Actions
1. Read and follow `.github/skills/github-actions/SKILL.md`.
2. Create `.github/workflows/ci.yml` (one job, matrix: ubuntu-latest, windows-latest, macos-latest; the steps only call the CI scripts).

## Expected files
`.github/workflows/ci.yml`

## Verification
The YAML parses (for example `python -c "import yaml,sys; yaml.safe_load(open('.github/workflows/ci.yml'))"`) and contains all three operating systems.

## On error
Stop, print the YAML error with the line number.
