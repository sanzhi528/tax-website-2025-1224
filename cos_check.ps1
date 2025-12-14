# Simple COS Configuration Check
Write-Host "COS Configuration Check" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Cyan

# Check essential files
$files = @("index.html", "CNAME", ".nojekyll", "css/style.css", "js/main.js", "images/LOGO图标.jpg")

Write-Host "Checking essential files:" -ForegroundColor Green
foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "OK - $file" -ForegroundColor Green
    } else {
        Write-Host "MISSING - $file" -ForegroundColor Red
    }
}

# Check CNAME content
Write-Host "`nCNAME file content:" -ForegroundColor Cyan
if (Test-Path "CNAME") {
    Get-Content "CNAME" | ForEach-Object { Write-Host "  $_" -ForegroundColor Cyan }
}

Write-Host "`nCheck completed!" -ForegroundColor Yellow