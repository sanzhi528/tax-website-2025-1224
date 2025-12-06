@echo off
chcp 65001 >nul
echo 正在生成GitHub仓库CSS修复指南...
echo.
echo ================================================
echo            GitHub仓库CSS路径修复指南
echo ================================================
echo.
echo 问题分析：
echo GitHub仓库中style.css文件位于根目录，但index.html引用的是css/style.css
echo 这导致CSS样式无法正确加载，首页显示为竖排文本
echo.
echo 解决方案步骤：
echo.
echo 第一步：访问GitHub仓库
echo 请打开浏览器访问：https://github.com/sanzhi528/finance-tax-website-v6
echo.
echo 第二步：创建css文件夹和style.css文件
echo 1. 点击页面上的 "Add file" 按钮
echo 2. 选择 "Create new file"
echo 3. 在文件名输入框中输入：css/style.css
echo 4. 将以下CSS内容复制到文件内容区域：
echo.
echo 第三步：复制正确的CSS内容（请复制以下内容）：
echo.

:: 读取本地CSS文件内容并显示
setlocal enabledelayedexpansion
set "cssfile=E:\20251124\网站建设\css\style.css"
if exist "%cssfile%" (
    echo CSS内容开始（前100行）：
    echo ================================================
    set /a linecount=0
    for /f "usebackq delims=" %%a in ("%cssfile%") do (
        echo %%a
        set /a linecount+=1
        if !linecount! geq 100 goto :break
    )
    :break
    echo ================================================
    echo ...（完整内容共501行）
    echo.
) else (
    echo 错误：找不到CSS文件 %cssfile%
    goto :end
)

echo 第四步：提交新文件
echo 1. 滚动到页面底部
echo 2. 在提交信息框中输入：修复CSS路径问题
echo 3. 点击 "Commit new file"
echo.

echo 第五步：删除根目录的错误style.css文件
echo 1. 返回仓库根目录
echo 2. 点击根目录的style.css文件
echo 3. 点击右上角的删除按钮（垃圾桶图标）
echo 4. 在删除信息框中输入：移动CSS文件到正确位置
echo 5. 点击 "Commit changes"
echo.

echo 预期修复效果：
echo - 首页将显示水平导航栏、LOGO、网格排列的服务项目
echo - 所有样式将正常显示，包括渐变背景、按钮效果等
echo.

echo 验证方法：
echo 访问 https://sanzhi528.github.io/finance-tax-website-v6/
echo 刷新页面查看效果（可能需要等待几分钟缓存更新）
echo.

echo 注意：由于GitHub Pages缓存，可能需要等待几分钟才能看到效果
echo.
echo ================================================
echo 操作指南生成完成！请按照上述步骤操作。
echo ================================================

:end
pause