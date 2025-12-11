@echo off
echo ========================================
echo   一键绕过Chrome安全拦截工具
echo ========================================
echo.
echo 您的网站本地测试正常，但Chrome拦截了HTTP访问
echo.
echo 解决方案（按优先级排序）：
echo.
echo 1. 使用Firefox浏览器（推荐）
echo    下载Firefox并直接访问：http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo.
echo 2. Chrome快速绕过方法
echo    在Chrome页面快速输入：thisisunsafe
echo.
echo 3. 修改Chrome设置
echo    访问：chrome://flags/#treat-unsafe-downloads-as-active-content
echo    设置为Disabled，重启浏览器
echo.
echo 4. 点击"继续访问"
echo    在拦截页面找到"访问此不安全站点"链接
echo.
echo ========================================
echo 本地测试地址：http://localhost:8001
echo OSS访问地址：http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com
echo ========================================
echo.
pause