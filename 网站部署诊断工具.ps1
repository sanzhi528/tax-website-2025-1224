# 网站部署诊断工具
Write-Host "=== 网站部署问题诊断 ===" -ForegroundColor Cyan

# 检查域名解析
Write-Host "`n1. 检查域名解析..." -ForegroundColor Yellow
$domains = @("www.0slm.cn", "www.0slm.com")

foreach ($domain in $domains) {
    try {
        $result = Resolve-DnsName $domain -Type A -ErrorAction SilentlyContinue
        if ($result) {
            Write-Host "✅ $domain 解析到: $($result.IPAddress)" -ForegroundColor Green
        } else {
            Write-Host "❌ $domain 解析失败" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ $domain DNS解析错误: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 检查网站响应头（判断部署服务）
Write-Host "`n2. 检查部署服务类型..." -ForegroundColor Yellow
$urls = @("http://www.0slm.cn", "http://www.0slm.com")

foreach ($url in $urls) {
    try {
        $response = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 10
        Write-Host "✅ $url 响应状态: $($response.StatusCode)" -ForegroundColor Green
        
        # 检查服务器类型
        if ($response.Headers["Server"]) {
            Write-Host "   服务器: $($response.Headers['Server'])" -ForegroundColor Gray
        }
        if ($response.Headers["X-Powered-By"]) {
            Write-Host "   技术栈: $($response.Headers['X-Powered-By'])" -ForegroundColor Gray
        }
        if ($response.Headers["X-GitHub-Request-Id"]) {
            Write-Host "   🔍 检测到GitHub Pages部署" -ForegroundColor Green
        }
        
    } catch {
        Write-Host "❌ $url 请求失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 检查GitHub Pages配置
Write-Host "`n3. 检查可能的部署配置问题..." -ForegroundColor Yellow
Write-Host "   📋 常见问题排查:" -ForegroundColor White
Write-Host "   • GitHub Pages是否启用并指向正确分支" -ForegroundColor Gray
Write-Host "   • 仓库中是否有CNAME文件指向正确域名" -ForegroundColor Gray
Write-Host "   • 是否使用了自定义域名而非GitHub.io域名" -ForegroundColor Gray
Write-Host "   • 部署是否成功（检查GitHub Actions状态）" -ForegroundColor Gray

Write-Host "`n4. 解决方案建议:" -ForegroundColor Yellow
Write-Host "   🔧 立即操作:" -ForegroundColor White
Write-Host "   • 检查GitHub仓库的Pages设置" -ForegroundColor Gray
Write-Host "   • 确认CNAME文件内容为: www.0slm.cn 和 www.0slm.com" -ForegroundColor Gray
Write-Host "   • 清除CDN缓存（如果使用了CDN服务）" -ForegroundColor Gray
Write-Host "   • 等待DNS完全生效（最长48小时）" -ForegroundColor Gray

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan