---
title: "你好，世界"
date: 2026-01-26T08:06:41Z
draft: false
translationKey: "posts/hello-world"
tags: ["demo", "math"]
summary: "一个示例文章：Page Bundle、数学公式、附件、评论。"
---

这是一篇示例文章，用来验证：

- Page Bundle 内资源（SVG/PDF）
- Hugo 构建期数学渲染（不使用 `$...$`）
- giscus 评论（中英文共享同一串）

## 资源引用示例

SVG：

![diagram](diagram.svg)

PDF 附件（通过 shortcode 生成稳定链接）：

{{< attachment file="sample.pdf" text="下载示例 PDF" >}}

## 数学公式示例

行内：\(a^2 + b^2 = c^2\)

块级：

\[
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
\]

{{< comments >}}
