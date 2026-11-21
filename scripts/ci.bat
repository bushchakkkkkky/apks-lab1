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
