# 修复GitHub仓库CSS路径问题的PowerShell脚本
Write-Host "=== GitHub仓库CSS路径修复脚本 ===" -ForegroundColor Green
Write-Host ""

# 显示当前问题
Write-Host "问题分析:" -ForegroundColor Yellow
Write-Host "- GitHub仓库中style.css文件位于根目录，但index.html引用的是css/style.css" -ForegroundColor Red
Write-Host "- 这导致CSS样式无法正确加载，首页显示为竖排文本" -ForegroundColor Red
Write-Host ""

# 获取本地正确的CSS内容
$cssContent = Get-Content "E:\20251124\网站建设\css\style.css" -Encoding UTF8 -Raw

# 保存完整的CSS内容到文件
$cssFilePath = "E:\20251124\网站建设\完整CSS内容.txt"
Set-Content -Path $cssFilePath -Value $cssContent -Encoding UTF8

Write-Host "正确的CSS内容已保存到: $cssFilePath" -ForegroundColor Green
Write-Host "文件大小: $($cssContent.Length) 字符" -ForegroundColor Green
Write-Host ""

Write-Host "解决方案:" -ForegroundColor Yellow
Write-Host "1. 手动访问GitHub仓库: https://github.com/sanzhi528/finance-tax-website-v6" -ForegroundColor Cyan
Write-Host "2. 创建css/style.css文件并粘贴正确的CSS内容" -ForegroundColor Cyan
Write-Host "3. 删除根目录的错误style.css文件" -ForegroundColor Cyan
Write-Host ""

Write-Host "预期修复效果:" -ForegroundColor Yellow
Write-Host "- 首页将显示水平导航栏、LOGO、网格排列的服务项目" -ForegroundColor Green
Write-Host "- 所有样式将正常显示" -ForegroundColor Green
Write-Host ""

Write-Host "脚本执行完成！请按照上述步骤操作。" -ForegroundColor Green