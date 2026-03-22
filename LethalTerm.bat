@echo off
title Lethal Company Terminal Simulator
color 0A
mode con: cols=85 lines=40

cls
echo.
echo   THE COMPANY WELCOMES YOU, EMPLOYEE.
echo   Please log in to access ship systems.
echo.
echo   [Press any key to continue...]
pause >nul
cls

echo.
echo   Welcome to Ship Terminal v55.3
echo   Quota: 130 / 300   |   Days left: 3
echo   ---------------------------------------
echo   Type HELP for commands.
echo   Type EXIT to log out.
echo.
echo   > 

:loop
set "cmd="
set /p "cmd=> "

if /i "%cmd%"=="" goto loop
if /i "%cmd%"=="exit" goto end
if /i "%cmd%"=="help" goto help
if /i "%cmd%"=="clear" cls & goto loop
if /i "%cmd%"=="moons" goto moons
if /i "%cmd%"=="store" goto store
if /i "%cmd%"=="bestiary" goto bestiary
if /i "%cmd%"=="scan" goto scan
if /i "%cmd%"=="ping" goto ping
if /i "%cmd%"=="view monitor" goto viewmonitor
if /i "%cmd%"=="switch" goto switch
if "%cmd:~0,3%"=="buy" goto buy
if /i "%cmd%"=="confirm" goto confirm_buy
if /i "%cmd%"=="deny" goto deny_buy
if /i "%cmd%"=="cls" cls & goto loop

:: Moon shortcuts
if /i "%cmd%"=="exp" echo Routing to Experimentation... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="ass" echo Routing to Assurance... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="vow" echo Routing to Vow... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="off" echo Routing to Offense... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="mar" echo Routing to March... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="ren" echo Routing to Rend... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="din" echo Routing to Dine... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="tit" echo Routing to Titan... & timeout /t 2 >nul & echo Arrived. & goto loop
if /i "%cmd%"=="com" echo Routing to The Company Building... & timeout /t 2 >nul & echo Arrived. & goto loop

echo Unknown command. Type HELP for list.
goto loop

:help
cls
echo Available commands:
echo   HELP               - Show this list
echo   MOONS              - List available moons
echo   STORE              - View Company Store
echo   BESTIARY           - View scanned creatures
echo   SCAN               - Scan current area (simulated)
echo   PING [name]        - Ping radar booster
echo   VIEW MONITOR       - View ship monitor
echo   SWITCH [player]    - Switch monitor to player
echo   BUY [item] [qty]   - Order item (e.g. BUY SHOVEL 2)
echo   CONFIRM / DENY     - Confirm/deny purchase
echo   CLEAR / CLS        - Clear screen
echo   EXIT               - Log out
echo.
echo Moon shortcuts: EXP ASS VOW OFF MAR REN DIN TIT COM
echo.
pause
cls
goto loop

:moons
cls
echo Available Moons:
echo   Experimentation     (Hazard: D, Scrap: Medium)
echo   Assurance           (Hazard: C, Scrap: High)
echo   Vow                 (Hazard: B, Scrap: Medium)
echo   Offense             (Hazard: B, Scrap: High)
echo   March               (Hazard: D, Scrap: Low)
echo   Rend                (Hazard: A, Scrap: Very High)
echo   Dine                (Hazard: A, Scrap: High)
echo   Titan               (Hazard: S, Scrap: Extreme)
echo   71-Gordion (Company) (Quota delivery only)
echo.
echo Type shortcut (e.g. EXP) to route.
pause
cls
goto loop

:store
cls
echo Company Store:
echo   Shovel          $30
echo   Flashlight      $25
echo   Walkie-Talkie   $12
echo   Lockpicker      $35
echo   Boombox         $60
echo   Stun Grenade    $40
echo   Jetpack         $700
echo   Extension Ladder $100
echo.
echo Type BUY [item] [quantity] to order (e.g. BUY SHOVEL 3)
pause
cls
goto loop

:bestiary
cls
echo Bestiary Entries:
echo   Hoarding Bug      - Steals scrap, harmless unless provoked
echo   Coil-Head         - Don't look away or it snaps your neck
echo   Bracken           - Stalks quietly, hates eye contact
echo   Jester            - Plays music... then bad things happen
echo   Ghost Girl        - Haunts players, very dangerous
echo   Spider            - Venomous, web traps
echo   Bunker Spider     - Big, fast, deadly
echo   Thumper           - Charges at high speed
echo.
echo Scan more creatures in-game to unlock entries.
pause
cls
goto loop

:scan
cls
echo Scanning area...
timeout /t 2 >nul
echo Found: 3 scrap items nearby. Value estimate: $87
echo No immediate threats detected.
pause
cls
goto loop

:ping
cls
echo Pinging radar booster...
timeout /t 1 >nul
echo *beep* Booster pinged. Location marked on monitor.
pause
cls
goto loop

:viewmonitor
cls
echo Switching to ship monitor view...
timeout /t 2 >nul
echo [SIMULATED MONITOR] Crew status: All alive. Ship integrity: 100%%
echo Outside: %random% scrap detected.
pause
cls
goto loop

:switch
cls
echo Usage: SWITCH [playername] (e.g. SWITCH Chase)
echo [SIMULATED] Switched to helmet cam of %cmd:~7%.
pause
cls
goto loop

:buy
set "item=%cmd:~4%"
cls
echo Purchasing %item%... Confirm? (type CONFIRM or DENY)
set "buy_item=%item%"
set "buy_pending=1"
goto loop

:confirm_buy
if "%buy_pending%"=="1" (
    cls
    echo Order confirmed! %buy_item% en route (delivery in ~60 seconds).
    timeout /t 2 >nul
    echo Rocket drop incoming... *music plays*
    set "buy_pending="
) else (
    echo Nothing to confirm.
)
cls
goto loop

:deny_buy
if "%buy_pending%"=="1" (
    cls
    echo Order cancelled.
    set "buy_pending="
) else (
    echo Nothing to deny.
)
cls
goto loop

:end
cls
echo Logging out...
echo.
echo Thank you for your service.
echo THE COMPANY APPRECIATES YOUR SACRIFICE.
timeout /t 3 >nul
exit
