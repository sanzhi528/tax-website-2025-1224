# 修复OSS静态网站配置问题
Write-Host "========================================" -ForegroundColor Green
Write-Host "        修复OSS静态网站配置" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "问题：OSS链接点击后变成下载而不是显示网页" -ForegroundColor Yellow
Write-Host "原因：静态网站托管功能未开启或配置错误" -ForegroundColor Yellow
Write-Host ""

Write-Host "步骤1：检查当前OSS访问状态..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -UseBasicParsing
    Write-Host "✓ OSS访问正常，状态码: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "  内容类型: $($response.Headers['Content-Type'])" -ForegroundColor Green
    Write-Host "  文件大小: $($response.RawContentLength) 字节" -ForegroundColor Green
} catch {
    Write-Host "✗ OSS访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "步骤2：诊断问题原因..." -ForegroundColor Cyan
Write-Host ""
Write-Host "🔍 可能的原因：" -ForegroundColor Yellow
Write-Host "1. 静态网站托管功能未开启" -ForegroundColor Yellow
Write-Host "2. 默认首页未设置为index.html" -ForegroundColor Yellow
Write-Host "3. Bucket权限设置错误" -ForegroundColor Yellow
Write-Host "4. 文件Content-Type设置错误" -ForegroundColor Yellow

Write-Host ""
Write-Host "步骤3：解决方案..." -ForegroundColor Cyan
Write-Host ""
Write-Host "🎯 立即操作指南：" -ForegroundColor Green
Write-Host ""
Write-Host "1. 登录阿里云OSS控制台：" -ForegroundColor White
Write-Host "   https://oss.console.aliyun.com/" -ForegroundColor White
Write-Host ""
Write-Host "2. 找到Bucket：financial-tax-website" -ForegroundColor White
Write-Host ""
Write-Host "3. 开启静态网站托管：" -ForegroundColor White
Write-Host "   - 左侧菜单 → 基础设置 → 静态页面" -ForegroundColor White
Write-Host "   - 开启『静态页面』功能" -ForegroundColor White
Write-Host "   - 设置默认首页：index.html" -ForegroundColor White
Write-Host "   - 设置默认404页：index.html (可选)" -ForegroundColor White
Write-Host ""
Write-Host "4. 检查Bucket权限：" -ForegroundColor White
Write-Host "   - 左侧菜单 → 权限管理 → 读写权限" -ForegroundColor White
Write-Host "   - 设置为『公共读』" -ForegroundColor White
Write-Host ""
Write-Host "5. 验证修复效果：" -ForegroundColor White
Write-Host "   - 重新访问：http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -ForegroundColor White
Write-Host "   - 应该显示网站而不是下载" -ForegroundColor White

Write-Host ""
Write-Host "备用解决方案：" -ForegroundColor Cyan
Write-Host "1. 使用本地服务器：http://localhost:8001" -ForegroundColor White
Write-Host "2. 使用Vercel部署：https://vercel.com" -ForegroundColor White
Write-Host "3. 使用GitHub Pages部署" -ForegroundColor White

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "操作完成后，请重新测试OSS链接" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

# 测试直接访问index.html
try {
    Write-Host ""
    Write-Host "测试直接访问index.html..." -ForegroundColor Cyan
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -UseBasicParsing
    Write-Host "✓ index.html访问正常" -ForegroundColor Green
} catch {
    Write-Host "✗ index.html访问失败" -ForegroundColor Red
}

Read-Host "按回车键退出..."