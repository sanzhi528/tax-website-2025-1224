# 阿里云OSS跨域设置(CORS)配置指南

## 🎯 配置目标
为您的Bucket `financial-tax-website` 配置跨域资源共享(CORS)规则，确保网站可以正常访问静态资源。

## 📋 CORS配置参数

### 推荐配置（适用于静态网站托管）

**第一条规则（允许所有来源 - 开发环境）**
```
来源：*
允许Methods：GET, HEAD
允许Headers：*
暴露Headers：ETag, x-oss-request-id
最大缓存时间：3600
```

**第二条规则（允许特定域名 - 生产环境）**
```
来源：http://www.0slm.com.cn, https://www.0slm.com.cn
允许Methods：GET, HEAD, OPTIONS
允许Headers：*
暴露Headers：ETag, x-oss-request-id
最大缓存时间：3600
```

## 🛠️ 配置步骤

### 第一步：登录阿里云OSS控制台
1. 访问：`https://oss.console.aliyun.com/`
2. 选择Bucket：`financial-tax-website`
3. 进入：**权限管理** → **跨域设置**

### 第二步：添加CORS规则
1. 点击**创建规则**按钮
2. 按以下配置填写：

#### 规则1：允许所有来源（用于测试）
- **来源**：`*`
- **允许Methods**：`GET, HEAD`
- **允许Headers**：`*`
- **暴露Headers**：`ETag, x-oss-request-id`
- **最大缓存时间**：`3600`

#### 规则2：允许您的域名（生产环境）
- **来源**：`http://www.0slm.com.cn, https://www.0slm.com.cn`
- **允许Methods**：`GET, HEAD, OPTIONS`
- **允许Headers**：`*`
- **暴露Headers**：`ETag, x-oss-request-id`
- **最大缓存时间**：`3600`

### 第三步：保存配置
1. 点击**确定**保存规则
2. 规则生效时间：立即生效

## 🔧 配置说明

### 各参数含义
- **来源(Origin)**：允许访问的域名，`*`表示允许所有域名
- **允许Methods**：允许的HTTP方法，静态网站只需GET和HEAD
- **允许Headers**：允许的自定义请求头
- **暴露Headers**：允许浏览器访问的响应头
- **最大缓存时间**：浏览器缓存CORS预检请求的时间

### 为什么需要CORS？
- 浏览器安全策略要求跨域访问需要CORS授权
- 静态网站托管需要CORS来允许浏览器加载资源
- 没有CORS配置会导致网站无法正常显示

## 🧪 测试CORS配置

### 测试命令
```bash
# 测试CORS配置
curl -H "Origin: http://www.0slm.com.cn" \
     -H "Access-Control-Request-Method: GET" \
     -H "Access-Control-Request-Headers: Content-Type" \
     -X OPTIONS \
     http://financial-tax-website.oss-cn-shenzhen.aliyuncs.com/
```

### 预期响应
如果CORS配置正确，应该返回：
```
Access-Control-Allow-Origin: http://www.0slm.com.cn
Access-Control-Allow-Methods: GET, HEAD, OPTIONS
Access-Control-Allow-Headers: Content-Type
```

## ⚠️ 注意事项

### 安全考虑
- 生产环境建议使用特定域名而不是`*`
- 定期检查CORS规则，避免过度授权
- 测试环境可以使用`*`方便调试

### 常见问题
1. **CORS配置不生效**：检查规则顺序，确保没有冲突规则
2. **浏览器仍然报CORS错误**：清除浏览器缓存重新测试
3. **部分资源无法加载**：检查是否所有需要的HTTP方法都已允许

## 📞 故障排除

如果配置后网站仍然无法访问：
1. 检查浏览器开发者工具的Console面板
2. 查看具体的CORS错误信息
3. 根据错误信息调整CORS配置
4. 联系阿里云技术支持

## 🔗 相关文档
- [阿里云OSS CORS配置文档](https://help.aliyun.com/zh/oss/user-guide/set-bucket-cors)
- [CORS跨域资源共享MDN文档](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/CORS)