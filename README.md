# GitHub Pages 部署指南

## 为什么选择GitHub Pages？
1. ✅ **国内可访问** - 不需要VPN
2. ✅ **完全免费** - 无任何费用
3. ✅ **部署简单** - 几分钟完成
4. ✅ **自动HTTPS** - 安全连接
5. ✅ **全球CDN** - 访问速度快

## 部署步骤

### 步骤1：创建GitHub仓库
1. 登录GitHub：https://github.com
2. 点击右上角"+" → "New repository"
3. 配置：
   - Repository name: `ai-lab-voting`
   - Description: AI拓边实验室投票系统
   - Public（公开）
   - 不初始化README（可选）

### 步骤2：上传文件
有几种方法上传：

#### 方法A：网页上传（最简单）
1. 进入新建的仓库
2. 点击"Add file" → "Upload files"
3. 拖拽或选择所有文件
4. 点击"Commit changes"

#### 方法B：Git命令（推荐给开发者）
```bash
# 克隆仓库
git clone https://github.com/你的用户名/ai-lab-voting.git

# 进入目录
cd ai-lab-voting

# 复制文件
cp -r ../国内部署包/* .

# 提交
git add .
git commit -m "初始提交：AI拓边实验室投票系统"
git push
```

### 步骤3：开启GitHub Pages
1. 进入仓库 → "Settings"
2. 左侧"Pages"
3. 配置：
   - Source: Deploy from a branch
   - Branch: main (或master)
   - Folder: / (根目录)
4. 点击"Save"

### 步骤4：获取访问链接
等待1-2分钟，在Pages设置页面看到：
```
Your site is live at https://[用户名].github.io/ai-lab-voting/
```

## 访问测试

### 测试链接
打开：`https://[你的GitHub用户名].github.io/ai-lab-voting/`

### 功能验证
1. ✅ 国内直接访问（无需VPN）
2. ✅ 所有功能正常
3. ✅ 实时同步正常
4. ✅ 界面显示正常

## 自定义域名（可选）
如果需要更专业的域名：

### 步骤1：购买域名
在阿里云、腾讯云等购买域名

### 步骤2：配置DNS
添加CNAME记录指向：`[用户名].github.io`

### 步骤3：GitHub配置
在Pages设置中填写自定义域名

## 更新部署
当需要更新系统时：

### 方法A：网页更新
1. 在GitHub仓库中编辑文件
2. 直接提交更改
3. 自动重新部署

### 方法B：本地更新
```bash
# 拉取最新
git pull

# 修改文件
# ...

# 提交更新
git add .
git commit -m "更新描述"
git push
```

## 优势对比

| 平台 | 国内访问 | 费用 | 部署难度 | 自定义域名 |
|------|----------|------|----------|------------|
| GitHub Pages | ✅ 稳定 | 免费 | 简单 | 支持 |
| Vercel | ❌ 需要VPN | 免费 | 简单 | 支持 |
| Netlify | ⚠️ 一般 | 免费 | 简单 | 支持 |
| 腾讯云COS | ✅ 优秀 | 便宜 | 中等 | 支持 |

## 注意事项
1. **文件大小**：GitHub Pages有1GB限制，足够使用
2. **流量限制**：每月100GB，足够内部使用
3. **构建时间**：每月300分钟，静态页面几乎不消耗
4. **访问速度**：GitHub有全球CDN，国内访问良好

## 技术支持
- GitHub文档：https://docs.github.com/pages
- 如有问题，查看GitHub Pages状态：https://www.githubstatus.com

## 完成！
部署后，团队成员即可在国内直接访问，无需VPN。