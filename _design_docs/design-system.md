# Design System Reference

The complete reference for the Digital Bazaar CSS architecture and component library.

> **Last Updated:** December 16, 2025

---

## Overview

The Digital Bazaar design system is a **token-based, component-driven CSS architecture** built for a bilingual (Arabic/English) Jekyll site.

### Core Principles

| Principle | Implementation |
|-----------|----------------|
| **Design Tokens** | All visual values as CSS custom properties in `:root` |
| **Component Pattern** | BEM-like naming: `.component`, `.component--variant`, `.component__element` |
| **Theme Support** | Light/dark modes via `[data-theme="dark"]` selector |
| **RTL Support** | CSS logical properties (`inline-start`, `block-end`) throughout |
| **Bilingual Content** | Jekyll includes with `lang` parameter, strings in `_data/strings_{lang}.yml` |

### Token Summary

| Category | Tokens | Range |
|----------|--------|-------|
| Font Sizes | 7 | `--text-2xs` → `--text-2xl` |
| Font Weights | 4 | `--font-regular` → `--font-bold` |
| Line Heights | 7 | `--leading-none` → `--leading-loose` |
| Spacing | 6 | `--space-xs` → `--space-2xl` (4px → 48px) |
| Border Radius | 7 | `--radius-xs` → `--radius-full` |
| Shadows | 8 | `--shadow-sm` → `--shadow-xl` + CTA variants |
| Colors | 20+ | Palette + semantic + dark mode variants |

---

## File Organization

```
assets/css/styles.scss (2750 lines)
│
├── 1. FONTS                      @font-face declarations
├── 2. CSS VARIABLES              All design tokens
│   └── 2b. DARK MODE             Theme overrides
├── 3. RESET & BASE               Minimal reset, body styles
├── 4. LAYOUT                     .wrap, container utilities
├── 5. NAVBAR                     Sticky header, mobile menu
│
├── 6. HERO - HOME                Homepage hero (gradient bg)
│   └── 6b. HERO - ARTICLES       Banner hero (image bg)
├── 7. BUTTONS                    .btn and variants
├── 8. SECTIONS                   .section spacing
│
├── 9. FEATURE CARDS              Homepage .feature-card
│   ├── 9b. INFO CARDS            .info-card + variants
│   ├── 9c. CALLOUT BOX           .callout-box + variants
│   ├── 9d. LISTS                 .list-plain, .list-check, etc.
│   ├── 9e. CTA LINKS             .cta-link
│   ├── 9f. PAGE HEADERS          .page-header, .page-subtitle
│   ├── 9g. CHECKLIST             .checklist-steps
│   ├── 9h. COPY BLOCKS           .template-wrapper, .copy-btn
│   ├── 9i. SECTION DIVIDER       .section-divider
│   └── 9j. HINTS                 .hint-text
│
├── 10. CHIPS/TAGS                Category pills
├── 11. TWO COLUMN                Sidebar layout
├── 12. MINI HEADING              Small section headers
│
├── 13. ARTICLE CARDS             .article-card grid
├── 14. ARCHIVE PAGE              Filters, year groups
├── 15. SINGLE ARTICLE            Article typography
├── 16. RULES PAGE                .rules-list, .rule-item
├── 17. FOOTER                    "Campfire" footer
├── 18. CODE BLOCKS               Syntax highlighting
├── 19. CADENCE PAGE              .rhythm-card, .rhythm-grid
└── 20. PRINT STYLES              @media print
```

---

## Design Tokens

### Typography

```css
:root {
  /* Font Sizes */
  --text-2xl: clamp(26px, 4vw, 34px);  /* H1: Page titles */
  --text-xl: 20px;                      /* H2: Section headings */
  --text-lg: 18px;                      /* H3: Subsection headings */
  --text-md: 16px;                      /* Body text */
  --text-sm: 14px;                      /* Secondary text */
  --text-xs: 12px;                      /* Captions, labels */
  --text-2xs: 10px;                     /* Chips, code labels */

  /* Font Weights */
  --font-regular: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;

  /* Line Heights */
  --leading-none: 1;          /* Nav toggles, icons */
  --leading-tight: 1.15;      /* Hero titles */
  --leading-heading: 1.2;     /* Display headings */
  --leading-snug: 1.5;        /* Cards, compact text */
  --leading-normal: 1.6;      /* Standard paragraphs */
  --leading-relaxed: 1.7;     /* Comfortable reading */
  --leading-loose: 1.85;      /* Arabic text */
}
```

### Spacing

```css
:root {
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 32px;
  --space-2xl: 48px;
}
```

