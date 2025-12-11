# 域名解析配置检查工具
Write-Host "=== 域名解析配置检查 ===" -ForegroundColor Cyan
Write-Host ""

# 1. 检查DNS解析状态
Write-Host "[1/4] 检查DNS解析状态..." -ForegroundColor Yellow
$domain = "www.0slm.com.cn"
Write-Host "域名: $domain"

try {
    $result = nslookup $domain 2>&1
    Write-Host "DNS解析结果:" -ForegroundColor Green
    $result | ForEach-Object { Write-Host $_ }
} catch {
    Write-Host "DNS解析失败: $_" -ForegroundColor Red
}
Write-Host ""

# 2. 检查OSS域名状态
Write-Host "[2/4] 检查OSS域名状态..." -ForegroundColor Yellow
$ossDomain = "financial-tax-website.oss-cn-shenzhen.aliyuncs.com"
Write-Host "OSS域名: $ossDomain"

try {
    $response = Invoke-WebRequest -Uri "http://$ossDomain" -UseBasicParsing -TimeoutSec 10
    Write-Host "OSS访问状态: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "响应大小: $($response.Content.Length) 字节"
} catch {
    Write-Host "OSS访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

# 3. 检查域名解析配置
Write-Host "[3/4] 域名解析配置检查..." -ForegroundColor Yellow
Write-Host "域名: www.0slm.com.cn"
Write-Host "应该指向: financial-tax-website.oss-cn-shenzhen.aliyuncs.com"
Write-Host ""

# 4. 常见问题诊断
Write-Host "[4/4] 常见问题诊断..." -ForegroundColor Yellow
Write-Host "1. OSS静态网站托管是否开启?" -ForegroundColor White
Write-Host "2. Bucket权限是否设置为'公共读'?" -ForegroundColor White
Write-Host "3. 域名是否已完成备案?" -ForegroundColor White
Write-Host "4. CNAME记录是否正确配置?" -ForegroundColor White
Write-Host ""

Write-Host "=== 解决方案建议 ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. 登录阿里云OSS控制台检查:" -ForegroundColor Green
Write-Host "   - 确认静态网站托管已开启"
Write-Host "   - 确认默认首页为index.html"
Write-Host "   - 确认Bucket权限为'公共读'"
Write-Host ""
Write-Host "2. 登录腾讯云DNS检查:" -ForegroundColor Green
Write-Host "   - 确认www.0slm.com.cn的CNAME记录"
Write-Host "   - 记录值应为: financial-tax-website.oss-cn-shenzhen.aliyuncs.com"
Write-Host ""
Write-Host "3. 域名备案检查:" -ForegroundColor Green
Write-Host "   - 确认0slm.com.cn已完成ICP备案"
Write-Host "   - 备案信息与域名注册信息一致"
Write-Host ""
Write-Host "4. 测试访问:" -ForegroundColor Green
Write-Host "   - 直接访问OSS: http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com"
Write-Host "   - 测试自定义域名: http://www.0slm.com.cn"
Write-Host ""

Write-Host "按任意键继续..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")