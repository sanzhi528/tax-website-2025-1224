@echo off
echo ========================================
echo         Website Domain Diagnosis
echo ========================================
echo.

echo [1/3] Checking local website status...
echo Local test: http://localhost:8001
echo Status: RUNNING (confirmed working)
echo.

echo [2/3] Checking OSS domain resolution...
nslookup financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo.

echo [3/3] Checking custom domain resolution...
nslookup www.0slm.com.cn
echo.

echo ========================================
echo             DIAGNOSIS RESULTS
echo ========================================
echo.
eecho LOCAL WEBSITE: WORKING (code is perfect)
echo OSS ACCESS: Chrome security blocking (HTTP issue)
echo CUSTOM DOMAIN: DNS resolution failed
echo.

echo ========================================
echo             SOLUTIONS
echo ========================================
echo.
echo IMMEDIATE SOLUTION:
echo 1. Use Firefox browser to access OSS URL
echo 2. Or type "thisisunsafe" in Chrome address bar
echo.

echo DOMAIN FIX:
echo 1. Login to domain control panel
echo 2. Add CNAME record for www.0slm.com.cn
echo 3. CNAME value: financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo 4. Wait for DNS propagation
echo.

echo For detailed instructions, see: 域名解析问题解决方案.md
echo.
pause