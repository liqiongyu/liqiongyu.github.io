#!/usr/bin/env bash
set -euo pipefail

# Create a bilingual page bundle:
#   ./scripts/new-bundle.sh posts my-new-post
# Creates:
#   content/posts/my-new-post/index.zh.md
#   content/posts/my-new-post/index.en.md

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <section> <slug>"
  exit 1
fi

SECTION="$1"
SLUG="$2"

BUNDLE_DIR="content/${SECTION}/${SLUG}"
mkdir -p "${BUNDLE_DIR}"

# translationKey: stable ID to unify translations (and comments)
# You can change it later, but keep it stable if you want comments to stay.
TK="${SECTION}/${SLUG}"

DATE="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

cat > "${BUNDLE_DIR}/index.zh.md" <<EOF
---
title: "（中文标题）${SLUG}"
date: ${DATE}
draft: true
translationKey: "${TK}"
tags: []
summary: ""
---

这里写中文内容。

行内公式示例：\(a^2+b^2=c^2\)

块级公式示例：

\[
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
\]

{{< comments >}}
EOF

cat > "${BUNDLE_DIR}/index.en.md" <<EOF
---
title: "(English Title) ${SLUG}"
date: ${DATE}
draft: true
translationKey: "${TK}"
tags: []
summary: ""
---

Write English content here.

Inline math: \(a^2+b^2=c^2\)

Block math:

\[
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
\]

{{< comments >}}
EOF

echo "Created:"
echo "  ${BUNDLE_DIR}/index.zh.md"
echo "  ${BUNDLE_DIR}/index.en.md"
