---
name: build-and-test
description: Create CMakeLists.txt, a GoogleTest unit test named BasicAddition and local CI scripts (scripts/ci.sh, scripts/ci.bat). Use when create-build is invoked.
---
# Skill: build-and-test

## When to use
The user runs `/create-build`, or `/run-init` reaches step 3. Requires `src/hello_lib.h` and `src/main.cpp`.

## Inputs
Project tree created by project-scaffold.

## Outputs
```
CMakeLists.txt
tests/test_basic.cpp
scripts/ci.sh
scripts/ci.bat
```
Running the scripts must produce `dist/hello` (Windows: `dist/hello.exe`).

## Templates
`CMakeLists.txt`
```cmake
cmake_minimum_required(VERSION 3.20)
project(HelloWorld LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(hello_lib src/hello_lib.cpp)
target_include_directories(hello_lib PUBLIC src)

add_executable(hello src/main.cpp)
target_link_libraries(hello PRIVATE hello_lib)

include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()
add_executable(hello_tests tests/test_basic.cpp)
target_link_libraries(hello_tests PRIVATE hello_lib GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(hello_tests)
```
`tests/test_basic.cpp`
```cpp
#include <gtest/gtest.h>
#include "hello_lib.h"

TEST(MathTest, BasicAddition) {
    EXPECT_EQ(5, add(2, 3));
}

TEST(GreetingTest, ReturnsHelloWorld) {
    EXPECT_EQ("Hello, World!", greeting());
}
```
`scripts/ci.sh`
```bash
#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
mkdir -p dist
if [ -f build/hello ]; then cp build/hello dist/hello; else cp build/Release/hello dist/hello; fi
./dist/hello
```
`scripts/ci.bat`
```bat
@echo off
setlocal
cd /d "%~dp0\.."
cmake -S . -B build || exit /b 1
cmake --build build --config Release || exit /b 1
ctest --test-dir build -C Release --output-on-failure || exit /b 1
if not exist dist mkdir dist
if exist build\Release\hello.exe (
  copy /Y build\Release\hello.exe dist\hello.exe >nul
) else (
  copy /Y build\hello.exe dist\hello.exe >nul
)
if errorlevel 1 exit /b 1
dist\hello.exe || exit /b 1
```
`scripts/ci.sh` must be marked executable: `git update-index --chmod=+x scripts/ci.sh`.

## Verification
- `cmake -S . -B build` and `cmake --build build --config Release` exit with 0.
- `ctest --test-dir build -C Release --output-on-failure` reports `BasicAddition` as passed.
- `dist/hello` prints `Hello, World!`.
- `git status` does not show `build/` or `dist/`.

## Example
Input: scaffolded project. Output: 4 files, 100% tests passed, executable in `dist/`.

## Typical failure
GoogleTest cannot be downloaded (no network). Action: report the exact CMake error, do not replace GoogleTest with a fake test, ask the user to check the connection.
