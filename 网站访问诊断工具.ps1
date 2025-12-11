# 网站访问诊断工具
# 用于诊断阿里云OSS网站无法访问的问题

Write-Host "=== 阿里云OSS网站访问诊断工具 ===" -ForegroundColor Green
Write-Host ""

# 检查域名解析
Write-Host "1. 检查DNS解析状态..." -ForegroundColor Yellow
$domain = "www.0slm.com.cn"
$nslookupResult = nslookup $domain 2>$null
Write-Host "域名: $domain"
if ($nslookupResult -match "Aliases:") {
    Write-Host "✓ DNS解析正常" -ForegroundColor Green
    $nslookupResult | Select-String "Aliases:" | ForEach-Object {
        Write-Host "  别名: $($_.ToString().Split(':')[1].Trim())"
    }
    $nslookupResult | Select-String "Address:" | ForEach-Object {
        if ($_.ToString() -notmatch "^服务器:") {
            Write-Host "  IP地址: $($_.ToString().Split(':')[1].Trim())"
        }
    }
} else {
    Write-Host "✗ DNS解析失败" -ForegroundColor Red
}

Write-Host ""

# 检查HTTP连接
Write-Host "2. 检查HTTP连接状态..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$domain" -TimeoutSec 10 -ErrorAction Stop
    Write-Host "✓ HTTP连接成功" -ForegroundColor Green
    Write-Host "  状态码: $($response.StatusCode)"
    Write-Host "  内容类型: $($response.Headers['Content-Type'])"
} catch {
    Write-Host "✗ HTTP连接失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# 检查OSS Bucket访问
Write-Host "3. 检查OSS Bucket直接访问..." -ForegroundColor Yellow
$bucketUrl = "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com"
try {
    $bucketResponse = Invoke-WebRequest -Uri $bucketUrl -TimeoutSec 10 -ErrorAction Stop
    Write-Host "✓ OSS Bucket直接访问成功" -ForegroundColor Green
    Write-Host "  状态码: $($bucketResponse.StatusCode)"
} catch {
    Write-Host "✗ OSS Bucket直接访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# 检查静态网站托管
Write-Host "4. 检查静态网站托管配置..." -ForegroundColor Yellow
$staticSiteUrl = "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html"
try {
    $staticResponse = Invoke-WebRequest -Uri $staticSiteUrl -TimeoutSec 10 -ErrorAction Stop
    Write-Host "✓ 静态网站托管配置正常" -ForegroundColor Green
    Write-Host "  状态码: $($staticResponse.StatusCode)"
} catch {
    Write-Host "✗ 静态网站托管配置异常: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "  可能原因:" -ForegroundColor Yellow
    Write-Host "  - 静态网站托管未开启"
    Write-Host "  - index.html文件不存在"
    Write-Host "  - Bucket权限未设置为公共读"
}

Write-Host ""
Write-Host "=== 诊断完成 ===" -ForegroundColor Green
Write-Host ""
Write-Host "建议解决方案:" -ForegroundColor Cyan
Write-Host "1. 登录阿里云OSS控制台检查Bucket配置"
Write-Host "2. 确认静态网站托管已开启"
Write-Host "3. 确认权限设置为'公共读'"
Write-Host "4. 确认index.html文件已上传"
Write-Host "5. 检查域名绑定状态"
Write-Host ""
Write-Host "按任意键退出..."
Read-Host "按Enter键退出"