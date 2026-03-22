@echo off
title Schools Store
color 0A
mode con: cols=90 lines=45
setlocal EnableDelayedExpansion

:: Config (same as your original)
set "MOD_FOLDER=%USERPROFILE%\Documents\MFKYOCCL"
set "REPO_OWNER=KeiranGamingTV"
set "REPO_NAME=Batch-Multitool"
set "REPO_PATH=multitool\files"  :: root

cls
echo(
echo School Store 
echo ======================
echo(
echo Fetching available modules...
echo(

:: Create module folder if missing
if not exist "%MOD_FOLDER%" (
    mkdir "%MOD_FOLDER%"
    echo Created module folder: %MOD_FOLDER%
)

:: Fetch .bat file names from GitHub API (only .bat files)
set "api_url=https://api.github.com/repos/%REPO_OWNER%/%REPO_NAME%/contents/%REPO_PATH%"
set "ps_cmd=try { (Invoke-RestMethod -Uri '!api_url!' -Headers @{Accept='application/vnd.github.v3+json'}).name -match '\.bat$' -replace '\.bat$','' -join ' ' } catch { 'ERROR: ' + $_.Exception.Message }"
set "bat_list="
for /f "delims=" %%o in ('powershell -NoProfile -Command "!ps_cmd!" 2^>nul') do set "bat_list=%%o"

if "!bat_list:~0,6!"=="ERROR:" (
    echo [ERROR] !bat_list:~7!
    echo Check internet, GitHub API, or repo existence.
    pause
    exit /b
)

if "!bat_list!"=="" (
    echo No .bat modules found in the repo.
    pause
    exit /b
)

cls
echo Available modules:
echo ────────────────────────────────────────────
set count=0
set "mod_list="
for %%n in (!bat_list!) do (
    set /a count+=1
    echo [!count!] %%n
    set "mod_list=!mod_list! %%n"
)
echo(
echo Total: !count! modules
echo(
echo Select number (1-!count!) to view/download or press Enter to exit:
set "sel="
set /p "sel="

if "!sel!"=="" exit /b
if !sel! lss 1 exit /b
if !sel! gtr !count! exit /b

set idx=0
for %%n in (!mod_list!) do (
    set /a idx+=1
    if !idx! equ !sel! set "chosen=%%n"
)

cls
echo Selected: !chosen!
echo ────────────────────────────────────────────

:: Show description (.txt file if exists)
set "txt_url=https://raw.githubusercontent.com/%REPO_OWNER%/%REPO_NAME%/main/!chosen!.txt"
echo Description:
powershell -NoProfile -Command ^
    "try { (Invoke-WebRequest -Uri '!txt_url!' -UseBasicParsing).Content } catch { 'No description available (.txt missing or error)' }" 2>nul
echo(
echo Press SPACEBAR to download !chosen!.bat  (or any other key to cancel)
:wait_space
set "key="
for /f "delims=" %%k in ('powershell -NoProfile -Command "[Console]::ReadKey($true).KeyChar"') do set "key=%%k"
if not "!key!"==" " goto wait_space

echo(
echo Downloading !chosen!.bat...

powershell -NoProfile -Command ^
    "try { Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/%REPO_OWNER%/%REPO_NAME%/main/!chosen!.bat' -OutFile '%MOD_FOLDER%\!chosen!.bat' -UseBasicParsing -ErrorAction Stop; Write-Host '[SUCCESS]' } catch { Write-Host '[ERROR] ' + $_.Exception.Message; exit 1 }"

if exist "%MOD_FOLDER%\!chosen!.bat" (
    echo Download complete. File saved to:
    echo %MOD_FOLDER%\!chosen!.bat
    echo(
    echo You can now run it from the main KyoCLv6 terminal by typing '!chosen!'
) else (
    echo Download failed. Check connection, repo, or run as Administrator.
)

echo(
echo Press any key to return to store...
pause >nul
goto :eof   :: End script (or loop back if you want multi-select later)