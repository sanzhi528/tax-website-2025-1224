# Quick Website Diagnosis Tool
Write-Host "Checking website status..." -ForegroundColor Yellow

# Check domains
$domains = @("www.0slm.cn", "www.0slm.com", "sanzhi528.github.io")

foreach ($domain in $domains) {
    try {
        $url = "http://$domain"
        Write-Host "Testing $url" -ForegroundColor Cyan
        
        $response = Invoke-WebRequest -Uri $url -TimeoutSec 5
        Write-Host "Status: $($response.StatusCode)" -ForegroundColor Green
    } catch {
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Diagnosis completed" -ForegroundColor Magenta