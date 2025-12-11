# 域名DNS配置修复指南

## 问题诊断

### 当前状态：
- ✅ `www.0slm.com.cn` - 正确指向阿里云OSS（已添加备案号）
- ❌ `www.0slm.com` - 指向GitHub Pages（无备案号）
- ❌ `www.0slm.cn` - 指向GitHub Pages（无备案号）

### 问题原因：
域名DNS解析配置错误，部分域名指向了错误的托管平台。

## 修复步骤

### 步骤1：登录DNS管理控制台
根据您的域名注册商，登录相应的DNS管理平台：
- 腾讯云DNSPod
- 阿里云DNS
- 或其他域名注册商

### 步骤2：修改DNS记录
为以下域名添加CNAME记录：

#### 域名：`www.0slm.com`
```
记录类型：CNAME
主机记录：www
记录值：financial-tax-website.oss-cn-shenzhen.aliyuncs.com
TTL：600秒（10分钟）
```

#### 域名：`www.0slm.cn`
```
记录类型：CNAME
主机记录：www
记录值：financial-tax-website.oss-cn-shenzhen.aliyuncs.com
TTL：600秒（10分钟）
```

### 步骤3：删除错误的记录
检查并删除指向GitHub Pages的CNAME记录：
- 删除任何指向GitHub Pages的CNAME记录
- 确保没有冲突的A记录或其他记录

### 步骤4：验证配置
修改完成后，等待DNS生效（通常需要10分钟到24小时），然后验证：

```bash
# 检查DNS解析
nslookup www.0slm.com
nslookup www.0slm.cn

# 应该解析到：112.74.1.140（阿里云OSS深圳节点）
```

## 阿里云OSS域名绑定

在DNS配置完成后，还需要在阿里云OSS中绑定这些域名：

### 步骤1：登录阿里云OSS控制台
1. 访问 https://oss.console.aliyun.com/
2. 选择 `financial-tax-website` Bucket

### 步骤2：绑定自定义域名
1. 进入 **传输管理** → **域名管理**
2. 点击 **绑定域名**
3. 添加以下域名：
   - `www.0slm.com`
   - `www.0slm.cn`

### 步骤3：验证域名所有权
按照系统提示完成域名验证（可能需要添加TXT记录）。

## 验证修复效果

DNS生效后，访问以下网址检查备案号是否显示：

1. **https://www.0slm.com/** - 应该显示备案号
2. **https://www.0slm.cn/** - 应该显示备案号
3. **https://www.0slm.com.cn/** - 已经正确显示备案号

## 重要提醒

### 备案合规性
- 所有在中国大陆可访问的网站都必须显示备案号
- 备案号必须可点击，链接到工信部备案查询页面
- 备案信息必须真实有效

### 技术要点
- DNS更改需要时间生效，请耐心等待
- 确保所有域名都指向同一个阿里云OSS Bucket
- 检查SSL证书是否正常（HTTPS访问）

### 备案号显示要求
根据工信部要求，备案号必须：
1. 显示在网站首页底部
2. 链接到 `https://beian.miit.gov.cn`
3. 清晰可见，不得隐藏或模糊

## 故障排除

### 如果备案号不显示
1. 检查DNS解析是否正确
2. 确认阿里云OSS域名绑定状态
3. 验证网站文件是否已正确上传到OSS
4. 检查浏览器缓存（Ctrl+F5强制刷新）

### 如果网站无法访问
1. 检查DNS解析状态
2. 确认阿里云OSS配置（静态网站托管、权限设置）
3. 验证域名绑定是否生效
4. 检查网络连接和防火墙设置

## 技术支持信息

- **OSS Bucket名称**：`financial-tax-website`
- **OSS地域**：深圳（oss-cn-shenzhen）
- **备案号**：粤ICP备18106452号
- **工信部备案查询**：https://beian.miit.gov.cn

按照以上步骤操作，您的所有域名都将正确显示备案信息，符合工信部要求。