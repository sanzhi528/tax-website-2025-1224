# GitHub Pages 多域名绑定解决方案

## 问题分析
GitHub Pages 在仓库设置中只能配置一个自定义域名，但可以通过 CNAME 文件支持多个域名。

## 解决方案

### 方法一：使用 CNAME 文件（推荐）
1. **在仓库根目录创建 CNAME 文件**
2. **文件内容**（每行一个域名）：
```
www.0slm.cn
www.ninsuna.com
```
3. **不要**在 GitHub 仓库设置中设置自定义域名

### 方法二：DNS 重定向（备选）
- 将 www.0slm.cn 和 www.ninsuna.com 通过 DNS 重定向到 sanzhi528.github.io/0slm-cn-website

## 操作步骤

### 第一步：上传 CNAME 文件到 GitHub
1. 登录 GitHub，进入仓库 `sanzhi528/0slm-cn-website`
2. 点击 "Add file" → "Create new file"
3. 文件名输入 `CNAME`
4. 内容输入：
```
www.0slm.cn
www.ninsuna.com
```
5. 提交更改

### 第二步：配置 DNS 记录
**两个域名都需要配置 CNAME 记录：**
- 主机记录：`www`
- 记录类型：`CNAME`
- 记录值：`sanzhi528.github.io`
- TTL：600秒

### 第三步：验证配置
等待 DNS 传播后，访问：
- https://www.0slm.cn
- https://www.ninsuna.com

## 重要提醒
1. **不要**在 GitHub 仓库设置中设置自定义域名
2. 确保 CNAME 文件在仓库根目录
3. DNS 传播可能需要 1-24 小时
4. GitHub Pages 会自动提供 HTTPS 证书

## 当前状态
- www.0slm.com.cn：通过阿里云 OSS 正常访问
- www.0slm.cn / www.ninsuna.com：等待 GitHub Pages 配置