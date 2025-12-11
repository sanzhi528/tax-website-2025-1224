@echo off
echo ========================================
echo       阿里云OSS网站诊断工具
echo ========================================
echo.
echo 1. 检查DNS解析状态...
nslookup www.0slm.com.cn
echo.
echo 2. 检查OSS Bucket直接访问...
curl -I http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo.
echo 3. 检查静态网站托管...
curl -I http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html
echo.
echo ========================================
echo 诊断完成！
echo.
echo 如果出现错误，请检查：
echo 1. 阿里云OSS控制台 - 静态网站托管是否开启
echo 2. Bucket权限是否设置为"公共读"
echo 3. index.html文件是否已上传
echo 4. 域名绑定状态是否正常
echo ========================================
pause