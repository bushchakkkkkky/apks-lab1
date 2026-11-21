---
name: project-scaffold
description: Create a minimal Hello World C++ project skeleton with README, docs and .gitignore. Use when the repository has no src/ directory or when create-project is invoked.
---
# Skill: project-scaffold

## When to use
The user runs `/create-project`, or `/init` reaches step 2.

## Inputs
- `language` = C++17 (default)
- `project_name` = `hello` (default)

## Outputs
```
src/hello_lib.h
src/hello_lib.cpp
src/main.cpp
docs/architecture.md   (agent, skills, commands, data flow, error handling, mapping of files to roles)
docs/usage.md          (exact commands to run the agent and the local check)
README.md              (full name, group, variant, short description, how to run the agent)
.gitignore
```

## Templates
`src/hello_lib.h`
```cpp
#pragma once
#include <string>

std::string greeting();
int add(int a, int b);
```
`src/hello_lib.cpp`
```cpp
#include "hello_lib.h"

std::string greeting() { return "Hello, World!"; }
int add(int a, int b) { return a + b; }
```
`src/main.cpp`
```cpp
#include <iostream>
#include "hello_lib.h"

int main() {
    std::cout << greeting() << std::endl;
    return 0;
}
```
`.gitignore` must contain at least: `build/`, `dist/`, `out/`, `.vscode/`, `.idea/`, `*.log`, `.env`, `*.pem`, `*.key`.

`README.md` header: Bushchak Yevhen Volodymyrovych, group KI-406, variant 1 (C++ / CMake / GoogleTest).

## Rules
- If a file exists, do not overwrite it. Compare with the template and report differences.
- Append missing lines to `.gitignore`; never duplicate lines.

## Verification
- `src/main.cpp`, `src/hello_lib.h`, `src/hello_lib.cpp` exist.
- `.gitignore` contains `build/`.
- README contains the run command: `./dist/hello` (Windows: `dist\hello.exe`).

## Example
Input: empty repository. Output: all files above created, report "project-scaffold: PASS".

## Typical failure
`src/` already exists with a different `main.cpp`. Action: do not overwrite, print the diff and stop with "FAIL: manual decision required".
