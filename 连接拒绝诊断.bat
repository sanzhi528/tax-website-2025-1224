@echo off
echo ===== 连接拒绝问题诊断 =====
echo.

echo 1. 检查DNS解析...
nslookup www.0slm.com.cn
echo.

echo 2. 测试网络连通性...
ping -n 4 financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo.

echo 3. 测试HTTP连接...
curl -v --connect-timeout 10 http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com 2>&1 | findstr "Connected\|failed\|refused"
echo.

echo 4. 测试具体文件访问...
curl -v --connect-timeout 10 http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/index.html 2>&1 | findstr "Connected\|failed\|refused"
echo.

echo ===== 诊断完成 =====
echo.
echo 可能的问题原因：
echo 1. 静态网站托管未开启
echo 2. Bucket权限设置错误
echo 3. 地域配置不匹配
echo 4. 阿里云服务端问题
echo.
pause