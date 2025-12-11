# 深度OSS诊断脚本
Write-Host "========================================" -ForegroundColor Green
Write-Host "         深度OSS诊断工具" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# 1. 测试直接访问
Write-Host "1. 测试直接访问OSS..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -UseBasicParsing
    Write-Host "   ✓ 状态码: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "   ✓ Content-Type: $($response.Headers['Content-Type'])" -ForegroundColor Green
    Write-Host "   ✓ 文件大小: $($response.RawContentLength) 字节" -ForegroundColor Green
    
    # 检查是否是下载
    if ($response.Headers['Content-Type'] -like "*application/octet-stream*" -or $response.Headers['Content-Type'] -like "*application/force-download*") {
        Write-Host "   ⚠️ 检测到下载模式 (Content-Type: $($response.Headers['Content-Type']))" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ✗ 访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# 2. 测试index.html直接访问
Write-Host "2. 测试index.html直接访问..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -UseBasicParsing
    Write-Host "   ✓ 状态码: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "   ✓ Content-Type: $($response.Headers['Content-Type'])" -ForegroundColor Green
} catch {
    Write-Host "   ✗ 访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# 3. 检查静态网站端点
Write-Host "3. 检查静态网站端点..." -ForegroundColor Cyan
try {
    # 测试静态网站专用端点
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/" -UseBasicParsing
    Write-Host "   ✓ 根目录访问正常" -ForegroundColor Green
} catch {
    Write-Host "   ✗ 根目录访问失败" -ForegroundColor Red
}

Write-Host ""

# 4. 诊断可能的问题
Write-Host "4. 问题诊断..." -ForegroundColor Cyan
Write-Host ""
Write-Host "🔍 可能的问题原因：" -ForegroundColor Yellow
Write-Host ""
Write-Host "A. 静态网站托管配置问题：" -ForegroundColor White
Write-Host "   - 虽然开启了静态网站，但配置可能不正确" -ForegroundColor White
Write-Host "   - 默认首页设置错误" -ForegroundColor White
Write-Host "   - 静态网站功能未完全生效" -ForegroundColor White
Write-Host ""
Write-Host "B. 文件Content-Type问题：" -ForegroundColor White
Write-Host "   - HTML文件被设置为下载类型" -ForegroundColor White
Write-Host "   - 文件元数据配置错误" -ForegroundColor White
Write-Host ""
Write-Host "C. 地域配置问题：" -ForegroundColor White
Write-Host "   - 深圳地域的特殊配置要求" -ForegroundColor White
Write-Host "   - 跨地域访问限制" -ForegroundColor White
Write-Host ""

# 5. 解决方案
Write-Host "5. 解决方案建议：" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎯 立即检查以下配置：" -ForegroundColor Green
Write-Host ""
Write-Host "1. 重新检查静态网站配置：" -ForegroundColor White
Write-Host "   - 进入OSS控制台 → financial-tax-website" -ForegroundColor White
Write-Host "   - 基础设置 → 静态页面" -ForegroundColor White
Write-Host "   - 确认『静态页面』状态为『开启』" -ForegroundColor White
Write-Host "   - 确认『默认首页』设置为『index.html』" -ForegroundColor White
Write-Host "   - 点击『保存』" -ForegroundColor White
Write-Host ""
Write-Host "2. 检查文件Content-Type：" -ForegroundColor White
Write-Host "   - 进入『文件管理』" -ForegroundColor White
Write-Host "   - 检查index.html的Content-Type应为『text/html』" -ForegroundColor White
Write-Host "   - 如果不是，需要重新上传或修改元数据" -ForegroundColor White
Write-Host ""
Write-Host "3. 尝试重新上传文件：" -ForegroundColor White
Write-Host "   - 删除现有的index.html文件" -ForegroundColor White
Write-Host "   - 重新上传正确的index.html文件" -ForegroundColor White
Write-Host "   - 确保上传时Content-Type自动设置为text/html" -ForegroundColor White
Write-Host ""
Write-Host "4. 检查地域特殊配置：" -ForegroundColor White
Write-Host "   - 深圳地域可能需要特殊配置" -ForegroundColor White
Write-Host "   - 确认Bucket地域为『华北2（北京）』或『华东1（杭州）』" -ForegroundColor White
Write-Host "   - 如果不是，考虑迁移到标准地域" -ForegroundColor White

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "诊断完成" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green