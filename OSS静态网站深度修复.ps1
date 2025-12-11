# OSS静态网站深度修复脚本
Write-Host "=== OSS静态网站深度诊断 ===" -ForegroundColor Green

# 测试根域名访问
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Method Head -ErrorAction Stop
    Write-Host "✅ 根域名访问成功: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "❌ 根域名访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

# 测试index.html文件访问
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -Method Head -ErrorAction Stop
    Write-Host "✅ index.html访问成功: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "❌ index.html访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== 问题诊断 ===" -ForegroundColor Yellow
Write-Host "1. 根域名访问失败但index.html可访问，说明静态网站托管功能未生效" -ForegroundColor Yellow
Write-Host "2. 可能原因：" -ForegroundColor Yellow
Write-Host "   - 静态网站配置未正确保存" -ForegroundColor Yellow
Write-Host "   - 配置缓存未更新" -ForegroundColor Yellow
Write-Host "   - 地域配置不匹配" -ForegroundColor Yellow

Write-Host ""
Write-Host "=== 修复方案 ===" -ForegroundColor Cyan
Write-Host "1. 重新配置静态网站：关闭 → 等待30秒 → 重新开启" -ForegroundColor Cyan
Write-Host "2. 检查Bucket地域：确保是 oss-cn-shenzhen" -ForegroundColor Cyan
Write-Host "3. 强制刷新：修改任意设置并保存两次" -ForegroundColor Cyan
Write-Host "4. 等待5-10分钟让配置生效" -ForegroundColor Cyan

Write-Host ""
Write-Host "=== 验证方法 ===" -ForegroundColor Magenta
Write-Host "修复后测试: http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -ForegroundColor Magenta
Write-Host "预期结果: 200 OK，网页正常显示" -ForegroundColor Magenta