@echo off
echo ===== 阿里云OSS网站诊断 =====
echo.

echo 1. 检查DNS解析...
nslookup www.0slm.com.cn
echo.

echo 2. 检查OSS Bucket直接访问...
curl -I http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo.

echo 3. 检查静态网站文件...
curl -I http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html
echo.

echo 4. 检查自定义域名访问...
curl -I http://www.0slm.com.cn
echo.

echo ===== 诊断完成 =====
pause