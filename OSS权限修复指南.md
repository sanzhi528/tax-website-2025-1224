# OSS权限修复指南

## 问题诊断
- **错误代码**：403 禁止访问
- **问题根源**：Bucket权限配置错误

## 修复步骤

### 1. 设置Bucket权限为公共读
1. 登录阿里云OSS控制台
2. 进入 **financial-tax-website** Bucket
3. **权限管理** → **读写权限(ACL)**
4. 选择 **公共读**
5. 点击 **保存**

### 2. 配置跨域设置(CORS)
1. **权限管理** → **跨域设置(CORS)**
2. 添加新规则或修改现有规则：
   - **来源**：`*`
   - **允许Methods**：`GET, HEAD`
   - **允许Headers**：`*`
   - **暴露Headers**：`ETag, x-oss-request-id`
   - **缓存时间**：`300`

### 3. 检查防盗链设置
1. **权限管理** → **防盗链**
2. **Referer白名单**：留空或添加 `*`
3. **不允许空Referer**：关闭

## 验证方法
修复后测试以下链接：
- OSS地址：`http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com`
- 自定义域名：`http://www.0slm.com.cn`

## 预期结果
- 应该返回 **200 OK** 状态码
- 网页正常显示，不再出现下载对话框

## 备用方案
如果仍然403错误：
1. 联系阿里云技术支持
2. 检查Bucket是否在正确的区域(oss-cn-shenzhen)
3. 确认账户权限是否正常