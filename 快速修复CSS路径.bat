@echo off
echo 财税咨询公司网站CSS路径修复指南
echo ================================
echo.
echo 问题诊断：GitHub仓库中的style.css文件在根目录，但index.html引用css/style.css
echo.
echo 解决方案：需要将style.css文件移动到css文件夹中
echo.
echo 请按照以下步骤操作：
echo 1. 访问 https://github.com/sanzhi528/finance-tax-website-v6
echo 2. 找到并点击 style.css 文件（在根目录）
echo 3. 点击右上角的编辑按钮（铅笔图标）
echo 4. 将文件内容复制到剪贴板
echo 5. 点击"Add file" → "Create new file"
echo 6. 输入文件名：css/style.css
echo 7. 粘贴刚才复制的CSS内容
echo 8. 填写提交信息："移动CSS文件到css文件夹"
echo 9. 点击"Commit changes"
echo 10. 回到style.css文件页面，点击删除按钮
echo 11. 填写提交信息："删除根目录的CSS文件"
echo 12. 点击"Commit changes"
echo.
echo 等待2-3分钟后访问：https://sanzhi528.github.io/finance-tax-website-v6/
echo.
echo 预期效果：首页显示正常的导航栏和样式
echo.
pause