# 简单文件结构检查脚本
Write-Host "=== 文件结构检查 ===" -ForegroundColor Green

# 检查文件夹
Write-Host "检查文件夹结构..." -ForegroundColor Yellow
if (Test-Path "admin") { Write-Host "✓ admin文件夹存在" -ForegroundColor Green } else { Write-Host "✗ admin文件夹缺失" -ForegroundColor Red }
if (Test-Path "css") { Write-Host "✓ css文件夹存在" -ForegroundColor Green } else { Write-Host "✗ css文件夹缺失" -ForegroundColor Red }
if (Test-Path "images") { Write-Host "✓ images文件夹存在" -ForegroundColor Green } else { Write-Host "✗ images文件夹缺失" -ForegroundColor Red }
if (Test-Path "js") { Write-Host "✓ js文件夹存在" -ForegroundColor Green } else { Write-Host "✗ js文件夹缺失" -ForegroundColor Red }
if (Test-Path "api") { Write-Host "✓ api文件夹存在" -ForegroundColor Green } else { Write-Host "✗ api文件夹缺失" -ForegroundColor Red }

Write-Host ""
Write-Host "检查关键文件..." -ForegroundColor Yellow
if (Test-Path "index.html") { Write-Host "✓ index.html存在" -ForegroundColor Green } else { Write-Host "✗ index.html缺失" -ForegroundColor Red }
if (Test-Path "css/style.css") { Write-Host "✓ css/style.css存在" -ForegroundColor Green } else { Write-Host "✗ css/style.css缺失" -ForegroundColor Red }
if (Test-Path "images/LOGO图标.jpg") { Write-Host "✓ images/LOGO图标.jpg存在" -ForegroundColor Green } else { Write-Host "✗ images/LOGO图标.jpg缺失" -ForegroundColor Red }
if (Test-Path "js/main.js") { Write-Host "✓ js/main.js存在" -ForegroundColor Green } else { Write-Host "✗ js/main.js缺失" -ForegroundColor Red }

Write-Host ""
Write-Host "=== 问题诊断 ===" -ForegroundColor Cyan
Write-Host "您的网站无法访问的根本原因：" -ForegroundColor White
Write-Host "1. 文件上传时未保持文件夹结构" -ForegroundColor Red
Write-Host "2. 所有文件平铺在OSS根目录，破坏了资源引用路径" -ForegroundColor Red
Write-Host "3. index.html中引用的css/style.css等文件无法找到" -ForegroundColor Red

Write-Host ""
Write-Host "=== 解决方案 ===" -ForegroundColor Cyan
Write-Host "1. 登录阿里云OSS控制台：https://oss.console.aliyun.com" -ForegroundColor White
Write-Host "2. 进入Bucket：financial-tax-website" -ForegroundColor White
Write-Host "3. 删除所有现有文件" -ForegroundColor White
Write-Host "4. 使用'上传文件夹'功能上传整个'网站建设'文件夹" -ForegroundColor White
Write-Host "5. 确保勾选'保持文件夹结构'选项" -ForegroundColor White
Write-Host "6. 设置所有文件权限为'公共读'" -ForegroundColor White

Write-Host ""
Write-Host "修复完成后访问：http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com" -ForegroundColor Yellow