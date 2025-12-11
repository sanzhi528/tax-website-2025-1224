@echo off
chcp 65001 >nul
title Aliyun Deployment Check Tool

echo.
echo ================================================
echo   Aliyun Deployment Check Tool
echo ================================================
echo Domain: 0slm.com.cn
echo ICP: 粤ICP备18106452号-3
echo.

:MAIN_MENU
echo Please select check item:
echo 1. Check website files integrity
echo 2. Check domain DNS status
echo 3. Test Aliyun OSS access
echo 4. Verify ICP compliance
echo 5. Generate deployment report
echo 6. Exit
echo.
set /p choice=Enter option (1-6): 

if "%choice%"=="1" goto CHECK_FILES
if "%choice%"=="2" goto CHECK_DNS
if "%choice%"=="3" goto TEST_OSS
if "%choice%"=="4" goto VERIFY_COMPLIANCE
if "%choice%"=="5" goto GENERATE_REPORT
if "%choice%"=="6" goto EXIT
echo Invalid option, please re-enter
goto MAIN_MENU

:CHECK_FILES
echo.
echo ================================================
echo   Check Website Files Integrity
echo ================================================
echo.

if exist "index.html" (
    echo [OK] index.html - exists
    for %%F in (index.html) do echo   File size: %%~zF bytes
) else (
    echo [ERROR] index.html - missing
)

if exist "style.css" (
    echo [OK] style.css - exists
    for %%F in (style.css) do echo   File size: %%~zF bytes
) else (
    echo [ERROR] style.css - missing
)

if exist "script.js" (
    echo [OK] script.js - exists
    for %%F in (script.js) do echo   File size: %%~zF bytes
) else (
    echo [ERROR] script.js - missing
)

if exist "images" (
    echo [OK] images folder - exists
    set filecount=0
    for /f %%i in ('dir /b images ^| find /c /v ""') do set filecount=%%i
    echo   Contains %filecount% files
) else (
    echo [ERROR] images folder - missing
)

echo.
echo File check completed
echo.
pause
goto MAIN_MENU

:CHECK_DNS
echo.
echo ================================================
echo   Check Domain DNS Status
echo ================================================
echo.

echo Checking domain 0slm.com.cn...
nslookup www.0slm.com.cn 2>nul
echo.

echo Checking domain ninsuna.com...
nslookup www.ninsuna.com 2>nul
echo.

echo DNS check completed
echo Note: If shows "not found", domain not correctly resolved to Aliyun
echo.
pause
goto MAIN_MENU

:TEST_OSS
echo.
echo ================================================
echo   Test Aliyun OSS Access
echo ================================================
echo.

echo Testing Aliyun OSS default domain access...
curl -I --connect-timeout 10 http://financial-tax-website.oss-cn-hangzhou.aliyuncs.com 2>nul
if %errorlevel% equ 0 (
    echo [OK] Aliyun OSS access normal
) else (
    echo [ERROR] Aliyun OSS access failed
    echo Possible reasons: bucket not created or permission issues
)

echo.
echo OSS access test completed
echo.
pause
goto MAIN_MENU

:VERIFY_COMPLIANCE
echo.
echo ================================================
echo   Verify ICP Compliance
echo ================================================
echo.

echo ICP Compliance Checklist:
echo.

echo 1. [OK] Domain ICP status: Registered (粤ICP备18106452号-3)
echo 2. [CHECK] Service provider: Aliyun (needs confirmation)
echo 3. [CHECK] Website deployment: Need to deploy to Aliyun
echo 4. [CHECK] ICP information consistency: Need to confirm
echo.

echo Compliance Requirements:
echo   • Registered domains must use the original service provider
echo   • Website must be deployed on the service provider's server
echo   • Website content must match ICP registration information
echo.

echo Current Status:
echo   [ERROR] Website not deployed on Aliyun (non-compliant)
echo   [ACTION] Need immediate deployment to Aliyun OSS
echo.

echo ICP Support:
echo   Aliyun ICP hotline: 400-850-0168
echo   ICP system: https://beian.aliyun.com
echo.

pause
goto MAIN_MENU

:GENERATE_REPORT
echo.
echo ================================================
echo   Generate Deployment Report
echo ================================================
echo.

set REPORT_FILE=Aliyun_Deployment_Report_%date:~0,4%%date:~5,2%%date:~8,2%.txt

echo Aliyun Deployment Check Report > "%REPORT_FILE%"
echo Generated: %date% %time% >> "%REPORT_FILE%"
echo ================================================ >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo Domain Information: >> "%REPORT_FILE%"
echo • Main Domain: 0slm.com.cn >> "%REPORT_FILE%"
echo • ICP Number: 粤ICP备18106452号-3 >> "%REPORT_FILE%"
echo • Service Provider: Aliyun >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo File Check Results: >> "%REPORT_FILE%"
if exist "index.html" (
    echo • index.html: exists >> "%REPORT_FILE%"
) else (
    echo • index.html: missing >> "%REPORT_FILE%"
)
if exist "style.css" (
    echo • style.css: exists >> "%REPORT_FILE%"
) else (
    echo • style.css: missing >> "%REPORT_FILE%"
)
if exist "script.js" (
    echo • script.js: exists >> "%REPORT_FILE%"
) else (
    echo • script.js: missing >> "%REPORT_FILE%"
)
echo. >> "%REPORT_FILE%"

echo Compliance Status: >> "%REPORT_FILE%"
echo • Current Status: Non-compliant (website not deployed on Aliyun) >> "%REPORT_FILE%"
echo • Risk Level: High >> "%REPORT_FILE%"
echo • Recommended Action: Immediate deployment to Aliyun OSS >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo Deployment Steps: >> "%REPORT_FILE%"
echo 1. Login to Aliyun console and enable OSS service >> "%REPORT_FILE%"
echo 2. Create bucket: financial-tax-website >> "%REPORT_FILE%"
echo 3. Upload website files to OSS >> "%REPORT_FILE%"
echo 4. Configure static website hosting >> "%REPORT_FILE%"
echo 5. Bind domain: www.0slm.com.cn >> "%REPORT_FILE%"
echo 6. Set up DNS resolution >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo Report generated: %REPORT_FILE% >> "%REPORT_FILE%"

echo [OK] Report generated: %REPORT_FILE%
echo Location: %cd%\%REPORT_FILE%
echo.

pause
goto MAIN_MENU

:EXIT
echo.
echo ================================================
echo   Thank you for using Aliyun Deployment Check Tool
echo ================================================
echo.
echo Important Reminders:
echo   • Deploy to Aliyun immediately to resolve ICP compliance
echo   • Use provided deployment scripts to simplify operations
echo   • Contact Aliyun support if needed: 95187
echo.
pause
exit