### Border Radius

```css
:root {
  --radius-xs: 2px;       /* Micro elements, bars */
  --radius-sm: 4px;       /* Inline code */
  --radius-md: 9px;       /* Chips, toggles */
  --radius-lg: 16px;      /* Cards */
  --radius-xl: 18px;      /* Feature cards */
  --radius-2xl: 22px;     /* Hero banners */
  --radius-full: 999px;   /* Pills, buttons */
}
```

### Shadows

```css
:root {
  /* Elevation */
  --shadow-sm: 0 4px 10px rgba(0,0,0,0.18);
  --shadow-md: 0 7px 18px rgba(0,0,0,0.04);
  --shadow-lg: 0 10px 24px rgba(0,0,0,0.04);
  --shadow-xl: 0 16px 40px rgba(0,0,0,0.22);
  
  /* Interactive */
  --shadow-hover: 0 12px 26px rgba(0,0,0,0.10);
  --shadow-button: 0 8px 18px rgba(0,0,0,0.25);
  
  /* CTA Glows */
  --shadow-cta-saffron: 0 4px 12px rgba(226, 183, 20, 0.3);
  --shadow-cta-teal: 0 4px 12px rgba(47, 143, 157, 0.3);
}
```

### Transitions

```css
:root {
  --transition-fast: 0.06s ease;
  --transition-normal: 0.16s ease;
  --transition-slow: 0.18s ease;
}
```

---

## Color System

### Palette Colors

| Token | Hex | Usage |
|-------|-----|-------|
| `--sand` | #F4E6C4 | Light mode background |
| `--night` | #152029 | Dark mode background, headings |
| `--ink` | #21313B | Body text, dark surfaces |
| `--teal` | #2F8F9D | Links, interactive elements |
| `--terracotta` | #B34E36 | Primary CTA, warm accent |
| `--saffron` | #E2B714 | Highlights, year headings |
| `--marigold` | #D9912A | Gradient endpoints |
| `--muted` | #4a5d6a | Secondary text |
| `--kicker` | #7a6330 | Section labels |

### Semantic Tokens (Light Mode)

| Token | Value | Usage |
|-------|-------|-------|
| `--bg` | var(--sand) | Page background |
| `--text` | var(--ink) | Body text |
| `--text-heading` | var(--night) | Headings |
| `--text-muted` | var(--muted) | Secondary text |
| `--card-bg` | #FFFBF0 | Card backgrounds (cream) |
| `--surface-elevated` | #FFFDF6 | Elevated surfaces |
| `--terracotta-tint` | rgba(179,78,54,.06) | Warm card tint |
| `--border` | rgba(21,32,41,0.08) | Light borders |
| `--border-strong` | rgba(21,32,41,0.15) | Dividers |

### Semantic Tokens (Dark Mode)

| Token | Value | Usage |
|-------|-------|-------|
| `--bg` | var(--night) | Page background |
| `--text` | #e5e7eb | Body text |
| `--text-heading` | #e5e7eb | Headings |
| `--text-muted` | #9ca3af | Secondary text |
| `--card-bg` | #1a2833 | Card backgrounds |
| `--card-bg-featured` | var(--ink) | 3D/elevated cards |
| `--surface-elevated` | #1a2833 | Elevated surfaces |
| `--terracotta-tint` | rgba(179,78,54,.12) | Warm card tint |
| `--footer-bg` | #1a2a35 | Footer background |

---

## Component Library

### Cards

#### Info Card (`.info-card`)

The primary card component with multiple variants.

```css
.info-card {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: var(--space-md) calc(var(--space-md) + 2px);
  box-shadow: var(--shadow-md);
}
```

| Variant | Class | Description |
|---------|-------|-------------|
| Featured | `.info-card--featured` | 3D elevated, prominent |
| Flat | `.info-card--flat` | No shadow, subtle |
| Warm | `.info-card--warm` | Terracotta tint background |
| Tall | `.info-card--tall` | Extra vertical padding |
| Small | `.info-card--sm` | Compact padding |

**Grid Layout:**

```css
.info-card-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: var(--space-md);
}

.info-card-grid--lanes {
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
}
```

#### Feature Card (`.feature-card`)

Homepage-specific card with hover animation.

```css
.feature-card {
  background: var(--card-bg);
  border-radius: var(--radius-lg);
  padding: 14px 16px 16px;
  box-shadow: var(--shadow-md);
  transition: transform var(--transition-fast), box-shadow var(--transition-slow);
}

.feature-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-hover);
}
```

