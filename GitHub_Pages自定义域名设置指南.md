# GitHub Pages自定义域名设置指南

## 设置步骤

### 第一步：上传CNAME文件到GitHub仓库

1. **确保CNAME文件内容正确**：
```
www.0slm.cn
www.ninsuna.com
```

2. **上传到仓库根目录**：
   - 进入GitHub仓库：https://github.com/sanzhi528/0slm-cn-website
   - 点击"Add file" → "Upload files"
   - 将CNAME文件拖拽到上传区域
   - 填写提交信息，如"Add CNAME file for custom domains"
   - 点击"Commit changes"

### 第二步：启用GitHub Pages自定义域名

1. **进入仓库设置页面**：
   - 访问：https://github.com/sanzhi528/0slm-cn-website/settings/pages
   - 或点击仓库顶部的"Settings"标签
   - 在左侧菜单选择"Pages"

2. **配置自定义域名**：
   - 在"Custom domain"部分，输入其中一个域名：
     - 建议使用 `www.0slm.cn`（因为这个域名已经可以正常访问）
   - 点击"Save"保存设置

3. **等待GitHub配置**：
   - GitHub会自动为CNAME文件中的所有域名配置SSL证书
   - 这个过程可能需要几分钟到24小时

### 第三步：验证设置

1. **检查GitHub Pages状态**：
   - 在Pages设置页面，查看构建状态
   - 确保显示"Your site is published at..."

2. **验证DNS解析**：
```bash
nslookup www.0slm.cn
nslookup www.ninsuna.com
```

3. **测试访问**：
```bash
curl -I https://www.0slm.cn
curl -I https://www.ninsuna.com
```

## 详细操作截图说明

### 上传CNAME文件
1. 进入仓库主页
2. 点击"Add file"按钮
3. 选择"Upload files"
4. 拖拽CNAME文件到上传区域
5. 填写提交信息并提交

### 设置自定义域名
1. 点击仓库顶部的"Settings"
2. 左侧菜单选择"Pages"
3. 在"Custom domain"输入框中输入域名
4. 点击"Save"按钮
5. 等待GitHub自动配置

## 重要注意事项

### 1. CNAME文件格式
- 每个域名占一行
- 不需要http://或https://前缀
- 文件必须位于仓库根目录
- 文件名必须为大写"CNAME"（无扩展名）

### 2. DNS配置要求
- 两个域名都必须配置CNAME记录指向 `sanzhi528.github.io`
- 确保DNS记录已生效
- 可以使用以下命令检查：
```bash
nslookup -type=CNAME www.0slm.cn
nslookup -type=CNAME www.ninsuna.com
```

### 3. SSL证书配置
- GitHub会自动为自定义域名配置免费的Let's Encrypt SSL证书
- 配置过程可能需要1-24小时
- 在此期间，域名可能暂时无法访问或显示证书错误

### 4. 多域名处理
- GitHub Pages支持CNAME文件中的多个域名
- 但只有第一个域名会被设置为"主要"自定义域名
- 其他域名也会自动获得SSL证书配置

## 常见问题解决

### Q: 保存自定义域名时出现错误
A: 
1. 检查DNS配置是否正确
2. 确保CNAME文件已上传到仓库根目录
3. 等待DNS记录完全生效（可能需要几小时）

### Q: 域名访问显示404错误
A: 
1. 检查GitHub Pages构建是否成功
2. 确认仓库中有index.html或其他默认页面
3. 检查CNAME文件格式是否正确

### Q: SSL证书不生效
A: 
1. 等待GitHub自动配置（最长24小时）
2. 检查DNS记录是否指向正确
3. 清除浏览器缓存重新访问

### Q: 一个域名可以访问，另一个不行
A: 
1. 检查两个域名的DNS配置是否一致
2. 确认CNAME文件中包含两个域名
3. 等待GitHub为第二个域名配置SSL证书

## 验证设置成功的方法

### 方法一：GitHub Pages状态检查
- 进入仓库Settings → Pages
- 查看构建状态和自定义域名显示

### 方法二：命令行验证
```bash
# 检查DNS解析
nslookup www.0slm.cn
nslookup www.ninsuna.com

# 检查HTTPS访问
curl -I https://www.0slm.cn
curl -I https://www.ninsuna.com

# 检查SSL证书
openssl s_client -connect www.0slm.cn:443 -servername www.0slm.cn
```

### 方法三：浏览器访问测试
- 分别访问两个域名
- 检查是否显示相同的网站内容
- 确认地址栏显示安全锁图标（HTTPS）

## 设置完成后的预期效果

1. **两个域名都能正常访问**：
   - https://www.0slm.cn
   - https://www.ninsuna.com

2. **都使用HTTPS协议**：
   - 浏览器地址栏显示安全锁图标
   - SSL证书由GitHub自动管理

3. **显示相同的网站内容**：
   - 两个域名指向同一个GitHub Pages网站
   - 内容完全一致

## 技术支持

如果遇到问题：
- GitHub文档：https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site
- GitHub社区支持：https://github.com/community
- 提交GitHub支持请求：https://support.github.com

---

**按照以上步骤操作后，两个域名都应该能正常访问您的GitHub Pages网站。**