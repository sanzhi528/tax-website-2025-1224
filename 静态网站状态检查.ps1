Write-Host "===== 静态网站托管状态检查 =====" -ForegroundColor Yellow
Write-Host ""

Write-Host "1. 检查普通OSS域名访问..." -ForegroundColor Green
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -Method Head -TimeoutSec 10
    Write-Host "✓ 文件访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ 文件访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "2. 检查普通OSS根目录访问..." -ForegroundColor Green
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Method Head -TimeoutSec 10
    Write-Host "✓ 根目录访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ 根目录访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "3. 测试可能的静态网站域名..." -ForegroundColor Cyan
$possibleDomains = @(
    "http://financial-tax-website.oss-website-cn-shenzhen.aliyuncs.com",
    "http://financial-tax-website.website-cn-shenzhen.aliyuncs.com",
    "http://financial-tax-website.oss-static-cn-shenzhen.aliyuncs.com"
)

foreach ($domain in $possibleDomains) {
    try {
        $response = Invoke-WebRequest -Uri $domain -Method Head -TimeoutSec 5
        Write-Host "✓ 静态网站域名可用: $domain - 状态码: $($response.StatusCode)" -ForegroundColor Green
    } catch {
        Write-Host "✗ 静态网站域名不可用: $domain" -ForegroundColor Red
    }
}
Write-Host ""

Write-Host "===== 诊断结果 =====" -ForegroundColor Yellow
Write-Host ""
Write-Host "如果所有静态网站域名都不可用，说明：" -ForegroundColor Red
Write-Host "1. ❌ 静态网站托管未正确开启" -ForegroundColor Red
Write-Host "2. ❌ 静态网站服务未生效" -ForegroundColor Red
Write-Host "3. ❌ 阿里云服务端问题" -ForegroundColor Red
Write-Host ""
Write-Host "立即需要执行的操作：" -ForegroundColor Cyan
Write-Host "1. 重新开启静态网站托管（先关闭再开启）"
Write-Host "2. 检查静态页面设置中的专用访问域名"
Write-Host "3. 使用专用域名测试访问"