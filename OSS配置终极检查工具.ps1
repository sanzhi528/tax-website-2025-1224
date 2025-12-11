# OSS配置终极检查工具
# 用于诊断阿里云OSS静态网站配置问题

Write-Host "=== OSS静态网站配置终极检查 ===" -ForegroundColor Green
Write-Host "检查时间: $(Get-Date)" -ForegroundColor Yellow
Write-Host ""

# 1. 检查域名解析
Write-Host "1. 检查域名解析状态..." -ForegroundColor Cyan
$ossDomain = "financial-tax-website.oss-cn-shenzhen.aliyuncs.com"
$customDomain = "www.0slm.com.cn"

try {
    $ossResult = nslookup $ossDomain 2>$null
    if ($ossResult -match "Address:") {
        Write-Host "   ✅ OSS域名解析正常: $ossDomain" -ForegroundColor Green
    } else {
        Write-Host "   ❌ OSS域名解析失败: $ossDomain" -ForegroundColor Red
    }
} catch {
    Write-Host "   ❌ OSS域名解析失败: $ossDomain" -ForegroundColor Red
}

try {
    $customResult = nslookup $customDomain 2>$null
    if ($customResult -match "Address:") {
        Write-Host "   ✅ 自定义域名解析正常: $customDomain" -ForegroundColor Green
    } else {
        Write-Host "   ❌ 自定义域名解析失败: $customDomain" -ForegroundColor Red
    }
} catch {
    Write-Host "   ❌ 自定义域名解析失败: $customDomain" -ForegroundColor Red
}

Write-Host ""

# 2. 检查网站访问
Write-Host "2. 检查网站访问状态..." -ForegroundColor Cyan
$testUrls = @(
    "http://$ossDomain",
    "http://$ossDomain/index.html",
    "https://$ossDomain",
    "https://$ossDomain/index.html"
)

foreach ($url in $testUrls) {
    try {
        $response = Invoke-WebRequest -Uri $url -TimeoutSec 10 -ErrorAction Stop
        Write-Host "   ✅ $url - 状态码: $($response.StatusCode)" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ $url - 访问失败: $($_.Exception.Message)" -ForegroundColor Red
    }
    Start-Sleep -Milliseconds 500
}

Write-Host ""

# 3. 生成检查清单
Write-Host "3. OSS配置检查清单:" -ForegroundColor Cyan
Write-Host "   [ ] 登录阿里云OSS控制台: https://oss.console.aliyun.com" -ForegroundColor Yellow
Write-Host "   [ ] 选择Bucket: financial-tax-website" -ForegroundColor Yellow
Write-Host "   [ ] 检查文件管理:" -ForegroundColor Yellow
Write-Host "       - index.html 是否存在" -ForegroundColor White
Write-Host "       - css/style.css 是否存在" -ForegroundColor White
Write-Host "       - js/main.js 是否存在" -ForegroundColor White
Write-Host "       - images/LOGO图标.jpg 是否存在" -ForegroundColor White
Write-Host "   [ ] 检查文件权限:" -ForegroundColor Yellow
Write-Host "       - 所有网站文件权限应为'公共读'" -ForegroundColor White
Write-Host "   [ ] 检查静态网站配置:" -ForegroundColor Yellow
Write-Host "       - 基础设置 → 静态页面 → 已开启" -ForegroundColor White
Write-Host "       - 默认首页: index.html" -ForegroundColor White
Write-Host "       - 默认404页: error.html 或 index.html" -ForegroundColor White
Write-Host "   [ ] 检查域名绑定:" -ForegroundColor Yellow
Write-Host "       - 传输管理 → 域名管理" -ForegroundColor White
Write-Host "       - 确认 www.0slm.com.cn 已绑定" -ForegroundColor White
Write-Host "   [ ] 检查CNAME记录:" -ForegroundColor Yellow
Write-Host "       - 记录值应为: financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -ForegroundColor White

Write-Host ""
Write-Host "4. 常见问题解决方案:" -ForegroundColor Cyan
Write-Host "   🔧 如果文件不存在: 重新上传整个网站文件夹" -ForegroundColor Magenta
Write-Host "   🔧 如果权限不对: 批量设置为'公共读'" -ForegroundColor Magenta
Write-Host "   🔧 如果静态网站未开启: 重新开启并保存" -ForegroundColor Magenta
Write-Host "   🔧 如果域名解析失败: 检查CNAME记录格式" -ForegroundColor Magenta

Write-Host ""
Write-Host "=== 检查完成 ===" -ForegroundColor Green
Write-Host "编码问题已修复" -ForegroundColor Blue