# 手把手：你需要手动完成的事情（一次性设置）

下面这些步骤需要你在 GitHub / DNS /（可选）Cloudflare 等平台上手动操作；我无法替你点击或创建资源。

## 1) 准备两个 GitHub 仓库（推荐）

建议分开两套仓库，方便迁移与隔离权限：

1) 站点源码仓库：`liqiongyu/liqiongyu.github.io`（user site）
2) 评论仓库：`liqiongyu/site-comments`（只用来放 GitHub Discussions）

为什么建议分开：
- 评论数据不会和站点源码绑定，未来迁移更轻
- 站点仓库保持干净，只维护内容与构建

## 2) 拉取 Typo 主题（两种方式二选一）

A. Git submodule（推荐给大多数人，最直观）
```bash
# 本仓库已经把 Typo 作为 submodule 固定到一个稳定版本。
# 新 clone 的情况下，你只需要初始化 submodule：
git submodule update --init --recursive
```

B. Hugo Module（更利于升级，但你要理解 go.mod）
1) 取消注释 `hugo.toml` 里的 `[module]` 配置（文件末尾有示例）  
2) 初始化并拉取：
```bash
hugo mod init github.com/liqiongyu/liqiongyu.github.io   # 如你的仓库名不同请自行修改
hugo mod get -u
```

## 3) 配置 giscus（评论）

目标：让同一篇文章的中英文页面共享同一个评论串。

1) 打开评论仓库 `liqiongyu/site-comments`
2) Settings → Features → 勾选 Discussions（若未开启）
3) 安装 giscus GitHub App，并授权到评论仓库
4) 打开 giscus 配置页，按提示选择（推荐值）：
   - Repository: `liqiongyu/site-comments`
   - Discussion category: 建议 `Announcements`（限制只有维护者/giscus 能创建新讨论，防止乱开贴）
   - Mapping: 选择 “Specific term”
   - Theme: `preferred_color_scheme`（跟随系统主题）
   - Loading: `lazy`（懒加载）
   - 其他按需

5) 从 giscus 生成的 script 中复制以下值：
   - `data-repo-id`
   - `data-category-id`

6) 回到站点仓库，编辑 `hugo.toml` 的 `[params.giscus]`：
   - `enabled = true`
   - `repo = "liqiongyu/site-comments"`
   - `repoId = "..."`（刚复制的 repo id）
   - `category = "Announcements"`
   - `categoryId = "..."`（刚复制的 category id）

说明：
- 本模板的 `comments` shortcode 会用 `data-term="{{ .Page.TranslationKey }}"`，保证中英页面共用讨论串。
- 如果你改了文章目录名但希望评论不丢，请保持 `translationKey` 不变。

## 4) GitHub Pages 部署（Actions）

### 4.1 用 git 推送代码到 `liqiongyu/liqiongyu.github.io`

```bash
git remote add origin https://github.com/liqiongyu/liqiongyu.github.io.git
git add -A
git commit -m "Initial blog"
git push -u origin main
```

### 4.2 用 GitHub CLI 尽量“一键配置”（推荐）

```bash
# 仓库基础信息（按需改 description/homepage）
gh repo edit liqiongyu/liqiongyu.github.io \
  --description "Personal blog (Hugo + Typo, bilingual)" \
  --homepage "https://blog.liqiongyu.com/" \
  --enable-issues=false --enable-projects=false --enable-wiki=false

# Actions: 允许 workflow 获得写权限（用于 Pages 部署）
gh api -X PUT repos/liqiongyu/liqiongyu.github.io/actions/permissions/workflow \
  -f default_workflow_permissions=write

# Pages: 使用 GitHub Actions 构建（build_type=workflow）
# user-site 仓库（*.github.io）通常会默认启用 Pages（legacy），这里用 PUT 切到 workflow。
gh api -X PUT repos/liqiongyu/liqiongyu.github.io/pages \
  -f build_type=workflow
```

> 提示：如果你在非 user-site 仓库上遇到 “Not Found / Pages 未启用”，先在网页 Settings → Pages 打开一次 Pages，再回到这里执行命令。

### 4.3 你仍需要在 GitHub 网页上确认的 1 个地方

GitHub → Settings → Pages → Source 选择 “GitHub Actions”（确保 Source 没有被设置成 “Deploy from a branch”）。

### 4.4 workflow 权限（如果你更偏向网页操作）

确认 workflow 有权限（一般默认即可）：
   - Settings → Actions → General → Workflow permissions
   - 选择 “Read and write permissions”

之后每次 push main，Actions 会：
- 安装 Hugo / Node /（可选）Dart Sass
- `hugo --minify` 构建
- `npx pagefind --site public` 建索引
- 部署到 Pages

### 绑定自定义域名：`blog.liqiongyu.com`

如果你要绑定自定义域名（推荐）：

1) 确保仓库里存在 `static/CNAME`（本模板已提供），内容为：
   - `blog.liqiongyu.com`
2) GitHub → Settings → Pages → Custom domain 填入 `blog.liqiongyu.com`
3) DNS 设置：
   - 给 `blog` 增加一条 CNAME 指向 GitHub Pages 提示的目标（按 GitHub UI 提示为准）
4) 等待 GitHub Pages 侧签发 HTTPS（Settings → Pages 会提示状态）

> 如果你还打算把域名接入 Cloudflare，建议先在 GitHub Pages 侧把 HTTPS 跑通，再接入 Cloudflare（避免同时排查两个系统的问题）。

## 5) （可选）Cloudflare：默认语言跳转

你在设计文档里提到“按 IP 默认语言”。目前你说暂时不需要，可以先不做。

如果未来要做：文件 `cloudflare/worker-lang-redirect.js` 提供了一个 Worker 示例，逻辑是：
- 只在访问 `/` 时判断并可能跳转
- 尊重 cookie `lang=zh|en`
- 深链接不强制跳转

你需要在 Cloudflare Dashboard：
1) Workers & Pages → Create Worker
2) 粘贴代码并部署
3) Routes 绑定到你的域名根路径（例如 `blog.liqiongyu.com/*`），或只绑定 `/`

## 6) Pagefind 搜索（默认按当前语言）

默认推荐：
- 对整个 `public/` 跑一次 Pagefind
- Pagefind 会根据每个页面的 `<html lang="...">` 自动按语言拆分索引，并在浏览器里自动加载当前语言索引

如果你未来仍然想“中英混搜”（同一个搜索框同时出中英结果）：
- 可以用 Pagefind 的 multisite/mergeIndex 方案，把另一语言索引合并进来（实现会复杂一些）
- 建议先把默认方案跑通上线，再做迭代
