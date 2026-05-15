@echo off
setlocal enabledelayedexpansion

echo Setting up Docker REMOTE Version
echo ================================

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

:: Generate secret (42 characters, alphanumeric)
set "SECRET="
for /L %%i in (1,1,42) do (
    set /a "rand=!random! %% 62"
    for %%c in (!rand!) do set "SECRET=!SECRET!!chars:~%%c,1!"
)

:: Display generated credentials
echo.
echo Generated Credentials:
echo ======================
echo USERNAME: !USERNAME!
echo PASSWORD: !PASSWORD!
echo SECRET: !SECRET!
echo ENCRYPTION: 128
echo.

:: Update .env file for REMOTE version
echo Configuring .env for REMOTE version...

:: Create .env with REMOTE configuration (encryption only for OBS)
echo GLOBAL_RIST_VERSION=0.0.20 >> .env
echo. >> .env
echo ###### OBS and Relay via Internet ###### >> .env
echo. >> .env
echo RIST_AUTHARGUMENTS="&username=!USERNAME!&password=!PASSWORD!" >> .env
echo RIST_AUTHARGUMENTS_FORWARDER="aes-type=128&secret=!SECRET!" >> .env

echo.
echo REMOTE Version Configuration Complete!
echo ======================================
echo RIST Receiver Auth: username=!USERNAME!, password=!PASSWORD! + encryption
echo RIST Forwarder Auth: encryption only ^(for OBS compatibility^)
echo Encryption: aes-type=128
echo.
echo To start the services, run: docker-compose up -d
echo Credentials are stored in the .env file
echo.
echo Press any key to close this window...
pause >nul
