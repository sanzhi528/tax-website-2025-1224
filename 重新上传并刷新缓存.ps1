# Reupload files to Tencent Cloud COS and refresh CDN cache
Write-Host "Reupload files to Tencent Cloud COS and refresh CDN cache" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Yellow

# Check essential files
$essentialFiles = @("index.html", "admin/index.html", "api/data.json", "css/style.css", "js/main.js", "images/LOGO图标.jpg")

Write-Host "Checking local files..." -ForegroundColor Cyan
foreach ($file in $essentialFiles) {
    if (Test-Path $file) {
        Write-Host "✅ $file exists" -ForegroundColor Green
    } else {
        Write-Host "❌ $file missing" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Important Steps:" -ForegroundColor Yellow
Write-Host "1. Login to Tencent Cloud Console (https://console.cloud.tencent.com/cos)" -ForegroundColor White
Write-Host "2. Go to your bucket" -ForegroundColor White
Write-Host "3. Upload the following updated files:" -ForegroundColor White
Write-Host "   - index.html (updated contact info)" -ForegroundColor White
Write-Host "   - admin/index.html (updated contact info)" -ForegroundColor White
Write-Host "   - api/data.json (updated contact info)" -ForegroundColor White
Write-Host "4. After upload, go to CDN console to refresh cache" -ForegroundColor White
Write-Host ""

Write-Host "Updated contact information:" -ForegroundColor Cyan
Write-Host "Email: 1006993710@qq.com" -ForegroundColor White
Write-Host "Address: Guangdong Shenzhen Longgang District Longgang Street Longgang Road Dongshen Building" -ForegroundColor White
Write-Host ""

Write-Host "CDN cache refresh steps:" -ForegroundColor Yellow
Write-Host "1. Login to CDN console (https://console.cloud.tencent.com/cdn)" -ForegroundColor White
Write-Host "2. Select your domain" -ForegroundColor White
Write-Host "3. Click 'Refresh Preload'" -ForegroundColor White
Write-Host "4. Select 'URL Refresh'" -ForegroundColor White
Write-Host "5. Enter the following URLs to refresh:" -ForegroundColor White
Write-Host "   - https://www.0slm.com/" -ForegroundColor White
Write-Host "   - https://www.0slm.com/index.html" -ForegroundColor White
Write-Host "   - https://www.0slm.com/admin/index.html" -ForegroundColor White
Write-Host "6. Click 'Submit'" -ForegroundColor White
Write-Host ""

Write-Host "After cache refresh, wait 5-10 minutes to see the updates" -ForegroundColor Green
Write-Host "If still showing old content, try clearing browser cache (Ctrl+Shift+Delete)" -ForegroundColor Green