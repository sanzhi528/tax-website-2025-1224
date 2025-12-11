Write-Host "===== 403 Forbidden错误深度诊断 =====" -ForegroundColor Red
Write-Host ""

Write-Host "1. 测试根目录访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Method Head -TimeoutSec 10
    Write-Host "✓ 根目录访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ 根目录访问失败: $($_.Exception.Message)" -ForegroundColor Red
    if($_.Exception.Response) {
        Write-Host "   HTTP状态码: $($_.Exception.Response.StatusCode)" -ForegroundColor Red
    }
}
Write-Host ""

Write-Host "2. 测试具体文件访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -Method Head -TimeoutSec 10
    Write-Host "✓ 文件访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ 文件访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "3. 测试带Referer头的访问..." -ForegroundColor Yellow
try {
    $headers = @{
        "Referer" = "http://www.0slm.com.cn"
    }
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Method Head -Headers $headers -TimeoutSec 10
    Write-Host "✓ 带Referer访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ 带Referer访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "4. 测试User-Agent模拟浏览器..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Method Head -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -TimeoutSec 10
    Write-Host "✓ 浏览器模拟访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ 浏览器模拟访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "===== 403错误原因分析 =====" -ForegroundColor Red
Write-Host ""
Write-Host "根目录403但文件能访问200，表明：" -ForegroundColor Cyan
Write-Host "1. ❌ Bucket Policy策略限制（最可能）" -ForegroundColor Red
Write-Host "2. ❌ 防盗链设置启用" -ForegroundColor Red
Write-Host "3. ❌ 地域访问限制" -ForegroundColor Red
Write-Host "4. ❌ RAM权限策略冲突" -ForegroundColor Red
Write-Host ""
Write-Host "立即需要检查的高级配置：" -ForegroundColor Cyan
Write-Host "- Bucket → 权限管理 → Bucket Policy（检查是否有策略）"
Write-Host "- Bucket → 权限管理 → 防盗链（检查Referer白名单）"
Write-Host "- RAM控制台 → 权限策略（检查公共访问限制）"
Write-Host ""
Write-Host "建议操作：" -ForegroundColor Cyan
Write-Host "1. 暂时禁用所有Bucket Policy"
Write-Host "2. 暂时关闭防盗链设置"
Write-Host "3. 测试访问是否恢复正常"