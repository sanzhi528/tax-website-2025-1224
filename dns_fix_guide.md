# DNS配置紧急修复指南

## 当前问题分析

### 检测到的配置问题：
1. **www.0slm.com**：CNAME正确指向腾讯云，但网站无法访问
2. **www.0slm.cn**：CNAME错误指向GitHub Pages，需要修改
3. **根域名**：未配置解析记录

## 立即修复步骤

### 第一步：登录DNSPod控制台
1. 访问 https://www.dnspod.cn/
2. 登录您的账号
3. 选择域名：`0slm.com` 和 `0slm.cn`

### 第二步：修改www.0slm.cn的CNAME记录

**当前错误配置：**
```
主机记录：www
记录类型：CNAME
记录值：sanzhi528.github.io
```

**需要修改为：**
```
主机记录：www
记录类型：CNAME
记录值：finance-tax-website-1257296270.cos.ap-guangzhou.myqcloud.com
TTL：600
```

### 第三步：配置根域名（可选）

如果需要支持直接访问 `0slm.com` 和 `0slm.cn`：

**配置方法1：CNAME记录（推荐）**
```
主机记录：@
记录类型：CNAME
记录值：finance-tax-website-1257296270.cos.ap-guangzhou.myqcloud.com
TTL：600
```

**配置方法2：URL转发**
```
主机记录：@
记录类型：显性URL
记录值：http://www.0slm.com
```

### 第四步：验证腾讯云存储桶配置

1. **确认存储桶状态**：
   - 存储桶名称：`finance-tax-website`
   - 地域：华南地区（广州）
   - 访问权限：公有读私有写

2. **开启静态网站**：
   - 索引文档：`index.html`
   - 错误文档：`index.html`（可选）

3. **上传网站文件**：
   - 将所有文件上传到存储桶根目录
   - 保持原有目录结构

4. **绑定自定义域名**：
   - 添加 `www.0slm.com`
   - 添加 `www.0slm.cn`
   - 完成域名所有权验证

## DNS生效时间

- **TTL为600秒**：通常10-30分钟内生效
- **全局生效**：最长可能需要48小时

## 验证方法

### 方法1：使用检查脚本
```powershell
powershell -ExecutionPolicy Bypass -File "check_dns.ps1"
```

### 方法2：手动检查
```bash
# 检查CNAME记录
nslookup -type=CNAME www.0slm.com
nslookup -type=CNAME www.0slm.cn

# 检查网站访问
curl -I http://www.0slm.com
curl -I http://www.0slm.cn
```

## 故障排除

### 问题1：修改后仍然无法访问
**原因**：DNS缓存未刷新
**解决**：等待TTL时间或清除本地DNS缓存

### 问题2：腾讯云提示域名验证失败
**原因**：TXT记录未正确配置
**解决**：按照腾讯云提示添加TXT验证记录

### 问题3：部分地区无法访问
**原因**：DNS传播不一致
**解决**：等待全球DNS同步完成

## 重要提醒

1. **不要删除现有记录**：先添加新记录，验证正常后再删除旧记录
2. **备份配置**：修改前截图保存当前配置
3. **分步操作**：先修复一个域名，验证正常后再处理另一个
4. **技术支持**：如遇问题可联系DNSPod客服或腾讯云技术支持

完成以上步骤后，您的两个域名都将正确指向腾讯云存储桶，网站可以正常访问。