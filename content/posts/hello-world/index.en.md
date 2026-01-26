---
title: "Hello, world"
date: 2026-01-26T08:06:41Z
draft: false
translationKey: "posts/hello-world"
tags: ["demo", "math"]
summary: "A demo post: page bundle, math, attachments, comments."
---

This is a demo post for validating:

- Page bundle resources (SVG/PDF)
- Build-time math rendering (avoid `$...$`)
- giscus comments (shared thread between translations)

## Resource examples

SVG:

![diagram](diagram.svg)

PDF attachment (via shortcode):

{{< attachment file="sample.pdf" text="Download sample PDF" >}}

## Math examples

Inline: \(a^2 + b^2 = c^2\)

Block:

\[
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
\]

{{< comments >}}
