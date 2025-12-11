# DNSPod修改CNAME记录指南 - 解决网站无法访问问题

## 🔍 问题诊断
**当前DNS解析状态：**
- `www.0slm.com.cn` → `sanzhi528.github.io`（GitHub Pages）

**正确DNS解析应该为：**
- `www.0slm.com.cn` → `financial-tax-website.oss-cn-shenzhen.aliyuncs.com`（阿里云OSS）

## 🚀 立即操作步骤

### 第一步：登录DNSPod控制台
1. 访问：`https://console.dnspod.cn/`
2. 使用腾讯云账号登录
3. 选择域名：`0slm.com.cn`

### 第二步：找到并修改CNAME记录
1. 点击 **"解析"** 或 **"DNS管理"**
2. 找到现有的CNAME记录：
   - **主机记录**：`www`
   - **记录类型**：`CNAME`
   - **当前记录值**：`sanzhi528.github.io`

3. **修改记录值**：
   - 点击 **"修改"** 按钮
   - 将记录值改为：`financial-tax-website.oss-cn-shenzhen.aliyuncs.com`
   - TTL保持默认（600秒）
   - 点击 **"保存"**

### 第三步：检查其他记录
检查是否有其他记录影响解析：
- **A记录**：检查是否有A记录指向GitHub Pages的IP地址
- **其他CNAME记录**：确保没有冲突的记录

### 第四步：等待DNS生效
- DNS更新通常需要 **2-30分钟**
- 可以使用命令实时监控：`nslookup www.0slm.com.cn`
- 当解析结果变为 `financial-tax-website.oss-cn-shenzhen.aliyuncs.com` 时，表示生效

## 📋 验证步骤

### 验证DNS解析
```bash
# 检查DNS解析状态
nslookup www.0slm.com.cn

# 期望结果：
# 名称: financial-tax-website.oss-cn-shenzhen.aliyuncs.com
# Address: 112.74.1.104
```

### 验证网站访问
- 访问：`http://www.0slm.com.cn`
- 应该显示您的网站首页

## 🛠️ 常见问题解决

### 问题1：修改后DNS不生效
**解决方案：**
1. 清除本地DNS缓存：`ipconfig /flushdns`
2. 等待更长时间（最长30分钟）
3. 检查DNSPod控制台记录状态是否为"正常"

### 问题2：有其他记录冲突
**解决方案：**
1. 删除指向GitHub Pages的A记录（如果有）
2. 确保只有一条CNAME记录指向阿里云OSS

### 问题3：网站仍然无法访问
**解决方案：**
1. 确认阿里云OSS配置正确
   - 静态网站托管已开启
   - Bucket权限为"公共读"
   - index.html文件已上传
2. 确认域名绑定状态正常

## 📞 技术支持
- **DNSPod技术支持**：4009-100-100
- **阿里云技术支持**：95187

## ⚠️ 重要提醒
- **必须修改CNAME记录**，否则网站将一直指向GitHub Pages
- DNS生效需要时间，请耐心等待
- 修改后请务必测试网站访问

## 🔄 实时监控命令
```bash
# 实时监控DNS解析变化
nslookup www.0slm.com.cn

# 清除本地DNS缓存（Windows）
ipconfig /flushdns

# 检查网站HTTP响应
curl -I http://www.0slm.com.cn
```