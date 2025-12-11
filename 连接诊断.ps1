Write-Host "===== 连接拒绝问题诊断 =====" -ForegroundColor Yellow
Write-Host ""

Write-Host "1. 检查DNS解析..." -ForegroundColor Green
nslookup www.0slm.com.cn
Write-Host ""

Write-Host "2. 测试网络连通性..." -ForegroundColor Green
try {
    $pingResult = Test-Connection -ComputerName "financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Count 2 -Quiet
    if ($pingResult) {
        Write-Host "✓ 网络连通性正常" -ForegroundColor Green
    } else {
        Write-Host "✗ 网络连通性异常" -ForegroundColor Red
    }
} catch {
    Write-Host "✗ 网络连通性测试失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "3. 测试HTTP连接..." -ForegroundColor Green
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -Method Head -TimeoutSec 10
    Write-Host "✓ HTTP连接成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ HTTP连接失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "4. 测试具体文件访问..." -ForegroundColor Green
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -Method Head -TimeoutSec 10
    Write-Host "✓ 文件访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "✗ 文件访问失败: $($_.Exception.Message)" -ForegroundColor Red
}
Write-Host ""

Write-Host "===== 诊断结果分析 =====" -ForegroundColor Yellow
Write-Host ""
Write-Host "如果出现'连接被拒绝'错误，最可能的原因：" -ForegroundColor Cyan
Write-Host "1. ❌ 静态网站托管未开启（最可能）" -ForegroundColor Red
Write-Host "2. ❌ Bucket权限设置错误" -ForegroundColor Red
Write-Host "3. ❌ 地域配置不匹配" -ForegroundColor Red
Write-Host "4. ❌ 阿里云服务端问题" -ForegroundColor Red
Write-Host ""
Write-Host "立即需要检查：" -ForegroundColor Cyan
Write-Host "- 登录阿里云OSS控制台"
Write-Host "- 进入Bucket: financial-tax-website"
Write-Host "- 检查'基础设置' -> '静态页面'是否已开启"
Write-Host "- 如果没有开启，立即开启并配置默认首页index.html"