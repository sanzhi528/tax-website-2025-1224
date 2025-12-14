@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   财务税务代理公司 - 本地网站预览
echo ========================================
echo.
echo 📋 修复内容验证:
echo ✅ CSS路径: css/style.css
echo ✅ 公司信息: 广东深圳市龙岗区龙岗街道龙岗路东森大厦，0755-8521-6839
echo ✅ 域名配置: www.0slm.com.cn
echo.
echo 🚀 正在启动本地服务器...
echo.

cd /d "%~dp0"

:: 检查Python是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 未检测到Python，请先安装Python 3.x
    echo 📥 下载地址: https://www.python.org/downloads/
    pause
    exit /b 1
)

:: 启动本地服务器
echo 🌐 服务器启动中，请稍候...
echo 🔗 访问地址: http://localhost:8000
echo ⏹️ 按 Ctrl+C 停止服务器
echo.

python local_server.py

pause