@echo off
setlocal enabledelayedexpansion

echo Setting up Docker HOME Version
echo ==============================

:: Generate random credentials
echo Generating random credentials...

:: Generate username with "moo-" prefix (max 22 characters total, so 18 random chars)
set "chars=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
set "USERNAME=moo-"
for /L %%i in (1,1,18) do (
    set /a "rand=!random! %% 62"
    for %%c in (!rand!) do set "USERNAME=!USERNAME!!chars:~%%c,1!"
)

:: Generate password (30 characters, alphanumeric)
set "PASSWORD="
for /L %%i in (1,1,30) do (
    set /a "rand=!random! %% 62"
    for %%c in (!rand!) do set "PASSWORD=!PASSWORD!!chars:~%%c,1!"
)

:: Display generated credentials
echo.
echo Generated Credentials:
echo ======================
echo USERNAME: !USERNAME!
echo PASSWORD: !PASSWORD!
echo.

:: Update .env file for HOME version
echo Configuring .env for HOME version...

:: Create .env with HOME configuration only (username/password, no encryption)
echo GLOBAL_RIST_VERSION=0.0.20 >> .env
echo. >> .env
echo ##### Home network setup ####### >> .env
echo. >> .env
echo RIST_AUTHARGUMENTS="&username=!USERNAME!&password=!PASSWORD!" >> .env
echo RIST_AUTHARGUMENTS_FORWARDER= >> .env

echo.
echo HOME Version Configuration Complete!
echo ====================================
echo RIST Receiver Auth: username=!USERNAME!, password=!PASSWORD!
echo RIST Forwarder Auth: None ^(empty^)
echo No encryption - for home network use only
echo.
echo To start the services, run: docker-compose up -d
echo Credentials are stored in the .env file
echo.
echo Press any key to close this window...
pause >nul
