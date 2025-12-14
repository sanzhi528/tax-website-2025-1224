# DNS Configuration Check Script
Write-Host "DNS Configuration Status Check" -ForegroundColor Yellow
Write-Host "==============================" -ForegroundColor Cyan

# Check domain resolution status
$domains = @("www.0slm.com", "www.0slm.cn", "0slm.com", "0slm.cn")

foreach ($domain in $domains) {
    Write-Host "`nChecking domain: $domain" -ForegroundColor Green
    
    try {
        # Check A record
        $aRecord = Resolve-DnsName $domain -Type A -ErrorAction SilentlyContinue
        if ($aRecord) {
            Write-Host "A Record: " -NoNewline
            $aRecord.IPAddress | ForEach-Object { Write-Host "$_ " -ForegroundColor Green -NoNewline }
            Write-Host ""
        }
        
        # Check CNAME record
        $cnameRecord = Resolve-DnsName $domain -Type CNAME -ErrorAction SilentlyContinue
        if ($cnameRecord) {
            Write-Host "CNAME Record: $($cnameRecord.NameHost)" -ForegroundColor Cyan
        } else {
            Write-Host "CNAME Record: Not detected" -ForegroundColor Red
        }
        
        # Check website response
        try {
            $response = Invoke-WebRequest -Uri "http://$domain" -TimeoutSec 10 -ErrorAction SilentlyContinue
            Write-Host "HTTP Status: $($response.StatusCode) $($response.StatusDescription)" -ForegroundColor Green
        } catch {
            Write-Host "HTTP Status: Cannot access" -ForegroundColor Red
        }
        
    } catch {
        Write-Host "DNS query failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nCheck completed!" -ForegroundColor Yellow
Write-Host "If CNAME records show 'Not detected', please configure DNS resolution according to the guide." -ForegroundColor Cyan