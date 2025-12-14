# 上传文件到腾讯云COS指南

## 需要上传的文件

根据您的要求，需要上传以下3个文件到腾讯云COS存储桶：

1. **`index.html`** - 主页面文件
   - 已移除"关于我们"页面的电话、邮箱和地址信息

2. **`admin/index.html`** - 管理后台页面文件  
   - 已移除"关于我们"页面的电话、邮箱和地址信息

3. **`css/style.css`** - 样式文件
   - 已将备案号链接颜色从深蓝色改为白色

## 上传步骤

### 方法一：通过腾讯云COS控制台

1. 登录腾讯云控制台：https://console.cloud.tencent.com/cos
2. 进入您的存储桶（应该是 `0slm-xxx` 类似的名称）
3. 点击"上传文件"按钮
4. 选择上述3个文件进行上传（覆盖现有文件）
5. 等待上传完成

### 方法二：使用COS命令行工具

如果您安装了腾讯云COS命令行工具，可以使用以下命令：

```bash
# 上传单个文件
coscmd upload index.html index.html
coscmd upload admin/index.html admin/index.html  
coscmd upload css/style.css css/style.css

# 或者批量上传
coscmd upload ./
```

## 刷新CDN缓存

上传完成后，需要刷新CDN缓存以确保新内容生效：

1. 登录腾讯云CDN控制台：https://console.cloud.tencent.com/cdn
2. 找到您的域名 `www.0slm.com`
3. 点击"刷新预热" -> "URL刷新"
4. 输入需要刷新的URL：
   - `https://www.0slm.com/`
   - `https://www.0slm.com/index.html`
   - `https://www.0slm.com/css/style.css`
5. 点击"提交刷新"

## 验证更新

刷新完成后，请访问以下链接验证修改是否生效：
- https://www.0slm.com/ （检查备案号是否为白色）
- https://www.0slm.com/ （检查"关于我们"页面是否已移除联系信息）

## 注意事项

- CDN缓存刷新通常需要几分钟时间生效
- 如果刷新后仍显示旧内容，请尝试清除浏览器缓存或使用无痕模式访问
- 建议在非高峰时段进行更新操作