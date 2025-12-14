@echo off
title 一键启动网站服务
echo ================================================
echo 一键启动网站服务
echo 广东深圳市龙岗区龙岗街道龙岗路东森大厦 0755-8521-6839
echo ================================================
echo.

:: 检查Python环境
echo 正在检查Python环境...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 错误: 未找到Python环境，请先安装Python
    echo 请访问 https://www.python.org/downloads/ 下载安装Python
    pause
    exit /b 1
)
echo ✅ Python环境检查通过

:: 启动服务器
echo.
echo 🚀 正在启动网站服务器...
echo 服务器启动后会自动打开浏览器
echo 如果浏览器未自动打开，请手动访问: http://localhost:63141
echo.
echo 按 Ctrl+C 停止服务器
python browser_server.py

:: 如果服务器意外停止
echo.
echo ❌ 服务器已停止
pause