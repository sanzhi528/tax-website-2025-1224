# 阿里云OSS上传工具
# 需要先安装阿里云CLI工具：pip install aliyun-python-sdk-core aliyun-python-sdk-oss2

Write-Host "=== 阿里云OSS文件上传工具 ===" -ForegroundColor Cyan

# 检查Python和阿里云SDK
Write-Host "`n检查环境..." -ForegroundColor Yellow
try {
    $pythonCheck = python --version 2>&1
    Write-Host "Python版本: $pythonCheck" -ForegroundColor Green
} catch {
    Write-Host "未安装Python，请先安装Python 3.6+" -ForegroundColor Red
    exit 1
}

Write-Host "`n上传文件列表:" -ForegroundColor Yellow
Write-Host "- index.html"
Write-Host "- css/style.css"
Write-Host "- js/main.js"
Write-Host "- images/LOGO图标.jpg"

Write-Host "`n手动上传步骤:" -ForegroundColor Cyan
Write-Host "1. 登录阿里云OSS控制台: https://oss.console.aliyun.com"
Write-Host "2. 选择存储桶: financial-tax-website1 (杭州)"
Write-Host "3. 点击'上传文件'"
Write-Host "4. 选择本地文件上传"
Write-Host "5. 确保文件权限设置为'公共读'"

Write-Host "`n如果浏览器上传失败，尝试以下方法:" -ForegroundColor Red
Write-Host "- 清除浏览器缓存和Cookie"
Write-Host "- 使用无痕/隐私模式"
Write-Host "- 更换浏览器"
Write-Host "- 检查网络连接"
Write-Host "- 暂时关闭VPN/代理"

Write-Host "`n备用方案：使用OSS Browser客户端" -ForegroundColor Green
Write-Host "下载地址: https://help.aliyun.com/document_detail/209974.html"
Write-Host "使用图形化界面工具上传，更稳定可靠"

Write-Host "`n诊断完成!" -ForegroundColor Green