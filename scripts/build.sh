#!/usr/bin/env bash
set -euo pipefail

# Build the site
hugo --gc --minify

# Build Pagefind index (requires Node.js)
# This generates public/pagefind/
npx -y pagefind@1.4.0 --site public
