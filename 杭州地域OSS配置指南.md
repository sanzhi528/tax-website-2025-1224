# 杭州地域OSS配置指南

## 当前状态
- ✅ 已创建新Bucket：`financial-tax-website1`
- ✅ 地域：华东1（杭州）
- ❌ 需要重新配置静态网站托管

## 配置步骤

### 步骤1：上传网站文件
1. 登录阿里云OSS控制台
2. 进入 **financial-tax-website1** Bucket
3. **文件管理** → **上传文件**
4. 上传以下文件：
   - `index.html`
   - `css/style.css`
   - `js/main.js`
   - `images/LOGO图标.jpg`
   - 其他相关文件

### 步骤2：配置静态网站托管
1. **基础设置** → **静态页面**
2. 开启静态页面功能
3. 设置参数：
   - 默认首页：`index.html`
   - 默认404页：`index.html`
   - 子目录首页：未开通
   - 错误文档响应码：`404`
4. 点击 **保存**

### 步骤3：设置权限
1. **权限管理** → **读写权限(ACL)**
   - 设置为：**公共读**
2. **权限管理** → **跨域设置(CORS)**
   - 添加新规则：
     - 来源：`*`
     - 允许Methods：`GET, HEAD`
     - 允许Headers：`*`
     - 暴露Headers：`ETag, x-oss-request-id`
     - 缓存时间：`300`

### 步骤4：绑定域名
1. **传输管理** → **域名管理**
2. **绑定用户域名**
3. 输入域名：`www.0slm.com.cn`
4. **自动添加CNAME记录**：选择"是"
5. 点击 **提交**

## 验证方法
配置完成后测试：
- OSS地址：`http://financial-tax-website1.oss-cn-hangzhou.aliyuncs.com`
- 自定义域名：`http://www.0slm.com.cn`

## 预期结果
- 返回 **200 OK** 状态码
- 网页正常显示，不再出现下载对话框

## 注意事项
1. 确保所有文件已正确上传
2. 静态网站配置保存后需要等待几分钟生效
3. DNS解析可能需要时间生效