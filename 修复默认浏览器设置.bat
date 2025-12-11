@echo off
echo ========================================
echo         修复默认浏览器设置
echo ========================================
echo.
echo 问题：OSS链接被360软件管家劫持
echo 解决方案：重置默认浏览器设置
echo.

echo 步骤1：检查当前默认浏览器...
reg query "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /v ProgId 2>nul
echo.

echo 步骤2：重置HTTP协议关联...
reg delete "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /f 2>nul
echo.

echo 步骤3：重置HTTPS协议关联...
reg delete "HKCU\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" /f 2>nul
echo.

echo 步骤4：设置默认浏览器为Edge...
start ms-settings:defaultapps
echo.

echo ========================================
echo             操作说明
echo ========================================
echo.
echo 1. 系统将打开"默认应用"设置页面
echo 2. 在"Web浏览器"部分，选择"Microsoft Edge"
echo 3. 或者选择您喜欢的其他浏览器（如Chrome、Firefox）
echo 4. 关闭设置页面
echo.
echo 5. 重新尝试访问OSS链接：
echo    http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo.
echo 注意：如果问题仍然存在，请手动卸载360软件管家
echo.
pause