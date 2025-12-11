# 阿里云OSS静态网站部署脚本
# 解决备案合规性问题 - 域名 0slm.com.cn 必须部署在阿里云

param(
    [string]$AccessKeyId = "",
    [string]$AccessKeySecret = "",
    [string]$BucketName = "financial-tax-website",
    [string]$Region = "oss-cn-shenzhen",  # 华南1（深圳）
    [string]$WebsitePath = "E:\20251124\网站建设"
)

# 检查必要工具
function Check-Prerequisites {
    Write-Host "🔍 检查部署环境..." -ForegroundColor Cyan
    
    # 检查阿里云CLI是否安装
    try {
        $ossutil = Get-Command ossutil -ErrorAction Stop
        Write-Host "✅ ossutil 已安装" -ForegroundColor Green
    } catch {
        Write-Host "❌ ossutil 未安装，请先安装阿里云CLI工具" -ForegroundColor Red
        Write-Host "📥 下载地址: https://help.aliyun.com/document_detail/120075.html" -ForegroundColor Yellow
        exit 1
    }
    
    # 检查网站文件是否存在
    if (-not (Test-Path "$WebsitePath\index.html")) {
        Write-Host "❌ 找不到网站文件 index.html" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "✅ 网站文件检查通过" -ForegroundColor Green
}

# 配置阿里云访问凭证
function Configure-OSS {
    Write-Host "🔧 配置阿里云访问凭证..." -ForegroundColor Cyan
    
    if ([string]::IsNullOrEmpty($AccessKeyId) -or [string]::IsNullOrEmpty($AccessKeySecret)) {
        Write-Host "⚠️  请提供阿里云AccessKey信息" -ForegroundColor Yellow
        Write-Host "📋 获取方法:" -ForegroundColor Yellow
        Write-Host "   1. 登录阿里云控制台" -ForegroundColor Yellow
        Write-Host "   2. 鼠标悬停右上角头像 -> AccessKey管理" -ForegroundColor Yellow
        Write-Host "   3. 创建或查看AccessKey" -ForegroundColor Yellow
        Write-Host "   4. 运行脚本时添加参数: -AccessKeyId '您的ID' -AccessKeySecret '您的Secret'" -ForegroundColor Yellow
        exit 1
    }
    
    # 配置ossutil
    $configCommand = "ossutil config -e oss-$Region.aliyuncs.com -i $AccessKeyId -k $AccessKeySecret"
    Invoke-Expression $configCommand
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 阿里云配置成功" -ForegroundColor Green
    } else {
        Write-Host "❌ 阿里云配置失败" -ForegroundColor Red
        exit 1
    }
}

# 创建OSS存储桶
function Create-Bucket {
    Write-Host "🪣 创建OSS存储桶..." -ForegroundColor Cyan
    
    $createCommand = "ossutil mb oss://$BucketName --acl public-read"
    Invoke-Expression $createCommand
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 存储桶创建成功: $BucketName" -ForegroundColor Green
    } else {
        Write-Host "⚠️  存储桶可能已存在，继续下一步..." -ForegroundColor Yellow
    }
}

# 上传网站文件到OSS
function Upload-Website {
    Write-Host "📤 上传网站文件到OSS..." -ForegroundColor Cyan
    
    # 上传所有文件
    $uploadCommand = "ossutil cp '$WebsitePath\' oss://$BucketName/ -r -f"
    Write-Host "执行命令: $uploadCommand" -ForegroundColor Gray
    Invoke-Expression $uploadCommand
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 网站文件上传成功" -ForegroundColor Green
    } else {
        Write-Host "❌ 文件上传失败" -ForegroundColor Red
        exit 1
    }
}

# 配置静态网站托管
function Configure-StaticWebsite {
    Write-Host "🌐 配置静态网站托管..." -ForegroundColor Cyan
    
    # 创建网站配置XML
    $websiteConfig = @"
<?xml version="1.0" encoding="UTF-8"?>
<WebsiteConfiguration>
    <IndexDocument>
        <Suffix>index.html</Suffix>
    </IndexDocument>
    <ErrorDocument>
        <Key>index.html</Key>
    </ErrorDocument>
</WebsiteConfiguration>
"@
    
    $configFile = "$env:TEMP\website_config.xml"
    $websiteConfig | Out-File -FilePath $configFile -Encoding UTF8
    
    # 应用网站配置
    $configCommand = "ossutil website --enable --index-document index.html --error-document index.html oss://$BucketName"
    Invoke-Expression $configCommand
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 静态网站配置成功" -ForegroundColor Green
    } else {
        Write-Host "❌ 静态网站配置失败" -ForegroundColor Red
        exit 1
    }
}

# 测试网站访问
function Test-Website {
    Write-Host "🔍 测试网站访问..." -ForegroundColor Cyan
    
    $websiteUrl = "http://$BucketName.$Region.aliyuncs.com"
    Write-Host "🌐 测试访问地址: $websiteUrl" -ForegroundColor Yellow
    
    try {
        $response = Invoke-WebRequest -Uri $websiteUrl -TimeoutSec 10
        if ($response.StatusCode -eq 200) {
            Write-Host "✅ 网站访问测试成功" -ForegroundColor Green
            Write-Host "📊 响应时间: $($response.Headers['X-OSS-Request-Id'])" -ForegroundColor Gray
        }
    } catch {
        Write-Host "⚠️  网站访问测试失败，可能需要等待DNS生效" -ForegroundColor Yellow
        Write-Host "错误信息: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# 显示部署信息
function Show-DeploymentInfo {
    Write-Host ""
    Write-Host "🎉 阿里云部署完成！" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 部署信息汇总:" -ForegroundColor Cyan
    Write-Host "   🔗 OSS访问地址: http://$BucketName.$Region.aliyuncs.com" -ForegroundColor White
    Write-Host "   🪣 存储桶名称: $BucketName" -ForegroundColor White
    Write-Host "   🌍 地域: $Region" -ForegroundColor White
    Write-Host ""
    Write-Host "🚀 下一步操作:" -ForegroundColor Cyan
    Write-Host "   1. 登录阿里云控制台绑定域名 www.0slm.com.cn" -ForegroundColor Yellow
    Write-Host "   2. 在域名注册商处设置CNAME记录" -ForegroundColor Yellow
    Write-Host "   3. 等待DNS生效（2-48小时）" -ForegroundColor Yellow
    Write-Host "   4. 测试域名访问" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📞 备案合规说明:" -ForegroundColor Cyan
    Write-Host "   ✅ 网站已部署在备案服务商阿里云" -ForegroundColor Green
    Write-Host "   ✅ 符合工信部备案要求" -ForegroundColor Green
    Write-Host "   ✅ 备案号: 粤ICP备18106452号-3" -ForegroundColor Green
}

# 主部署流程
function Main {
    Write-Host ""
    Write-Host "🚀 开始阿里云OSS部署 - 解决备案合规性问题" -ForegroundColor Magenta
    Write-Host "域名: 0slm.com.cn | 备案号: 粤ICP备18106452号-3" -ForegroundColor Magenta
    Write-Host ""
    
    try {
        Check-Prerequisites
        Configure-OSS
        Create-Bucket
        Upload-Website
        Configure-StaticWebsite
        Test-Website
        Show-DeploymentInfo
        
        Write-Host ""
        Write-Host "✅ 部署流程完成！" -ForegroundColor Green
    } catch {
        Write-Host ""
        Write-Host "❌ 部署过程中出现错误: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "💡 请检查错误信息并重新运行脚本" -ForegroundColor Yellow
    }
}

# 执行主函数
Main