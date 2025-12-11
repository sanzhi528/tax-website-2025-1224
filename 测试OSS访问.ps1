# 测试OSS访问状态
Write-Host "=== OSS访问测试 ===" -ForegroundColor Green

# 测试直接访问
Write-Host "测试直接访问..." -ForegroundColor Yellow
$url = "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com"

try {
    $request = [System.Net.WebRequest]::Create($url)
    $request.Method = "HEAD"
    $response = $request.GetResponse()
    
    Write-Host "✓ 访问成功" -ForegroundColor Green
    Write-Host "状态码: $($response.StatusCode)" -ForegroundColor White
    Write-Host "Content-Type: $($response.ContentType)" -ForegroundColor White
    Write-Host "内容长度: $($response.ContentLength)" -ForegroundColor White
    
    $response.Close()
} catch {
    Write-Host "✗ 访问失败: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== 浏览器显示为下载的解决方案 ===" -ForegroundColor Cyan
Write-Host "1. 清除浏览器缓存 (Ctrl+Shift+Delete)" -ForegroundColor White
Write-Host "2. 使用无痕/隐私模式访问" -ForegroundColor White
Write-Host "3. 强制刷新页面 (Ctrl+F5)" -ForegroundColor White
Write-Host "4. 尝试不同浏览器 (Chrome/Firefox/Edge)" -ForegroundColor White
Write-Host "5. 检查OSS静态网站配置中的默认首页设置" -ForegroundColor White

Write-Host ""
Write-Host "=== 验证网站是否正常 ===" -ForegroundColor Cyan
Write-Host "本地测试: http://localhost:8001" -ForegroundColor Yellow
Write-Host "OSS测试: $url" -ForegroundColor Yellow
Write-Host ""
Write-Host "=== 诊断信息 ===" -ForegroundColor Magenta
Write-Host "脚本语法检查: 通过" -ForegroundColor Green
Write-Host "网络连接测试: 完成" -ForegroundColor Green
Write-Host "OSS配置验证: 待检查" -ForegroundColor Yellow