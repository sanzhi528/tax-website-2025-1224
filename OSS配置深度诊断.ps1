# 阿里云OSS配置深度诊断脚本
Write-Host "=== 阿里云OSS配置深度诊断 ===" -ForegroundColor Green
Write-Host ""

# 1. 检查DNS解析
Write-Host "1. DNS解析检查:" -ForegroundColor Yellow
$dnsResult = nslookup www.0slm.com.cn 2>&1
Write-Host "域名解析结果:" -ForegroundColor Cyan
$dnsResult
Write-Host ""

# 2. 检查OSS Bucket直接访问
Write-Host "2. OSS Bucket直接访问检查:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Method Head -TimeoutSec 10
    Write-Host "✅ Bucket直接访问成功" -ForegroundColor Green
    Write-Host "   状态码: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "   服务器: $($response.Headers['Server'])" -ForegroundColor Cyan
} catch {
    Write-Host "❌ Bucket直接访问失败" -ForegroundColor Red
    Write-Host "   错误信息: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# 3. 检查静态网站托管URL
Write-Host "3. 静态网站托管URL检查:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -Method Head -TimeoutSec 10
    Write-Host "✅ 静态网站文件访问成功" -ForegroundColor Green
    Write-Host "   状态码: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "   内容类型: $($response.Headers['Content-Type'])" -ForegroundColor Cyan
} catch {
    Write-Host "❌ 静态网站文件访问失败" -ForegroundColor Red
    Write-Host "   错误信息: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# 4. 检查自定义域名访问
Write-Host "4. 自定义域名访问检查:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://www.0slm.com.cn" -Method Head -TimeoutSec 10
    Write-Host "✅ 自定义域名访问成功" -ForegroundColor Green
    Write-Host "   状态码: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "   服务器: $($response.Headers['Server'])" -ForegroundColor Cyan
    Write-Host "   内容类型: $($response.Headers['Content-Type'])" -ForegroundColor Cyan
} catch {
    Write-Host "❌ 自定义域名访问失败" -ForegroundColor Red
    Write-Host "   错误信息: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# 5. 检查网络连接
Write-Host "5. 网络连接检查:\