# ERR_CONNECTION_REFUSED 错误解决方案

## 问题诊断结果

### 当前状态分析：
- ✅ **DNS解析正常**：域名正确指向OSS
- ✅ **网络连接正常**：TCP端口80连接成功
- ❌ **HTTP访问失败**：返回ERR_CONNECTION_REFUSED

### 问题核心：
**阿里云OSS配置问题导致HTTP请求被拒绝**

## 立即修复步骤

### 步骤1：检查OSS静态网站配置
登录阿里云OSS控制台 → `financial-tax-website` Bucket：

1. **基础设置** → **静态页面**
   - 确保 **静态网站托管** 已开启
   - 设置 **默认首页** 为 `index.html`
   - 设置 **默认404页** 为 `index.html`（可选）

2. **权限管理** → **公共读**
   - 确保Bucket权限设置为 **公共读**

### 步骤2：检查域名绑定状态
1. **传输管理** → **域名管理**
2. 检查以下域名绑定状态：
   - `www.0slm.com.cn`
   - `www.ninsuna.com`
3. 确保绑定状态为 **已生效**

### 步骤3：检查跨域设置（CORS）
1. **基础设置** → **跨域设置**
2. 添加或检查以下规则：
   ```
   来源：*
   方法：GET, HEAD, OPTIONS
   允许Headers：*
   暴露Headers：ETag
   缓存时间：3600
   ```

### 步骤4：检查Bucket地域和状态
1. 确认Bucket在 **深圳地域**（oss-cn-shenzhen）
2. 检查Bucket是否被冻结或限制
3. 确认Bucket状态为 **正常**

## 常见错误排查

### 错误1：静态网站托管未开启
**症状**：直接访问OSS地址返回403或连接拒绝
**解决**：开启静态网站托管功能

### 错误2：权限设置错误
**症状**：各种访问错误
**解决**：设置Bucket为公共读权限

### 错误3：域名绑定失败
**症状**：域名解析正常但无法访问
**解决**：重新绑定域名或检查绑定状态

### 错误4：文件结构问题
**症状**：部分资源加载失败
**解决**：确保所有文件正确上传到OSS

## 验证修复效果

修复完成后，按以下顺序测试：

1. **直接访问OSS**：
   ```
   http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com
   ```

2. **访问主域名**：
   ```
   http://www.0slm.com.cn
   ```

3. **访问备用域名**：
   ```
   http://www.ninsuna.com
   ```

## 备用方案

如果以上步骤无效：

### 方案1：重新绑定域名
1. 在OSS中解绑域名
2. 等待5分钟
3. 重新绑定域名
4. 等待DNS生效（最长24小时）

### 方案2：手动配置CNAME
如果自动绑定失败，手动在DNS中添加：
```
记录类型：CNAME
主机记录：www
记录值：financial-tax-website.oss-cn-shenzhen.aliyuncs.com
```

### 方案3：联系阿里云技术支持
提供以下信息：
- Bucket名称：`financial-tax-website`
- 地域：深圳
- 错误信息：ERR_CONNECTION_REFUSED
- 域名：`www.0slm.com.cn`, `www.ninsuna.com`

## 本地测试

在修复OSS配置的同时，可以启动本地服务器测试网站功能：

```bash
# 使用Python启动本地服务器
python -m http.server 8000

# 访问测试
http://localhost:8000
```

## 重要提醒

1. **DNS配置已经正确**，问题在OSS端
2. **网络连接正常**，说明不是防火墙问题
3. **需要重点检查OSS的静态网站配置**
4. **配置更改后可能需要等待几分钟生效**

按照上述步骤操作，您的网站应该能够正常访问。