#### Rhythm Card (`.rhythm-card`)

Cadence page card for recurring events.

```css
.rhythm-card {
  background: var(--white);  /* White in light, ink in dark */
  border-radius: var(--radius-lg);
  padding: 24px 24px 28px;
  box-shadow: var(--shadow-md);
}

.rhythm-card:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow-hover);
}
```

---

### Lists

Base class removes default styling; add a variant for icons.

```css
.list-plain {
  list-style: none;
  padding: 0;
  margin: 0;
}

.list-plain li {
  padding-inline-start: 1.2em;
  position: relative;
}
```

| Variant | Icon | Color | Usage |
|---------|------|-------|-------|
| `.list-arrow` | → | Teal | Neutral guidance |
| `.list-check` | ✓ | Teal | "Do this" items |
| `.list-cross` | ✗ | Terracotta | "Don't do this" items |

**Example:**

```html
<ul class="list-plain list-check">
  <li>First item</li>
  <li>Second item</li>
</ul>
```

---

### Callout Boxes

Highlighted info boxes for important content.

```css
.callout-box {
  border-radius: var(--radius-md);
  padding: var(--space-md);
  font-size: var(--text-md);
  background: var(--surface-elevated);
  border: 1px dashed var(--border-strong);
}
```

| Variant | Class | Description |
|---------|-------|-------------|
| Info | `.callout-box--info` | Teal left border, teal tint bg |
| White | `.callout-box--white` | White bg, solid border |
| Spaced | `.callout-box--spaced` | Adds `margin-top: var(--space-lg)` |
| Aligned | `.callout-box--aligned` | `text-align: start` |

**Example:**

```html
<div class="callout-box callout-box--info">
  <strong>Note:</strong> Important information here.
</div>
```

---

### Buttons

Gradient buttons with shadow and hover effects.

```css
.btn {
  border-radius: var(--radius-full);
  padding: 10px 16px;
  font-size: var(--text-md);
  font-weight: 600;
  display: inline-flex;
  align-items: center;
  gap: var(--space-sm);
  box-shadow: var(--shadow-button);
  transition: transform var(--transition-fast);
  text-decoration: none;
  border: none;
  cursor: pointer;
}

.btn:hover {
  transform: translateY(-1px);
  filter: brightness(1.05);
}
```

| Variant | Class | Colors |
|---------|-------|--------|
| Primary | `.btn-primary` | Terracotta → Marigold gradient |
| Teal | `.btn-teal` | Teal gradient |
| Saffron | `.btn-saffron` | Saffron → Marigold gradient |

---

### CTA Links

Inline call-to-action links with arrow.

```css
.cta-link {
  font-size: var(--text-md);
  font-weight: 600;
  color: var(--teal);
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.cta-link:hover {
  color: var(--terracotta);
}
```

**Usage:**

```html
<a href="/en/cadence/" class="cta-link">See how it works →</a>
```

---

### Hint Text

Small, muted helper text.

```css
.hint-text {
  font-size: var(--text-sm);
  color: var(--text-muted);
  margin-top: 10px;
  font-style: italic;
}

.hint-text--aligned {
  text-align: start;
}
```

---

## Reusable Jekyll Includes

### Hero Banner

Responsive hero section with light/dark image variants.

**Include:**

```liquid
{% include hero-banner.html 
   image_base="articles_hero_banner" 
   alt=strings.cadence_page.hero_alt
   kicker=strings.cadence_page.kicker
   title=strings.cadence_page.title
   subtitle=strings.cadence_page.subtitle
   hero_class="cadence-hero-image"
%}
```

**Parameters:**

| Param | Required | Description |
|-------|----------|-------------|
| `image_base` | No | Base filename (default: `articles_hero_banner`) |
| `alt` | No | Alt text for accessibility |
| `kicker` | No | Small label above title |
| `title` | Yes | Main H1 heading |
| `subtitle` | No | Text below title |
| `hero_class` | No | Additional CSS class |

**Required Images:**

```
assets/img/{image_base}-600.webp
assets/img/{image_base}-800.webp
assets/img/{image_base}-1200.webp
assets/img/{image_base}_dark-600.webp
assets/img/{image_base}_dark-800.webp
assets/img/{image_base}_dark-1200.webp
```

---

### Copy Block

Copy-to-clipboard template block with button.

**Include:**

```liquid
{% include copy-block.html
   id="intro-template-text"
   heading=strings.start_here_page.intro_template.heading
   heading_level=2
   content=strings.start_here_page.intro_template.template
   button_text=strings.start_here_page.intro_template.copy_button
   copied_text=strings.start_here_page.intro_template.copied
   hint=strings.start_here_page.intro_template.hint
   lang=lang
%}
```

