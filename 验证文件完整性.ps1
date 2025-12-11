# 验证网站文件完整性脚本
Write-Host "Checking website file integrity..." -ForegroundColor Green

# 检查关键文件是否存在
$requiredFiles = @(
    "index.html",
    "css/style.css", 
    "js/main.js",
    "images/LOGO图标.jpg",
    "admin/index.html",
    "api/data.json"
)

Write-Host "`nChecking required files:" -ForegroundColor Yellow
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "OK - $file" -ForegroundColor Green
    } else {
        Write-Host "MISSING - $file" -ForegroundColor Red
    }
}

# 检查index.html中的备案号代码
Write-Host "`nChecking ICP record code:" -ForegroundColor Yellow
$indexContent = Get-Content "index.html" -Raw
if ($indexContent -match "粤ICP备18106452号") {
    Write-Host "OK - ICP record code correct" -ForegroundColor Green
} else {
    Write-Host "ERROR - ICP record code missing or incorrect" -ForegroundColor Red
}

# 检查LOGO路径
Write-Host "`nChecking LOGO path:" -ForegroundColor Yellow
if ($indexContent -match "images/LOGO图标.jpg") {
    Write-Host "OK - LOGO path correct" -ForegroundColor Green
} else {
    Write-Host "ERROR - LOGO path incorrect" -ForegroundColor Red
}

# 检查备案号链接
Write-Host "`nChecking ICP record link:" -ForegroundColor Yellow
if ($indexContent -match "beian.miit.gov.cn") {
    Write-Host "OK - ICP record link correct" -ForegroundColor Green
} else {
    Write-Host "ERROR - ICP record link missing" -ForegroundColor Red
}

Write-Host "`nVerification completed!" -ForegroundColor Cyan
Write-Host "If all checks are OK, local files are correct." -ForegroundColor Cyan
Write-Host "The issue is with GitHub deployment." -ForegroundColor Cyan