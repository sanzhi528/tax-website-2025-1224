# 修复GitHub仓库CSS路径问题的PowerShell脚本
# 请确保您已登录GitHub账户并具有仓库的写入权限

Write-Host "=== GitHub仓库CSS路径修复脚本 ===" -ForegroundColor Green
Write-Host ""

# 显示当前问题
Write-Host "问题分析:" -ForegroundColor Yellow
Write-Host "- GitHub仓库中style.css文件位于根目录，但index.html引用的是css/style.css" -ForegroundColor Red
Write-Host "- 这导致CSS样式无法正确加载，首页显示为竖排文本" -ForegroundColor Red
Write-Host ""

# 显示解决方案步骤
Write-Host "解决方案步骤:" -ForegroundColor Yellow
Write-Host "1. 手动访问GitHub仓库: https://github.com/sanzhi528/finance-tax-website-v6" -ForegroundColor Cyan
Write-Host "2. 点击根目录的style.css文件查看内容" -ForegroundColor Cyan
Write-Host "3. 点击'Add file' -> 'Create new file'" -ForegroundColor Cyan
Write-Host "4. 输入文件路径: css/style.css" -ForegroundColor Cyan
Write-Host "5. 复制以下正确的CSS内容到新文件中:" -ForegroundColor Cyan
Write-Host ""

# 显示正确的CSS内容（简化版，避免过长）
Write-Host "正确的CSS内容（前50行）:" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

$correctCSS = Get-Content "E:\20251124\网站建设\css\style.css" -Encoding UTF8
for ($i = 0; $i -lt 50; $i++) {
    if ($i -lt $correctCSS.Length) {
        Write-Host $correctCSS[$i]
    }
}

Write-Host ""
Write-Host "... (完整内容共501行)" -ForegroundColor Gray
Write-Host ""

Write-Host "6. 滚动到页面底部，填写提交信息: '修复CSS路径问题'" -ForegroundColor Cyan
Write-Host "7. 点击'Commit new file'" -ForegroundColor Cyan
Write-Host "8. 返回仓库根目录，点击style.css文件" -ForegroundColor Cyan
Write-Host "9. 点击右上角的删除按钮（垃圾桶图标）" -ForegroundColor Cyan
Write-Host "10. 填写删除信息: '移动CSS文件到正确位置'" -ForegroundColor Cyan
Write-Host "11. 点击'Commit changes'" -ForegroundColor Cyan
Write-Host ""

Write-Host "预期修复效果:" -ForegroundColor Yellow
Write-Host "- 首页将显示水平导航栏、LOGO、网格排列的服务项目" -ForegroundColor Green
Write-Host "- 所有样式将正常显示，包括渐变背景、按钮效果等" -ForegroundColor Green
Write-Host ""

Write-Host "验证方法:" -ForegroundColor Yellow
Write-Host "- 访问 https://sanzhi528.github.io/finance-tax-website-v6/" -ForegroundColor Cyan
Write-Host "- 刷新页面查看效果" -ForegroundColor Cyan
Write-Host ""

Write-Host "注意: 由于GitHub Pages缓存，可能需要等待几分钟才能看到效果" -ForegroundColor Magenta

# 提供完整的CSS内容供复制
Write-Host ""
Write-Host "=== 完整的CSS内容（供复制） ===" -ForegroundColor Green
Write-Host "文件位置: E:\20251124\网站建设\css\style.css" -ForegroundColor Gray
Write-Host ""

# 显示完整的CSS内容到文件
$cssFilePath = "E:\20251124\网站建设\完整CSS内容.txt"
Set-Content -Path $cssFilePath -Value $correctCSS -Encoding UTF8
Write-Host "完整的CSS内容已保存到: $cssFilePath" -ForegroundColor Green
Write-Host "您可以直接打开此文件复制全部内容" -ForegroundColor Green

Write-Host ""
Write-Host "脚本执行完成！请按照上述步骤操作。" -ForegroundColor Green
Write-Host "如果遇到问题，请检查网络连接和GitHub账户权限。" -ForegroundColor Yellow