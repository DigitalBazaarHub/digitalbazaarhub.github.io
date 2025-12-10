# Digital Bazaar 🛍️

**البازار الرقمي** — A bilingual (Arabic/English) digital magazine for the Arab tech community.

> Where the Arab digital world meets, trades, and grows.

## 🚀 Quick Start

### Prerequisites

- Ruby 3.3+ (install via Homebrew: `brew install ruby`)
- Bundler (`gem install bundler`)

### Setup

```bash
# Clone the repository
git clone https://github.com/DigitalBazaarHub/digitalbazaar.github.io.git
cd digitalbazaar.github.io

# Install dependencies
make install

# Start local development server
make serve
```

Visit [http://localhost:4000](http://localhost:4000) to see the site.

## 🛠️ Local Development Environment Setup

### System Requirements

| Requirement | Version | Notes |
|-------------|---------|-------|
| **Ruby** | 3.3+ (recommended 3.4.x) | macOS system Ruby (2.6) will NOT work |
| **Bundler** | 2.5+ | Gem dependency manager |
| **Jekyll** | 4.4+ | Static site generator (installed via Bundler) |
| **macOS** | 12+ | Or Linux/WSL2 on Windows |

### macOS Setup (Homebrew)

The system Ruby on macOS is outdated and won't work. Install Ruby via Homebrew:

```bash
# 1. Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install Ruby
brew install ruby

# 3. Add Ruby to your PATH (add to ~/.zshrc or ~/.bashrc)
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"' >> ~/.zshrc

# 4. Reload your shell
source ~/.zshrc

# 5. Verify Ruby version (should show 3.3+ not 2.6)
ruby --version
# Expected: ruby 3.4.x (2024-xx-xx revision xxxxxxxx)

# 6. Install Bundler
gem install bundler
```

> ⚠️ **Important**: If `ruby --version` still shows `2.6.x`, your PATH is not configured correctly. The Homebrew Ruby must come BEFORE the system Ruby in your PATH.

### Linux Setup (Ubuntu/Debian)

```bash
# Install dependencies
sudo apt update
sudo apt install ruby-full build-essential zlib1g-dev

# Add gem path to ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Install Bundler
gem install bundler
```

### Project Setup

Once Ruby is properly installed:

```bash
# Clone the repository
git clone https://github.com/DigitalBazaarHub/digitalbazaar.github.io.git
cd digitalbazaar.github.io

# Install gem dependencies
make install

# Download self-hosted fonts (optional but recommended)
make fonts

# Start the development server
make serve
```

### Verify Your Environment

```bash
# Check all versions
ruby --version      # Should be 3.3+
bundler --version   # Should be 2.5+
jekyll --version    # Should be 4.4+ (after make install)

# Check Ruby location (should NOT be /usr/bin/ruby)
which ruby
# Expected: /opt/homebrew/opt/ruby/bin/ruby (macOS)
```

### Troubleshooting

| Problem | Solution |
|---------|----------|
| `Could not find 'bundler'` | Wrong Ruby version. Check `which ruby` — must be Homebrew Ruby, not system |
| `bundle: command not found` | Run `gem install bundler` with correct Ruby |
| `Permission denied` on gems | Don't use `sudo`. Fix your PATH or use `GEM_HOME` |
| Fonts not loading | Run `make fonts` to download self-hosted fonts |
| Port 4000 in use | Kill existing: `pkill -f jekyll` or use `--port 4001` |

### Environment Variables

The `Makefile` automatically sets the Ruby PATH for Homebrew installations:

```makefile
RUBY_PATH := /opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.4.0/bin
```

If your Ruby is installed elsewhere, update this path in the `Makefile`.

## 📋 Available Commands

Run `make help` to see all available commands:

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands |
| `make install` | Install Ruby gem dependencies |
| `make update` | Update all gems to latest versions |
| `make serve` | Start local dev server with live reload |
| `make serve-drafts` | Start server with draft posts visible |
| `make build` | Build the static site (output to `_site/`) |
| `make prod-build` | Build for production (minified) |
| `make clean` | Remove generated files and caches |
| `make fonts` | Download self-hosted fonts (DM Sans + Tajawal) |

### ⚠️ Before Committing

Always run a production build before committing your changes:

```bash
make prod-build
```

This is especially important when:
- **Changing CSS/SCSS** — Ensures styles are properly compiled and minified
- **Adding new pages or layouts** — Catches Liquid template errors
- **Modifying `_config.yml`** — Validates configuration changes

The production build will fail fast on errors that might not appear during `make serve`.

> 💡 **Tip**: Consider adding `make prod-build` to a pre-commit hook for automatic verification.

## 📁 Project Structure

```
├── _config.yml          # Jekyll configuration
├── _data/
│   ├── strings_ar.yml   # Arabic UI strings
│   ├── strings_en.yml   # English UI strings
│   ├── categories.yml   # Article categories
│   └── rules.yml        # Community rules (bilingual)
├── _docs/               # Design system documentation
├── _includes/           # Reusable components
├── _layouts/            # Page templates
├── _posts/              # Blog articles
├── ar/                  # Arabic pages
├── en/                  # English pages
├── assets/
│   ├── css/styles.scss  # Main stylesheet (Sass)
│   ├── fonts/           # Self-hosted fonts (woff2)
│   └── img/             # Images
├── scripts/
│   └── download-fonts.sh  # Font download script
├── .github/workflows/   # GitHub Actions for deployment
├── Gemfile              # Ruby dependencies
├── Gemfile.lock         # Locked dependency versions
└── Makefile             # Development commands
```

## ✍️ Writing Articles

Create a new file in `_posts/` with the format `YYYY-MM-DD-slug.md`:

```yaml
---
layout: article
title: "Your Article Title"
author: "Author Name"
date: 2025-01-15
lang: ar                    # 'ar' or 'en'
category: community         # See _data/categories.yml
author_type: team           # 'team' or 'member'
excerpt: "Brief description"
read_time: 5
---

Your content here...
```

## 🌐 Deployment

The site automatically deploys to GitHub Pages when you push to `main`.

- **Live site**: [https://digitalbazaarhub.github.io](https://digitalbazaarhub.github.io)
- **Deployment**: GitHub Actions (see `.github/workflows/jekyll.yml`)

## 🎨 Design System

- **Fonts**: Tajawal (Arabic), DM Sans (English)
- **Colors**: Sand, Saffron, Terracotta, Marigold, Teal, Night
- **RTL/LTR**: Automatic based on language

See `_docs/` for detailed design documentation.

## 📜 License

MIT License — see [LICENSE](LICENSE)

---

Made with ❤️ across the Arab world
