# GitHub API 上传文件指南

## 前提条件
- 需要GitHub Personal Access Token
- 需要知道仓库的完整信息

## 获取Personal Access Token
1. 如果能临时访问GitHub，登录后进入Settings → Developer settings → Personal access tokens → Tokens (classic)
2. 生成新token，勾选repo权限
3. 保存token（只会显示一次）

## API上传文件步骤

### 1. 检查仓库当前状态
```bash
curl -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/repos/sanzhi528/finance-tax-website-v6/contents/
```

### 2. 上传单个文件示例（index.html）
```bash
# 将文件内容编码为base64
$content = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((Get-Content "index.html" -Raw)))

# 使用API上传
curl -X PUT -H "Authorization: token YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"message\":\"上传带备案号的首页\",\"content\":\"$content\"}" \
  https://api.github.com/repos/sanzhi528/finance-tax-website-v6/contents/index.html
```

### 3. 批量上传脚本
创建一个PowerShell脚本来自动化上传过程。

## 备选方案：使用GitHub CLI
如果网络条件允许，安装GitHub CLI工具：
```bash
# 安装GitHub CLI
winget install GitHub.cli

# 认证
github auth login

# 上传文件
github repo upload sanzhi528/finance-tax-website-v6 . --recursive
```