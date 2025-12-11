# OSS文件结构修复脚本
# 用于重新组织文件结构，确保文件夹层级正确

Write-Host "=== OSS文件结构修复工具 ===" -ForegroundColor Green
Write-Host "检查当前文件结构..." -ForegroundColor Yellow

# 检查关键文件夹是否存在
$requiredFolders = @("admin", "css", "images", "js", "api")
$missingFolders = @()

foreach ($folder in $requiredFolders) {
    if (Test-Path $folder) {
        Write-Host "✓ 文件夹 '$folder' 存在" -ForegroundColor Green
    } else {
        Write-Host "✗ 文件夹 '$folder' 缺失" -ForegroundColor Red
        $missingFolders += $folder
    }
}

# 检查关键文件
$requiredFiles = @(
    @("index.html", "根目录"),
    @("css/style.css", "CSS文件夹"),
    @("images/LOGO图标.jpg", "图片文件夹"),
    @("js/main.js", "JS文件夹")
)

Write-Host ""
Write-Host "检查关键文件路径..." -ForegroundColor Yellow

foreach ($file in $requiredFiles) {
    if (Test-Path $file[0]) {
        Write-Host "✓ 文件 '$($file[0])' 存在 ($($file[1]))" -ForegroundColor Green
    } else {
        Write-Host "✗ 文件 '$($file[0])' 缺失 ($($file[1]))" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== 修复建议 ===" -ForegroundColor Cyan
Write-Host "1. 登录阿里云OSS控制台 (https://oss.console.aliyun.com)" -ForegroundColor White
Write-Host "2. 进入Bucket: financial-tax-website" -ForegroundColor White
Write-Host "3. 删除所有现有文件" -ForegroundColor White
Write-Host "4. 使用'上传文件夹'功能上传整个'网站建设'文件夹" -ForegroundColor White
Write-Host "5. 确保勾选'保持文件夹结构'选项" -ForegroundColor White
Write-Host "6. 设置所有文件权限为'公共读'" -ForegroundColor White
Write-Host ""
Write-Host "=== 验证步骤 ===" -ForegroundColor Cyan
Write-Host "上传完成后访问: http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -ForegroundColor White
Write-Host "检查网页是否能正常显示" -ForegroundColor White

Write-Host ""
Write-Host "脚本执行完成！" -ForegroundColor Green