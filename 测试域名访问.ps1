# 域名访问测试脚本
Write-Host "=== 域名访问测试 ===" -ForegroundColor Cyan
Write-Host ""

# 测试自定义域名
$domain = "www.0slm.com.cn"
Write-Host "[1/3] 测试自定义域名访问..." -ForegroundColor Yellow
Write-Host "域名: $domain"

try {
    $response = Invoke-WebRequest -Uri "http://$domain" -UseBasicParsing -TimeoutSec 10
    Write-Host "访问状态: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "响应大小: $($response.Content.Length) 字节"
    Write-Host "标题: $($response.ParsedHtml.title)" -ForegroundColor Green
} catch {
    Write-Host "访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# 测试OSS直接访问
$ossDomain = "financial-tax-website.oss-cn-shenzhen.aliyuncs.com"
Write-Host "[2/3] 测试OSS直接访问..." -ForegroundColor Yellow
Write-Host "OSS域名: $ossDomain"

try {
    $response = Invoke-WebRequest -Uri "http://$ossDomain" -UseBasicParsing -TimeoutSec 10
    Write-Host "访问状态: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "响应大小: $($response.Content.Length) 字节"
    Write-Host "标题: $($response.ParsedHtml.title)" -ForegroundColor Green
} catch {
    Write-Host "访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# 测试本地访问
$localDomain = "localhost:8001"
Write-Host "[3/3] 测试本地访问..." -ForegroundColor Yellow
Write-Host "本地: $localDomain"

try {
    $response = Invoke-WebRequest -Uri "http://$localDomain" -UseBasicParsing -TimeoutSec 10
    Write-Host "访问状态: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "响应大小: $($response.Content.Length) 字节"
    Write-Host "标题: $($response.ParsedHtml.title)" -ForegroundColor Green
} catch {
    Write-Host "访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "=== 测试完成 ===" -ForegroundColor Cyan
Write-Host "按任意键继续..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")