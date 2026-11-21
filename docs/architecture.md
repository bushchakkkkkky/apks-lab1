# Architecture

The project is a small C++17 application built and tested with CMake.

- `src/hello_lib.h` and `src/hello_lib.cpp` define the reusable greeting and
  addition functions.
- `src/main.cpp` links the library and prints the greeting.
- `tests/test_basic.cpp` verifies the library through GoogleTest.
- `scripts/ci.sh` and `scripts/ci.bat` run configure, build, CTest, packaging,
  and the executable check.
- `.github/workflows/ci.yml` runs the platform script on Linux, Windows, and
  macOS.

The `/run-init` workflow is fail-fast and idempotent. It runs the repository
commands in the order `git-init`, `create-project`, `create-build`,
`create-actions`, and `check`. Build logic stays in the local scripts rather
than the workflow YAML.
