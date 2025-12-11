# 阿里云OSS域名绑定修复指南

## 问题诊断
- **错误**：在错误的Bucket上绑定域名
- **正确Bucket**：`financial-tax-website`（深圳地域）
- **错误Bucket**：`financial-tax-website1`（杭州地域）

## 修复步骤

### 步骤1：在正确的Bucket上绑定域名
1. 登录阿里云OSS控制台
2. 进入 **financial-tax-website** Bucket（注意：不是financial-tax-website1）
3. **传输管理** → **域名管理**
4. **绑定用户域名**
5. 输入域名：`www.0slm.com.cn`
6. **自动添加CNAME记录**：选择"是"
7. 点击 **提交**

### 步骤2：清理错误的DNS记录
在腾讯云DNS控制台中：
1. 删除当前的TXT记录：
   - 记录类型：TXT
   - 主机记录：`_dnsauth`
   - 记录值：`76a805399af35189ca256757c11f672c`

### 步骤3：验证DNS解析
绑定成功后，阿里云会自动创建CNAME记录：
```
记录类型：CNAME
主机记录：www
记录值：financial-tax-website.oss-cn-shenzhen.aliyuncs.com
```

## 验证方法
绑定成功后测试：
- 自定义域名：`http://www.0slm.com.cn`
- OSS地址：`http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com`

## 常见错误
1. **Bucket地域不匹配**：确保Bucket在深圳地域
2. **DNS记录冲突**：删除错误的TXT记录
3. **域名已绑定**：如果域名已绑定到其他Bucket，需要先解绑

## 备用方案
如果自动绑定失败，手动添加CNAME记录：
1. 在腾讯云DNS控制台添加记录：
   - 记录类型：CNAME
   - 主机记录：www
   - 记录值：financial-tax-website.oss-cn-shenzhen.aliyuncs.com
2. 在阿里云OSS中绑定域名（选择"否"自动添加CNAME记录）