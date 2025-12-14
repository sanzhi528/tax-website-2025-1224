# Tencent Cloud COS Configuration Check Tool
Write-Host "Tencent Cloud COS Configuration Check" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Cyan

# Check local file preparation
Write-Host "`n1. Check local file preparation:" -ForegroundColor Green

$requiredFiles = @("index.html", "CNAME", ".nojekyll", "css/style.css", "js/main.js", "images/LOGO图标.jpg")

foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "✓ $file exists" -ForegroundColor Green
    } else {
        Write-Host "✗ $file missing" -ForegroundColor Red
    }
}

# Check CNAME file content
Write-Host "`n2. Check CNAME configuration:" -ForegroundColor Green
if (Test-Path "CNAME") {
    $cnameContent = Get-Content "CNAME"
    Write-Host "CNAME file content:" -ForegroundColor Cyan
    $cnameContent | ForEach-Object { Write-Host "  $_" -ForegroundColor Cyan }
}

# Check ICP备案号 configuration
Write-Host "`n3. Check ICP备案号 configuration:" -ForegroundColor Green
if (Test-Path "index.html") {
    $indexContent = Get-Content "index.html" -Raw
    if ($indexContent -match "粤ICP备18106452号") {
        Write-Host "✓ ICP备案号 configured correctly" -ForegroundColor Green
    } else {
        Write-Host "✗ ICP备案号 configuration missing" -ForegroundColor Red
    }
}

# Tencent Cloud COS configuration recommendations
Write-Host "`n4. Tencent Cloud COS configuration recommendations:" -ForegroundColor Magenta
Write-Host "Bucket Name: finance-tax-website" -ForegroundColor Cyan
Write-Host "Region: South China (Guangzhou)" -ForegroundColor Cyan
Write-Host "Access Permission: Public Read Private Write" -ForegroundColor Cyan
Write-Host "Static Website: Enabled" -ForegroundColor Cyan
Write-Host "Index Document: index.html" -ForegroundColor Cyan

Write-Host "`n5. Domain binding recommendations:" -ForegroundColor Magenta
Write-Host "Primary Domain: www.0slm.com" -ForegroundColor Cyan
Write-Host "Secondary Domain: www.0slm.cn" -ForegroundColor Cyan
Write-Host "CDN Acceleration: Global Acceleration" -ForegroundColor Cyan

Write-Host "`nCheck completed!" -ForegroundColor Yellow
Write-Host "Please create Tencent Cloud COS bucket and upload files according to the guide." -ForegroundColor Cyan