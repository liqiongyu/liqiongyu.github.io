将你已获授权的「方正兰亭宋」Web 字体文件放在这里。

## 约定文件名

- `FZLanTingSong-Regular.woff2`（必需，`font-weight: 400`）
- `FZLanTingSong-SemiBold.woff2`（可选，`font-weight: 600`）

站点会在构建时检测这些文件是否存在；存在才会注入对应的 `@font-face`（避免线上 404）。

## 许可提示

请确认你的方正字体授权允许**网页嵌入/分发 WebFont**（尤其是仓库/站点为公开分发时）。
