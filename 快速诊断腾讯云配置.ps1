# 快速诊断腾讯云COS和CDN配置问题
Write-Host "=== 腾讯云网站配置快速诊断 ===" -ForegroundColor Cyan

# 1. 检查DNS解析
Write-Host "`n1. 检查DNS解析状态..." -ForegroundColor Yellow
$dnsResult = nslookup www.0slm.com.cn 2>&1
Write-Host "DNS解析结果:" -ForegroundColor Green
$dnsResult | ForEach-Object { Write-Host $_ }

# 2. 检查HTTP访问
Write-Host "`n2. 检查HTTP访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://www.0slm.com.cn/" -Method Head -TimeoutSec 10
    Write-Host "✅ HTTP访问正常 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "❌ HTTP访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

# 3. 检查HTTPS访问  
try {
    $response = Invoke-WebRequest -Uri "https://www.0slm.com.cn/" -Method Head -TimeoutSec 10
    Write-Host "✅ HTTPS访问正常 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "❌ HTTPS访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

# 4. 诊断建议
Write-Host "`n=== 诊断结果和建议 ===" -ForegroundColor Cyan

Write-Host "`n可能的问题:" -ForegroundColor Yellow
Write-Host "1. 腾讯云COS存储桶未开启静态网站功能" -ForegroundColor Red
Write-Host "2. CDN加速域名未正确配置" -ForegroundColor Red  
Write-Host "3. HTTPS证书未配置或未生效" -ForegroundColor Red
Write-Host "4. 存储桶权限设置问题" -ForegroundColor Red
Write-Host "5. 源站配置错误" -ForegroundColor Red

Write-Host "`n立即操作步骤:" -ForegroundColor Green
Write-Host "1. 登录腾讯云COS控制台: https://console.cloud.tencent.com/cos" -ForegroundColor White
Write-Host "2. 检查存储桶是否开启'静态网站'功能" -ForegroundColor White
Write-Host "3. 登录腾讯云CDN控制台: https://console.cloud.tencent.com/cdn" -ForegroundColor White
Write-Host "4. 检查域名 www.0slm.com.cn 的CDN配置" -ForegroundColor White
Write-Host "5. 确认HTTPS证书状态" -ForegroundColor White
Write-Host "6. 上传网站文件到COS存储桶" -ForegroundColor White

Write-Host "`n需要上传的文件:" -ForegroundColor Magenta
Write-Host "- index.html (主页面)" -ForegroundColor White
Write-Host "- css/style.css (样式文件)" -ForegroundColor White
Write-Host "- js/main.js (脚本文件)" -ForegroundColor White
Write-Host "- images/ (图片文件夹)" -ForegroundColor White

Write-Host "`n如果问题持续，联系腾讯云技术支持: 95716" -ForegroundColor Cyan