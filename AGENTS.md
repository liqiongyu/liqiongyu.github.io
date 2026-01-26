# Repository Guidelines

## Project Structure

- `hugo.toml`: Site config (languages, menus, giscus, theme params).
- `content/`: All content.
  - Home/About: `content/_index.*.md`, `content/about/index.*.md`
  - Posts (page bundles): `content/posts/<slug>/index.zh.md` + `index.en.md`
- `layouts/`: Local overrides for the Typo theme (partials, shortcodes, base template).
- `assets/` + `static/`: CSS/JS and static files. Custom domain is in `static/CNAME`.
- `themes/typo/`: Theme (git submodule). Do not edit unless you intend to contribute upstream.
- `public/`, `resources/`: Build outputs (ignored by git).

## Build, Test, and Development Commands

- `git submodule update --init --recursive`: Fetch theme submodule after cloning.
- `./scripts/dev.sh`: Run local dev server.
- `./scripts/build.sh`: Build production site (`hugo --gc --minify`) and generate Pagefind index.
- `./scripts/new-bundle.sh posts <slug>`: Create a bilingual post bundle (sets `translationKey` and adds `{{< comments >}}`).

## Content Conventions

- Prefer page bundles: `content/posts/my-topic/` and keep images/PDFs in the same folder.
- Publishing is controlled by front matter: set `draft: false` to ship.
- Keep `translationKey` stable to share giscus threads between languages.

## Coding Style

- Keep diffs minimal; follow existing formatting.
- Hugo templates (`layouts/`): 2-space indentation, use `site.*` helpers consistently.
- Avoid editing `public/` and `resources/`; always regenerate via `./scripts/build.sh`.

## Testing / Validation

- No unit test suite currently. Validate by running `./scripts/build.sh` and checking `hugo` output for errors.
- For content/UX changes, spot-check `/` and `/en/` locally via `./scripts/dev.sh`.

## Commit & Pull Request Guidelines

- Prefer Conventional Commits when possible: `feat: ...`, `fix: ...`, `chore: ...`.
- Before opening a PR: run `./scripts/build.sh`, include a short description, and add screenshots for layout/style changes.

## Configuration Notes

- Deployment is via GitHub Actions (`.github/workflows/hugo.yaml`); do not commit secrets.
- giscus is configured in `hugo.toml` under `[params.giscus]` (requires Discussions enabled in the comment repo).
