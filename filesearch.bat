@echo off
set /p folder=Search folder (full path):
if "%folder%"=="" set folder=%cd%
set /p ext=File extension (e.g. .txt) or * for all:
if "%ext%"=="*" dir /s /b "%folder%\*" & exit /b
dir /s /b "%folder%\*%ext%"