# Hugo + Typo 双语博客脚手架（含 ToMath 数学、giscus 评论、Pagefind 搜索）

这个仓库是一个“尽量少魔法、可长期维护”的 Hugo 项目骨架，配合 Typo 主题，支持：

- 中文默认根路径 `/`，英文 `/en/`
- Page Bundle（目录式文章）：同目录放图片/SVG/PDF
- Hugo 构建期数学渲染：`\(...\)` 行内、`\[...\]`/`$$...$$` 块级（基于 `transform.ToMath`）
- giscus 评论：按 TranslationKey 统一中英评论串（mapping=specific + term=TranslationKey）
- Pagefind 全文搜索：构建后索引 `public/`，纯静态部署
- GitHub Pages + GitHub Actions 自动部署（含 Pagefind 索引步骤）

> 注意：主题 Typo 本体不包含在 git 主仓库的历史里（以 submodule 形式引用）。新 clone 后记得初始化 submodule（下文有步骤）。

---

## 0. 依赖

- Hugo Extended（建议使用最新稳定版；本模板按 Hugo v0.154.5 测试）
- Node.js（用于 `npx pagefind ...`，不需要你维护依赖锁文件）
- Git

---

## 1. 快速开始（本地）

1) 拉取主题（两种方式二选一）：

A. Git submodule（最直观，本仓库默认就是这种方式）
```bash
git submodule update --init --recursive
```

B. Hugo Module（更易于升级，但你需要 go.mod）
- 在 `hugo.toml` 里添加 module import（见文件里的注释），并执行：
```bash
hugo mod init github.com/liqiongyu/liqiongyu.github.io  # 如仓库名不同请自行修改
hugo mod get -u
```

2) 启动开发服务器
```bash
./scripts/dev.sh
```

3) 生成静态站点 + Pagefind 索引
```bash
./scripts/build.sh
```

构建产物在 `public/`。

---

## 2. 创建一篇中英双语的新文章（推荐）

脚本会创建 Page Bundle 目录，并生成 `index.zh.md` + `index.en.md`，同时写入相同的 `translationKey`，并在文末放入 `{{< comments >}}`。

```bash
./scripts/new-bundle.sh posts my-new-post
```

你也可以把 `posts` 换成 `papers` / `notes` / `philosophy` 等 section。

---

## 3. 配置 giscus（必须你自己做一次）

在 `hugo.toml` 的 `[params.giscus]` 填上以下信息：

- repo（例如 `liqiongyu/site-comments`）
- repoId（giscus 生成脚本里有）
- category（建议 Announcements）
- categoryId
- 其余参数可按需调整

本项目的 `comments` shortcode 会用：
- `data-mapping="specific"`
- `data-term="{{ .Page.TranslationKey }}"`

从而让中英文页面共享同一讨论串。

---

## 4. 配置 Pagefind 搜索

本项目内置 `/search/` 与 `/en/search/` 页面（layout: search）。默认只搜索当前语言（Pagefind 会根据页面的 `lang` 自动选择索引）。

构建后运行 Pagefind 会生成：
- `public/pagefind/`（包含 UI bundle 与索引数据）

如果你部署在 GitHub Pages 的子路径（project site），模板里使用了 `relURL` 来确保路径正确。

---

## 5. GitHub Pages 部署

已提供 `.github/workflows/hugo.yaml`，默认在 main 分支 push 时构建并部署到 GitHub Pages。

你需要在 GitHub 仓库里：
- Settings → Pages → Source 选择 “GitHub Actions”
-（如果你用 submodule 拉主题，注意 workflow checkout 已开启 submodules）


## 5.1 自定义域名（可选）

如果你要用自定义域名（例如 `blog.liqiongyu.com`），可以在 `static/CNAME` 写入域名。

同时在 GitHub 仓库 Settings → Pages 里设置 Custom domain，并按提示完成 DNS/HTTPS。

---

---

## 6. 目录结构

- `content/`：内容（含多语言文件）
- `layouts/`：
  - `_default/_markup/render-passthrough.html`：数学渲染 hook
  - `search/single.html`：搜索页面模板
  - `shortcodes/comments.html`：giscus
  - `shortcodes/attachment.html`：用 Page Resource 生成附件链接
  - `partials/hooks/head_end.html`：按需注入 KaTeX CSS（Typo hooks）
- `assets/css/custom.css`：覆盖样式
- `scripts/`：常用脚本

---

## 7. 常见坑

- Typo v3 之后需要在 config 里设置 `markup.highlight.noClasses = false` 才能让代码高亮样式正常（已在本项目内设置）。
- 如果你修改文章目录名或想让评论永久稳定，建议保持 `translationKey` 不变。