**Parameters:**

| Param | Required | Description |
|-------|----------|-------------|
| `id` | Yes | Unique ID for the `<pre>` element |
| `heading` | No | Heading above the block |
| `heading_level` | No | H level (default: 2) |
| `content` | Yes | Text to copy |
| `button_text` | No | Button text (default: "Copy") |
| `copied_text` | No | After-copy text (default: "Copied!") |
| `hint` | No | Hint text below |
| `lang` | No | Language for RTL (`ar` or `en`) |

---

### Other Includes

| Include | Purpose |
|---------|---------|
| `article-card.html` | Article card for listings |
| `header.html` | Site header with navigation |
| `footer.html` | "Campfire" footer |
| `language-toggle.html` | EN/AR language switcher |

---

## Adding a New Page

### Step 1: Create the Layout

Create `_layouts/my-page.html`:

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
   id="my-template"
   heading=strings.my_page.template.heading
   content=strings.my_page.template.content
   button_text=strings.my_page.template.copy
   lang=lang
%}

<!-- FAQ section (if needed) -->
<section class="section">
  <h2>{{ strings.my_page.faq.heading }}</h2>
  {% for item in strings.my_page.faq.items %}
  <div class="faq-item">
    <strong>{{ item.question }}</strong>
    <p>{{ item.answer }}</p>
  </div>
  {% endfor %}
</section>

{{ content }}
```

### Step 2: Create Page Files

```bash
# Arabic
mkdir -p pages/ar/my-page
cat > pages/ar/my-page/index.html << 'EOF'
---
layout: my-page
lang: ar
permalink: /ar/my-page/
---
EOF

# English
mkdir -p pages/en/my-page
cat > pages/en/my-page/index.html << 'EOF'
---
layout: my-page
lang: en
permalink: /en/my-page/
---
EOF
```

### Step 3: Add Strings

Add to `_data/strings_en.yml` (and Arabic equivalent):

```yaml
my_page:
  title: "Page Title"
  subtitle: "Page description"
  heading: "Section Heading"
  items:
    - title: "Item 1"
      description: "Description 1"
  template:
    heading: "📝 Copy this"
    content: |
      Template text...
    copy: "Copy"
```

### Step 4: Add Navigation (Optional)

Update `_includes/header.html` to add the nav link.

---

## Footer — "The Campfire"

The footer uses a dark, warm background in both themes to create a gathering-at-night feeling.

### Colors

| Theme | Background | Text |
|-------|------------|------|
| Light | `#3d2a28` (Terracotta Ground) | `rgba(244,230,196,0.85)` (Sand @ 85%) |
| Dark | `#1a2a35` (Cool ink) | Same as light |

### Structure

```css
.site-footer {
  margin-top: var(--space-2xl);
  padding: 32px 20px 28px;
  background: #3d2a28;
  color: rgba(244, 230, 196, 0.85);
  position: relative;
}

/* Gradient border at top */
.site-footer::before {
  content: "";
  position: absolute;
  top: 0;
  inset-inline: 0;
  height: 3px;
  background: linear-gradient(90deg, 
    transparent, var(--terracotta) 20%, 
    var(--marigold) 50%, 
    var(--terracotta) 80%, transparent
  );
}
```

---

## RTL Support

All layouts use CSS logical properties for automatic RTL/LTR support.

| Physical Property | Logical Property |
|-------------------|------------------|
| `margin-left` | `margin-inline-start` |
| `margin-right` | `margin-inline-end` |
| `padding-left` | `padding-inline-start` |
| `padding-right` | `padding-inline-end` |
| `text-align: left` | `text-align: start` |
| `text-align: right` | `text-align: end` |
| `left: 0` | `inset-inline-start: 0` |
| `right: 0` | `inset-inline-end: 0` |
| `float: left` | `float: inline-start` |

---

## System Fonts

```css
/* English (LTR) */
html[dir="ltr"] {
  font-family: "Space Grotesk", system-ui, sans-serif;
  line-height: var(--leading-relaxed);
}

/* Arabic (RTL) */
html[dir="rtl"] {
  font-family: "IBM Plex Sans Arabic", system-ui, sans-serif;
  line-height: var(--leading-loose);
}
```

| Font | Language | Weights | Source |
|------|----------|---------|--------|
| Space Grotesk | English | 400, 500, 700 | Self-hosted |
| IBM Plex Sans Arabic | Arabic | 400, 500, 700 | Self-hosted |
