---
name: github-actions
description: Create .github/workflows/ci.yml with one matrix job for ubuntu, windows and macos that only runs scripts/ci.sh or scripts/ci.bat. Use when create-actions is invoked.
---
# Skill: github-actions

## When to use
The user runs `/create-actions`, or `/run-init` reaches step 4. Requires `scripts/ci.sh` and `scripts/ci.bat`.

## Inputs
Verified CI scripts from build-and-test.

## Outputs
`.github/workflows/ci.yml`

## Template
```yaml
name: CI

on:
  push:
    branches: [develop, master, "feature/**"]
  pull_request:
    branches: [develop, master]

jobs:
  build-and-test:
    name: build-and-test (${{ matrix.os }})
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Build and test (Linux/macOS)
        if: runner.os != 'Windows'
        shell: bash
        run: bash ./scripts/ci.sh

      - name: Build and test (Windows)
        if: runner.os == 'Windows'
        shell: cmd
        run: scripts\ci.bat

      - name: Upload executable
        uses: actions/upload-artifact@v4
        with:
          name: hello-${{ matrix.os }}
          path: dist/
```

## Rules
- Exactly one job with a matrix of three OS.
- No secrets, tokens or hard-coded credentials in the file.
- Build logic stays in the scripts, not in the YAML.

## Verification
- YAML parses without errors.
- File contains `ubuntu-latest`, `windows-latest`, `macos-latest`.
- Triggers include push and pull_request for `develop` and `master`.

## Example
Input: scripts exist. Output: `ci.yml` created, report "github-actions: PASS".

## Typical failure
YAML syntax error (wrong indentation or stray character before `${{ }}`). Action: show the line number, fix the block, re-validate.
