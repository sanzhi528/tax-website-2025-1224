# 紧急网站恢复工具
# 用于诊断和恢复删除仓库后导致的网站访问问题

Write-Host "=== 紧急网站恢复诊断工具 ===" -ForegroundColor Red
Write-Host "开始诊断网站访问问题..." -ForegroundColor Yellow

# 检查域名访问状态
$domains = @("www.0slm.cn", "www.0slm.com", "sanzhi528.github.io")

foreach ($domain in $domains) {
    try {
        $url = "http://$domain"
        Write-Host "检查 $url ..." -ForegroundColor Cyan
        
        $response = Invoke-WebRequest -Uri $url -TimeoutSec 10 -ErrorAction SilentlyContinue
        
        if ($response.StatusCode -eq 200) {
            Write-Host "✓ $domain 可正常访问 (状态码: $($response.StatusCode))" -ForegroundColor Green
            
            # 检查内容是否为新版本
            if ($response.Content -match "粤ICP备18106452号") {
                Write-Host "✓ 网站显示新版本内容（包含备案号）" -ForegroundColor Green
            } else {
                Write-Host "⚠ 网站可能显示旧版本内容" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "✗ $domain 无法访问: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n=== 诊断结果和建议 ===" -ForegroundColor Magenta
Write-Host "1. 如果GitHub.io域名可访问但自定义域名不可访问：" -ForegroundColor Yellow
Write-Host "   - 问题可能在DNS配置或GitHub Pages的Custom domain设置"
Write-Host "   - 检查：https://github.com/sanzhi528/finance-tax-website-v6/settings/pages"

Write-Host "`n2. 如果所有域名都无法访问：" -ForegroundColor Yellow
Write-Host "   - GitHub Pages部署可能有问题"
Write-Host "   - 需要重新上传项目文件到仓库"

Write-Host "`n3. 紧急恢复步骤：" -ForegroundColor Green
Write-Host "   a. 访问 https://github.com/sanzhi528/finance-tax-website-v6"
Write-Host "   b. 删除所有现有文件"
Write-Host "   c. 上传本地 e:\20251124\网站建设 文件夹所有内容"
Write-Host "   d. 检查GitHub Pages设置中的Custom domain配置"
Write-Host "   e. 点击Save强制重新部署"

Write-Host "`n4. 验证本地文件完整性：" -ForegroundColor Cyan
if (Test-Path "CNAME") {
    Write-Host "✓ CNAME文件存在" -ForegroundColor Green
    Get-Content "CNAME" | Write-Host -ForegroundColor Cyan
}

if (Test-Path ".nojekyll") {
    Write-Host "✓ .nojekyll文件存在" -ForegroundColor Green
}

if (Test-Path "index.html") {
    Write-Host "✓ index.html文件存在" -ForegroundColor Green
}

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Magenta
Write-Host "请按照上述建议进行紧急恢复操作" -ForegroundColor Yellow