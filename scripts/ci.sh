#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
ctest --test-dir build -C Release --output-on-failure
mkdir -p dist
if [ -f build/hello ]; then cp build/hello dist/hello; else cp build/Release/hello dist/hello; fi
./dist/hello
