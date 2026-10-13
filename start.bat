@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Local Chatbot Setup

set "PYTHON="
py -3.11 --version >nul 2>&1
if not errorlevel 1 set "PYTHON=py -3.11"
if not defined PYTHON (
    py -3.12 --version >nul 2>&1
    if not errorlevel 1 set "PYTHON=py -3.12"
)
if not defined PYTHON (
    python --version >nul 2>&1
    if not errorlevel 1 set "PYTHON=python"
)
if not defined PYTHON if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" set "PYTHON=%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
if not defined PYTHON if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" set "PYTHON=%LOCALAPPDATA%\Programs\Python\Python311\python.exe"

if not defined PYTHON (
    where winget >nul 2>&1
    if errorlevel 1 goto missing_python
    echo First-time setup: installing Python. This may take a few minutes.
    winget install --id Python.Python.3.12 --source winget --scope user --silent --accept-source-agreements --accept-package-agreements
    if errorlevel 1 goto python_install_failed
    if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" set "PYTHON=%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
    if not defined PYTHON goto missing_python
)

if not exist ".venv\Scripts\python.exe" (
    echo First-time setup: preparing the app...
    %PYTHON% -m venv .venv
    if errorlevel 1 goto setup_failed
)

echo Checking app files and installing any needed updates...
".venv\Scripts\python.exe" -m pip install --disable-pip-version-check -r requirements.txt
if errorlevel 1 goto setup_failed

echo Starting Local Chatbot...
".venv\Scripts\python.exe" -m app.main
if errorlevel 1 goto launch_failed
goto done

:missing_python
echo Python 3.11 or newer is needed for the first setup.
echo This computer does not have the Windows package installer (winget) available to install it automatically.
echo Please ask someone to install Python 3.11 or newer, then double-click start.bat again.
pause
exit /b 1

:python_install_failed
echo Python could not be installed automatically. Check your internet connection and try again.
pause
exit /b 1

:setup_failed
echo Setup could not finish. Check your internet connection, then double-click start.bat to try again.
pause
exit /b 1

:launch_failed
echo The app could not start. See the message above for a plain-English explanation.
pause
exit /b 1

:done
endlocal
