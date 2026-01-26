# SEO 清单与建议（Hugo + 多语言）

这份文档把「站点层面的 SEO」拆成可落地的检查项，适合你上线前后对照。

## 1) 站点基础（必须做）

1. baseURL
- `hugo.toml` 里的 `baseURL` 必须是最终线上域名（你这里是 `https://blog.liqiongyu.com/`）
- 避免同时被多个域名访问并被索引（例如 `*.github.io` 和自定义域名同时可访问）

2. robots.txt
- 本模板已开启 `enableRobotsTXT = true`，Hugo 会生成默认 robots.txt
- 如果你想更细粒度控制（比如禁止某些路径），可以自定义 `layouts/robots.txt`

3. sitemap.xml
- Hugo 默认会生成 sitemap（多数主题/配置无需额外操作）
- 上线后把 sitemap 提交到 Search Console（见第 4 节）

4. 404 页面
- GitHub Pages 会使用 `404.html`。Hugo 通常会生成（或主题自带）。上线后点一个不存在的 URL 确认能返回 404。

## 2) 页面级 SEO（强烈建议）

1. Title / Description
- 每篇文章建议写清楚 `title`，并提供 `description`（或至少 `summary`）
- 搜索结果的摘要质量很大程度取决于 description/首段内容

2. Canonical
- 站点应当每页都有 `<link rel="canonical" href="...">`
- 大多数 Hugo 主题会默认输出 canonical；如果你发现没有，可以在主题 head partial 里补上（通常是 `.Permalink`）

3. Open Graph / Twitter Card
- 方便社交平台分享预览（标题、摘要、封面图）
- 很多主题会包含 OG tags；如果没有，可以考虑补充
- 每篇文章如果有封面图，建议配置 `images` 或 theme 支持的参数

4. 结构化数据（JSON-LD）
- 本模板在 `layouts/partials/hooks/head_end.html` 里为 posts/papers/notes/philosophy 输出了一个基础的 `BlogPosting` JSON-LD
- 如果未来要更精细（封面图、作者头像、publisher 组织等），可以继续扩展

## 3) 多语言站点（你这种 / 与 /en/）

你现在的结构是：
- 中文默认：`/`
- 英文：`/en/`

建议：
1) hreflang
- 推荐在页面 head 里为翻译页添加 `rel="alternate" hreflang="..."`，帮助搜索引擎理解不同语言版本的对应关系
- 本模板已在 `head_end.html` 里对「有翻译的页面」输出 hreflang links

2) 不要把两种语言互相 canonical 到同一个 URL
- 每个语言版本应当 canonical 指向自己
- 同时用 hreflang 去声明它们是翻译关系

3) 避免“强制按 IP 跳转”影响抓取
- 如果未来你要做按地区跳转，务必保证：
  - 深链接不强制跳转（分享链接可预期）
  - 尊重用户显式选择（cookie）
  - 对爬虫友好（不要形成循环跳转）

## 4) 上线后的必做：Google Search Console

1) 验证站点所有权（建议用 DNS 验证，更稳定）
2) 提交 sitemap
- `https://blog.liqiongyu.com/sitemap.xml`
3) 观察索引覆盖率
- 有没有被重复索引的域名（github.io vs 自定义域名）
- 有没有抓取异常（404、重定向循环等）

## 5) 性能与可抓取性（间接影响 SEO）

1) 首屏速度（Core Web Vitals）
- 避免首页引入过多 JS
- 评论（giscus）只在文章页加载，并保持 lazy（本模板已这样做）
- 搜索（Pagefind）只在搜索页加载（本模板已这样做）

2) 图片优化
- 为重要图片写 `alt`
- 封面图尽量使用合适的分辨率与格式（WebP/AVIF 如主题支持）

3) URL 稳定性
- 一篇文章发布后尽量不要改 slug/目录名
- 如果要改，建议在边缘层（Cloudflare）或站点层做 301 重定向（GitHub Pages 原生重定向能力有限）

## 6) 建议的写作习惯（内容导向）

- 用清晰的小标题（H2/H3）组织长文
- 文章开头 1-2 段写清楚“它解决什么问题”
- 多做站内链接（系列文章、相关笔记）
- 保持中英文文章一一对应（你已经决定这么做）
