@echo off
chcp 65001 >nul
echo 正在复制www.0slm.com网站文件到目标文件夹...

rem 创建目标文件夹（如果不存在）
if not exist "E:\0slm网站建设\0slm.com网站建设" (
    mkdir "E:\0slm网站建设\0slm.com网站建设"
)

rem 复制核心文件
copy "E:\20251124\网站建设\index.html" "E:\0slm网站建设\0slm.com网站建设\" /Y
copy "E:\20251124\网站建设\login.html" "E:\0slm网站建设\0slm.com网站建设\" /Y
copy "E:\20251124\网站建设\consult.html" "E:\0slm网站建设\0slm.com网站建设\" /Y
copy "E:\20251124\网站建设\service-detail.html" "E:\0slm网站建设\0slm.com网站建设\" /Y

rem 复制CSS文件夹
if not exist "E:\0slm网站建设\0slm.com网站建设\css" (
    mkdir "E:\0slm网站建设\0slm.com网站建设\css"
)
copy "E:\20251124\网站建设\css\style.css" "E:\0slm网站建设\0slm.com网站建设\css\" /Y

rem 复制JS文件夹
if not exist "E:\0slm网站建设\0slm.com网站建设\js" (
    mkdir "E:\0slm网站建设\0slm.com网站建设\js"
)
copy "E:\20251124\网站建设\js\main.js" "E:\0slm网站建设\0slm.com网站建设\js\" /Y

rem 复制images文件夹
if not exist "E:\0slm网站建设\0slm.com网站建设\images" (
    mkdir "E:\0slm网站建设\0slm.com网站建设\images"
)
copy "E:\20251124\网站建设\images\LOGO图标.jpg" "E:\0slm网站建设\0slm.com网站建设\images\" /Y

rem 复制配置文件
copy "E:\20251124\网站建设\.nojekyll" "E:\0slm网站建设\0slm.com网站建设\" /Y
copy "E:\20251124\网站建设\_config.yml" "E:\0slm网站建设\0slm.com网站建设\" /Y
copy "E:\20251124\网站建设\_redirects" "E:\0slm网站建设\0slm.com网站建设\" /Y
copy "E:\20251124\网站建设\vercel.json" "E:\0slm网站建设\0slm.com网站建设\" /Y
copy "E:\20251124\网站建设\package.json" "E:\0slm网站建设\0slm.com网站建设\" /Y

rem 创建正确的CNAME文件（仅包含www.0slm.com）
echo www.0slm.com > "E:\0slm网站建设\0slm.com网站建设\CNAME"

echo.
echo 文件复制完成！
echo.
echo 已复制的文件包括：
echo - 核心HTML文件（index.html, login.html, consult.html, service-detail.html）
echo - CSS样式文件
echo - JavaScript文件
echo - 图片资源
echo - 配置文件（.nojekyll, _config.yml, _redirects, vercel.json, package.json）
echo - 正确的CNAME文件（仅包含www.0slm.com）
echo.
echo 现在您可以上传 "E:\0slm网站建设\0slm.com网站建设" 文件夹到存储仓。
pause