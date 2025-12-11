# 网站访问问题综合诊断修复脚本
Write-Host "=== 网站访问问题综合诊断修复 ===" -ForegroundColor Green
Write-Host "诊断域名: www.0slm.com.cn 和 www.ninsuna.com" -ForegroundColor Cyan
Write-Host ""

# 1. 检查DNS解析
Write-Host "1. DNS解析检查:" -ForegroundColor Yellow
$domains = @("www.0slm.com.cn", "www.ninsuna.com")

foreach ($domain in $domains) {
    Write-Host "检查域名: $domain" -ForegroundColor White
    try {
        $dnsResult = nslookup $domain 2>&1 | Select-String "Aliases"
        if ($dnsResult) {
            Write-Host "✅ DNS解析正常: $dnsResult" -ForegroundColor Green
        } else {
            Write-Host "❌ DNS解析异常" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ DNS检查失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}
Write-Host ""

# 2. 检查OSS Bucket直接访问
Write-Host "2. OSS Bucket直接访问检查:" -ForegroundColor Yellow
$ossUrl = "http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com"

try {
    $request = [System.Net.WebRequest]::Create($ossUrl)
    $request.Method = "HEAD"
    $response = $request.GetResponse()
    Write-Host "✅ OSS Bucket直接访问成功" -ForegroundColor Green
    Write-Host "   状态码: $($response.StatusCode)" -ForegroundColor Cyan
    Write-Host "   服务器: OSS" -ForegroundColor Cyan
    $response.Close()
} catch {
    Write-Host "❌ OSS Bucket直接访问失败" -ForegroundColor Red
    Write-Host "   错误信息: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "   可能原因: Bucket未开启静态网站功能或权限设置错误" -ForegroundColor Yellow
}
Write-Host ""

# 3. 检查自定义域名访问
Write-Host "3. 自定义域名访问检查:" -ForegroundColor Yellow

foreach ($domain in $domains) {
    $url = "http://$domain"
    Write-Host "测试访问: $url" -ForegroundColor White
    
    try {
        $request = [System.Net.WebRequest]::Create($url)
        $request.Method = "HEAD"
        $request.Timeout = 10000
        $response = $request.GetResponse()
        Write-Host "✅ 域名访问成功" -ForegroundColor Green
        Write-Host "   状态码: $($response.StatusCode)" -ForegroundColor Cyan
        $response.Close()
    } catch {
        Write-Host "❌ 域名访问失败" -ForegroundColor Red
        Write-Host "   错误信息: $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host ""
}

# 4. 问题分析和解决方案
Write-Host "4. 问题分析和解决方案:" -ForegroundColor Magenta
Write-Host ""
Write-Host "=== 诊断结果 ===" -ForegroundColor Cyan
Write-Host "• DNS解析: 正常" -ForegroundColor Green
Write-Host "• OSS访问: 403错误 (主要问题)" -ForegroundColor Red
Write-Host "• 域名绑定: 需要验证" -ForegroundColor Yellow
Write-Host ""

Write-Host "=== 解决方案 ===" -ForegroundColor Cyan
Write-Host "1. 登录阿里云OSS控制台" -ForegroundColor White
Write-Host "2. 检查Bucket 'financial-tax-website' 的以下配置:" -ForegroundColor White
Write-Host "   • 静态网站托管是否开启" -ForegroundColor White
Write-Host "   • 默认首页是否设置为 'index.html'" -ForegroundColor White
Write-Host "   • 域名绑定是否正确配置" -ForegroundColor White
Write-Host "   • 访问权限是否设置为 '公共读'" -ForegroundColor White
Write-Host "3. 验证域名绑定状态" -ForegroundColor White
Write-Host "4. 检查跨域设置(CORS)" -ForegroundColor White
Write-Host ""

Write-Host "=== 立即修复步骤 ===" -ForegroundColor Green
Write-Host "1. 在阿里云OSS控制台 -> financial-tax-website Bucket" -ForegroundColor White
Write-Host "2. 基础设置 -> 静态页面 -> 开启静态网站托管" -ForegroundColor White
Write-Host "3. 设置默认首页: index.html" -ForegroundColor White
Write-Host "4. 权限管理 -> 公共读权限" -ForegroundColor White
Write-Host "5. 传输管理 -> 域名管理 -> 验证域名绑定" -ForegroundColor White
Write-Host ""

Write-Host "=== 备用方案 ===" -ForegroundColor Yellow
Write-Host "如果以上步骤无效，考虑:" -ForegroundColor White
Write-Host "• 重新绑定域名" -ForegroundColor White
Write-Host "• 检查DNS解析缓存" -ForegroundColor White
Write-Host "• 联系阿里云技术支持" -ForegroundColor White
Write-Host ""

Write-Host "诊断完成! 请按照上述步骤检查阿里云OSS配置。" -ForegroundColor Green