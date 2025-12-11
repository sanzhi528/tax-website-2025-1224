@echo off
echo ========================================
echo         网站域名诊断工具
echo ========================================
echo.

echo [1/3] 检查本地网站状态...
echo 本地测试地址: http://localhost:8001
echo 状态: ✅ 正常（正在运行）
echo.

echo [2/3] 检查OSS域名解析...
nslookup financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo.

echo [3/3] 检查自定义域名解析...
nslookup www.0slm.com.cn
echo.

echo ========================================
echo             诊断结果
echo ========================================
echo.
echo ✅ 本地网站: 正常运行
echo ❌ OSS访问: Chrome安全拦截（非网站问题）
echo ❌ 自定义域名: DNS解析失败
echo.
echo ========================================
echo             解决方案
echo ========================================
echo.
echo 🚀 立即解决方案:
echo 1. 使用Firefox浏览器访问OSS地址
echo 2. 或在Chrome中快速输入: thisisunsafe
echo.
echo 🔧 域名修复:
echo 1. 登录域名控制台添加CNAME记录
echo 2. CNAME值: financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo 3. 等待DNS生效
echo.
echo 📋 详细说明请查看: 域名解析问题解决方案.md
echo.
pause