# Digital Bazaar 💬

**البازار الرقمي** — A bilingual (Arabic/English) digital community for the Arab world.

> A modern bazaar for Arab digital minds.

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
| `make assets` | Download self-hosted assets (fonts + JS) |
| `make images` | Optimize images (PNG/JPG) |
| `make images-webp` | Convert to WebP (requires `webp`) |
| `make setup-hooks` | Enable git pre-commit hooks |

## Adding a New Page

```bash
# 1. Create the layout
touch _layouts/my-page.html

# 2. Create page files for each language
mkdir -p ar/my-page en/my-page
echo '---\nlayout: my-page\nlang: ar\npermalink: /ar/my-page/\n---' > ar/my-page/index.html
echo '---\nlayout: my-page\nlang: en\npermalink: /en/my-page/\n---' > en/my-page/index.html

# 3. Add strings to _data/strings_ar.yml and _data/strings_en.yml

# 4. Preview and build
make serve
make prod-build
```

**Layout template:**

```liquid
---
layout: default
---
{%- assign lang = page.lang | default: site.default_lang -%}
{%- assign strings = site.data['strings_' | append: lang] -%}

{% include hero-banner.html 
   image_base="my_page_hero"
   title=strings.my_page.title
   subtitle=strings.my_page.subtitle
%}

<section class="section">
  <h2>{{ strings.my_page.heading }}</h2>
  <div class="info-card-grid">
    {% for item in strings.my_page.items %}
    <div class="info-card info-card--flat">
      <h3>{{ item.title }}</h3>
      <p>{{ item.description }}</p>
    </div>
    {% endfor %}
  </div>
</section>

{% include copy-block.html
   id="template-text"
   heading=strings.my_page.template.heading
   content=strings.my_page.template.content
   button_text=strings.my_page.template.copy
   lang=lang
%}
```

📖 **Full reference:** See [`_design_docs/design-system.md`](_design_docs/design-system.md) for all components, tokens, and patterns.

## Adding an Article

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
reading_time: 5
---

Your content here...
```

## Adding a Recap

Recaps are past community events (firesides, panels, Q&As, workshops, etc.). Add new recaps to `_data/pages/recaps.yml` — add entries at the top of the `items` list (newest first).

Each recap entry:

```yaml
- title:
    en: "Event Title in English"
    ar: "عنوان الفعالية بالعربية"
  date: "2025-01-18"                    # YYYY-MM-DD format
  event_type: fireside                  # fireside | panel | qa | workshop | bazaar_saturday | other
  host:
    en: "Host Name"
    ar: "اسم المضيف"
  description:
    en: "Brief summary of what happened and key takeaways."
    ar: "ملخص موجز لما حدث والنقاط الرئيسية."
  url: null                             # Optional: link to detailed recap article (see below)
```

**Event types:** `fireside`, `panel`, `qa`, `workshop`, `bazaar_saturday`, `other`

**Optional detailed recap:** If the event has a full write-up, link it via the `url` field. Two formats supported:

```yaml
# Same article for both languages:
  url: /articles/en-building-in-public-recap/

# Different articles per language:
  url:
    en: /articles/en-building-in-public-recap/
    ar: /articles/ar-building-in-public-recap/
```

**View the page:** `/en/recaps/` or `/ar/recaps/` (not linked from nav — direct access only)

## Project Structure

```
_config.yml           # Jekyll config
_data/                # Translations (strings_ar.yml, strings_en.yml)
_design_docs/         # Design system documentation
_includes/            # Reusable components
  ├── hero-banner.html   # Hero with light/dark images
  ├── copy-block.html    # Copy-to-clipboard template
  ├── article-card.html  # Article card component
  ├── header.html        # Site header
  └── footer.html        # Site footer
_layouts/             # Page templates
_posts/               # Articles
ar/, en/              # Language-specific pages
assets/
  ├── css/styles.scss    # Main stylesheet
  ├── fonts/             # Self-hosted fonts
  └── img/               # Optimized images
```

## Fonts

| Font | Language | Weights |
|------|----------|---------|
| Space Grotesk | English | 400, 500, 700 |
| IBM Plex Sans Arabic | Arabic | 400, 500, 700 |

Fonts are self-hosted. Run `make assets` to download.

## Deployment

Pushes to `main` auto-deploy via GitHub Actions → [digitalbazaarhub.github.io](https://digitalbazaarhub.github.io)

---

Made with ❤️ across the Arab world
