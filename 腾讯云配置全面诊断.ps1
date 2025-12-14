# 腾讯云配置全面诊断脚本
Write-Host "=== 腾讯云配置全面诊断 ===" -ForegroundColor Cyan

# 1. 检查DNS解析
Write-Host "`n1. 检查DNS解析..." -ForegroundColor Yellow
$dnsResult = nslookup www.0slm.com.cn 2>&1
Write-Host "DNS解析结果:" -ForegroundColor Green
$dnsResult

# 2. 检查COS存储桶直接访问
Write-Host "`n2. 检查COS存储桶直接访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://finance-tax-website-1257296270.cos.ap-guangzhou.myqcloud.com/" -Method Head -ErrorAction Stop
    Write-Host "COS存储桶访问成功!" -ForegroundColor Green
    Write-Host "状态码: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "内容类型: $($response.Headers['Content-Type'])" -ForegroundColor Green
} catch {
    Write-Host "COS存储桶访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

# 3. 检查CDN域名访问
Write-Host "`n3. 检查CDN域名访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "https://www.0slm.com.cn/" -Method Head -ErrorAction Stop
    Write-Host "CDN域名访问成功!" -ForegroundColor Green
    Write-Host "状态码: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "服务器: $($response.Headers['Server'])" -ForegroundColor Green
} catch {
    Write-Host "CDN域名访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

# 4. 检查HTTP访问（无HTTPS）
Write-Host "`n4. 检查HTTP访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://www.0slm.com.cn/" -Method Head -ErrorAction Stop
    Write-Host "HTTP访问成功!" -ForegroundColor Green
    Write-Host "状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "HTTP访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

# 5. 诊断建议
Write-Host "`n=== 诊断建议 ===" -ForegroundColor Cyan
Write-Host "`n可能的问题及解决方案:" -ForegroundColor Yellow

Write-Host "`n1. COS存储桶配置问题:" -ForegroundColor Red
Write-Host "   - 检查存储桶权限是否设置为'公有读私有写'"
Write-Host "   - 检查是否开启了'静态网站'功能"
Write-Host "   - 检查索引文档是否设置为'index.html'"
Write-Host "   - 检查存储桶中是否已上传网站文件"

Write-Host "`n2. CDN配置问题:" -ForegroundColor Red
Write-Host "   - 检查CDN源站配置是否正确指向COS存储桶"
Write-Host "   - 检查CDN是否已开启HTTPS加速"
Write-Host "   - 检查CDN缓存配置"

Write-Host "`n3. 域名备案问题:" -ForegroundColor Red
Write-Host "   - 检查域名0slm.com.cn是否已完成备案"
Write-Host "   - 检查备案信息是否与腾讯云账号一致"

Write-Host "`n4. 证书问题:" -ForegroundColor Red
Write-Host "   - 检查HTTPS证书是否已配置"
Write-Host "   - 检查证书是否已生效"

Write-Host "`n=== 紧急操作步骤 ===" -ForegroundColor Cyan
Write-Host "1. 立即登录腾讯云COS控制台: https://console.cloud.tencent.com/cos"
Write-Host "2. 检查存储桶 'finance-tax-website-1257296270' 的以下配置:"
Write-Host "   - 权限管理 -> 设置为'公有读私有写'"
Write-Host "   - 基础配置 -> 静态网站 -> 开启并设置索引文档为index.html"
Write-Host "3. 上传网站文件到存储桶根目录:"
Write-Host "   - index.html, css/style.css, js/main.js, images/文件夹"
Write-Host "4. 登录CDN控制台: https://console.cloud.tencent.com/cdn"
Write-Host "5. 检查域名配置和HTTPS证书状态"
Write-Host "6. 如果问题持续，立即联系腾讯云技术支持: 95716"

Write-Host "`n诊断完成!" -ForegroundColor Green