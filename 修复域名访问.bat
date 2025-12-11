@echo off
echo ========================================
echo           域名访问修复工具
echo ========================================
echo.
echo 正在检查域名配置...
echo.

REM 检查CNAME文件
echo 检查CNAME文件...
if exist CNAME (
    echo ✅ CNAME文件存在
    type CNAME
) else (
    echo ❌ CNAME文件不存在
)

REM 检查Vercel配置文件
echo.
echo 检查Vercel配置文件...
if exist vercel.json (
    echo ✅ vercel.json文件存在
    findstr "alias" vercel.json
) else (
    echo ❌ vercel.json文件不存在
)

REM 检查重定向文件
echo.
echo 检查重定向文件...
if exist _redirects (
    echo ✅ _redirects文件存在
) else (
    echo ❌ _redirects文件不存在
)

echo.
echo ========================================
echo 域名配置检查完成！
echo.
echo 需要部署到Vercel才能使域名生效：
echo 1. 将整个项目上传到GitHub
echo 2. 在Vercel中导入项目
echo 3. 配置域名：www.0slm.com.cn 和 www.ninsuna.com
echo 4. 等待DNS解析生效（通常需要几分钟到几小时）
echo.
echo 当前可用的本地测试地址：
echo http://localhost:8000
echo http://localhost:8080
echo.
echo ========================================
pause