# Digital Bazaar 🛍️

**البازار الرقمي** — A bilingual (Arabic/English) digital magazine for the Arab tech community.

> Where the Arab digital world meets, trades, and grows.

## Dependencies

| Tool | Version | Install (macOS) | Required |
|------|---------|-----------------|----------|
| Ruby | 3.3+ | `brew install ruby` | ✅ |
| Bundler | 2.5+ | `gem install bundler` | ✅ |
| WebP | latest | `brew install webp` | Optional |

> ⚠️ **macOS users**: Add Homebrew Ruby to PATH — the system Ruby (2.6) won't work.
> ```bash
> echo 'export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
> ```

## Quick Start

```bash
git clone https://github.com/DigitalBazaarHub/digitalbazaar.github.io.git
cd digitalbazaar.github.io
make install
make setup-hooks   # Enable pre-commit checks
make serve
```

Visit [http://localhost:4000](http://localhost:4000)

## Commands

| Command | Description |
|---------|-------------|
| `make install` | Install dependencies |
| `make serve` | Dev server with live reload |
| `make prod-build` | Production build (run before committing) |
| `make build` | Build static site |
| `make clean` | Remove generated files |
| `make fonts` | Download self-hosted fonts |
| `make images` | Optimize images (PNG/JPG) |
| `make images-webp` | Convert to WebP (requires `webp`) |
| `make setup-hooks` | Enable git pre-commit hooks |

## Workflows

### Adding a New Article

```bash
# 1. Create the post file
touch _posts/$(date +%Y-%m-%d)-my-article-slug.md

# 2. Add front matter and content (see template below)

# 3. Preview locally
make serve

# 4. Build and commit
make prod-build
git add .
git commit -m "Add new article: My Article Title"
git push
```

### Updating Assets (Logo, Fonts, Images)

```bash
# 1. Replace source files in assets/img/ (keep originals)

# 2. Regenerate optimized versions
make images        # Creates resized PNG/JPG
make images-webp   # Creates WebP versions

# 3. If updating fonts
make fonts

# 4. Build and commit
make prod-build
git add .
git commit -m "Update assets"
git push
```

## Writing Articles

Create `_posts/YYYY-MM-DD-slug.md`:

```yaml
---
layout: article
title: "Your Title"
author: "Name"
date: 2025-01-15
lang: ar               # 'ar' or 'en'
category: community    # See _data/categories.yml
author_type: team      # 'team' or 'member'
excerpt: "Brief description"
reading_time: 5        # Minutes
---

Your content here (supports Markdown and HTML)...
```

## Project Structure

```
_config.yml        # Jekyll config
_data/             # Translations & content (strings_ar.yml, strings_en.yml, categories.yml)
_docs/             # Design system documentation
_includes/         # Components (article-card, header, footer)
_layouts/          # Templates (home, article, archive, rules)
_posts/            # Articles (bilingual)
pages/ar/, pages/en/  # Language-specific pages
assets/css/        # Styles (SCSS → compiled CSS)
assets/fonts/      # Self-hosted fonts (Space Grotesk, Tajawal)
assets/img/        # Optimized images (WebP)
scripts/           # Utility scripts (download-fonts.sh)
Makefile           # Dev commands
```

## Fonts

| Font | Language | Weights | Source |
|------|----------|---------|--------|
| Space Grotesk | English (LTR) | 400, 500, 700 | [Google Fonts](https://fonts.google.com/specimen/Space+Grotesk) |
| Tajawal | Arabic (RTL) | 400, 500, 700, 800 | [Google Fonts](https://fonts.google.com/specimen/Tajawal) |

Fonts are self-hosted for performance. Run `make fonts` to download.

## Deployment

Pushes to `main` auto-deploy via GitHub Actions → [digitalbazaarhub.github.io](https://digitalbazaarhub.github.io)

---

Made with ❤️ across the Arab world
