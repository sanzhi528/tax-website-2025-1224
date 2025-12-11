# 静态网站状态检查脚本
Write-Host "=== 静态网站状态检查 ===" -ForegroundColor Cyan
Write-Host ""

# 测试普通OSS域名访问
Write-Host "1. 测试普通OSS域名文件访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html" -Method Head -TimeoutSec 10 -ErrorAction Stop
    Write-Host "   文件访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "   文件访问失败 - $($_.Exception.Message)" -ForegroundColor Red
}

# 测试根目录访问
Write-Host "2. 测试根目录访问..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/" -Method Head -TimeoutSec 10 -ErrorAction Stop
    Write-Host "   根目录访问成功 - 状态码: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "   根目录访问失败 - $($_.Exception.Message)" -ForegroundColor Red
    if($_.Exception.Response) {
        Write-Host "   HTTP状态码: $($_.Exception.Response.StatusCode)" -ForegroundColor Red
    }
}

# 测试可能的静态网站域名
Write-Host "3. 测试静态网站专用域名..." -ForegroundColor Yellow

$staticDomains = @(
    "http://financial-tax-website.oss-website-cn-shenzhen.aliyuncs.com",
    "http://financial-tax-website.oss-static-website-cn-shenzhen.aliyuncs.com",
    "http://financial-tax-website.website-cn-shenzhen.aliyuncs.com"
)

foreach($domain in $staticDomains) {
    try {
        $response = Invoke-WebRequest -Uri $domain -Method Head -TimeoutSec 10 -ErrorAction Stop
        Write-Host "   $domain - 访问成功 (状态码: $($response.StatusCode))" -ForegroundColor Green
    } catch {
        if($_.Exception.Message -like "*未能解析此远程名称*") {
            Write-Host "   $domain - 域名无法解析 (静态网站未开启)" -ForegroundColor Red
        } else {
            Write-Host "   $domain - 访问失败: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "=== 诊断结果 ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "根据您的文件管理页面链接，问题分析：" -ForegroundColor Yellow
Write-Host "1. 您的文件列表页面显示正常，说明文件上传成功" -ForegroundColor White
Write-Host "2. 但静态网站功能可能未正确配置或未生效" -ForegroundColor White
Write-Host "3. 需要检查静态网站托管的精确配置" -ForegroundColor White
Write-Host ""
Write-Host "建议操作：" -ForegroundColor Green
Write-Host "1. 在OSS控制台重新检查静态网站配置" -ForegroundColor White
Write-Host "2. 确认默认首页设置为 'index.html' (精确匹配)" -ForegroundColor White
Write-Host "3. 检查是否有静态网站专用访问域名" -ForegroundColor White