---
agent: agent
description: Create CMake configuration, GoogleTest unit tests and CI scripts using the build-and-test skill.
---
# Command: create-build

## Preconditions
- `src/hello_lib.h` and `src/main.cpp` exist. Otherwise stop and ask the user to run `/create-project`.
- `cmake` and a C++ compiler are installed (`cmake --version`).

## Actions
1. Read and follow `.github/skills/build-and-test/SKILL.md`.
2. Create `CMakeLists.txt`, `tests/test_basic.cpp`, `scripts/ci.sh`, `scripts/ci.bat`.
3. Run `scripts/ci.sh` (Linux/macOS) or `scripts/ci.bat` (Windows).

## Expected result
Executable `hello` is built, test `BasicAddition` passes, `dist/hello` exists.

## Verification
`ctest --test-dir build -C Release --output-on-failure` ends with "100% tests passed".

## On error
Stop, print the compiler/CMake/CTest output and the probable cause. Do not edit tests to make them pass.
