# DNS配置检查脚本
Write-Host "DNS配置状态检查" -ForegroundColor Yellow
Write-Host "==================" -ForegroundColor Cyan

# 检查域名解析状态
$domains = @("www.0slm.com", "www.0slm.cn", "0slm.com", "0slm.cn")

foreach ($domain in $domains) {
    Write-Host "`n检查域名: $domain" -ForegroundColor Green
    
    try {
        # 检查A记录
        $aRecord = Resolve-DnsName $domain -Type A -ErrorAction SilentlyContinue
        if ($aRecord) {
            Write-Host "A记录: " -NoNewline
            $aRecord.IPAddress | ForEach-Object { Write-Host "$_ " -ForegroundColor Green -NoNewline }
            Write-Host ""
        }
        
        # 检查CNAME记录
        $cnameRecord = Resolve-DnsName $domain -Type CNAME -ErrorAction SilentlyContinue
        if ($cnameRecord) {
            Write-Host "CNAME记录: $($cnameRecord.NameHost)" -ForegroundColor Cyan
        } else {
            Write-Host "CNAME记录: 未检测到" -ForegroundColor Red
        }
        
        # 检查网站响应
        try {
            $response = Invoke-WebRequest -Uri "http://$domain" -TimeoutSec 10 -ErrorAction SilentlyContinue
            Write-Host "HTTP状态: $($response.StatusCode) $($response.StatusDescription)" -ForegroundColor Green
        } catch {
            Write-Host "HTTP状态: 无法访问" -ForegroundColor Red
        }
        
    } catch {
        Write-Host "DNS查询失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n检查完成！" -ForegroundColor Yellow
Write-Host "如果CNAME记录显示'未检测到'，请按照指南配置DNS解析。" -ForegroundColor Cyan