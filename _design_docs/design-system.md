# Design System Reference

Detailed CSS implementations for the Digital Bazaar theme.

> **Last Updated:** December 2025

---

## Typography Scale

All font sizes use CSS custom properties for consistency:

```css
:root {
  --text-2xl: clamp(26px, 4vw, 34px);  /* H1: Page titles */
  --text-xl: 20px;                      /* H2: Section headings */
  --text-lg: 18px;                      /* H3: Subsection headings */
  --text-md: 16px;                      /* Body text, primary descriptions */
  --text-sm: 14px;                      /* Secondary text, muted body, excerpts */
  --text-xs: 12px;                      /* Captions, kickers, labels */
  --text-2xs: 10px;                     /* Tiny text, chips, code labels */
}
```

### System Fonts

```css
/* English (LTR) */
html[dir="ltr"], .lang-en {
  font-family: "Space Grotesk", system-ui, -apple-system, sans-serif;
  line-height: 1.7;
}

/* Arabic (RTL) - larger for script readability */
html[dir="rtl"], .lang-ar {
  font-family: "IBM Plex Sans Arabic", system-ui, sans-serif;
  font-size: var(--text-md);  /* +1px for Arabic */
  line-height: 1.85;
}
```

### Drop Caps

Magazine-style opening for articles:

```css
.article-content > p:first-of-type::first-letter {
  float: inline-start;
  font-size: 4rem;
  line-height: 0.8;
  font-weight: 700;
  color: var(--terracotta);
  padding-inline-end: 0.75rem;
  padding-block-start: 0.25rem;
}
```

### Pull Quotes

```css
/* Side pull quote */
.pull-quote {
  font-size: clamp(1.5rem, 3vw, 2.25rem);
  font-weight: 600;
  line-height: 1.3;
  color: var(--terracotta);
  padding-inline-start: 2rem;
  border-inline-start: 4px solid var(--saffron);
  margin-block: 3rem;
  margin-inline: -1rem;
}

/* Centered pull quote */
.pull-quote-center {
  font-size: clamp(1.5rem, 3vw, 2rem);
  font-weight: 600;
  text-align: center;
  color: var(--night);
  padding: 3rem 2rem;
  margin-block: 3rem;
  margin-inline: -2rem;
  background: linear-gradient(135deg, rgba(226,183,20,0.08), rgba(179,78,54,0.08));
  border-radius: 20px;
  position: relative;
}

.pull-quote-center::before,
.pull-quote-center::after {
  content: '"';
  font-size: 4rem;
  color: var(--saffron);
  opacity: 0.3;
  position: absolute;
}
.pull-quote-center::before { top: 0.5rem; left: 1rem; }
.pull-quote-center::after { bottom: -1rem; right: 1rem; }
```

---

## Spacing Scale

Consistent spacing tokens used throughout:

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

---

## Color Palette

### Light Mode

| Token | Value | Usage |
|-------|-------|-------|
| `--bg` | #F4E6C4 (sand) | Page background |
| `--text` | #21313B (ink) | Body text |
| `--text-heading` | #152029 (night) | Headings |
| `--text-muted` | #4a5d6a (muted) | Secondary text, captions |
| `--kicker` | #7a6330 | Section labels, category badges |
| `--card-bg` | #FFFBF0 (cream) | Card backgrounds |
| `--surface` | #FFFFFF | Elevated elements |
| `--surface-elevated` | #FFFDF6 | Slightly warm white |
| `--terracotta-tint` | rgba(179,78,54,.06) | Warm card backgrounds |
| `--border` | rgba(21, 32, 41, 0.08) | Light borders |
| `--border-strong` | rgba(21, 32, 41, 0.15) | Dividers, emphasis |

### Dark Mode

| Token | Value | Usage |
|-------|-------|-------|
| `--bg` | #152029 (night) | Page background |
| `--text` | #e5e7eb | Body text |
| `--text-heading` | #e5e7eb | Headings (soft white) |
| `--text-muted` | #9ca3af | Secondary text |
| `--kicker` | var(--saffron) | Golden accent |
| `--card-bg` | #21313B (ink) | Card backgrounds |
| `--surface` | #21313B (ink) | Cards |
| `--surface-elevated` | #1a2833 | Elevated cards |
| `--terracotta-tint` | rgba(179,78,54,.12) | Warm card backgrounds |

### Accent Colors

| Token | Value | Usage |
|-------|-------|-------|
| `--teal` | #2F8F9D | Links, interactive, cool accent |
| `--terracotta` | #B34E36 | Primary CTA, warm accent |
| `--saffron` | #E2B714 | Highlights, year headings |
| `--marigold` | #D9912A | Gradient endpoints |

---

## Code Blocks

### Styled Code Block

```css
pre {
  background: var(--night);
  color: #E5E7EB;
  padding: 1.5rem 2rem;
  border-radius: var(--radius-lg);
  overflow-x: auto;
  font-family: 'JetBrains Mono', 'Fira Code', 'SF Mono', monospace;
  font-size: 0.75rem;
  line-height: 1.6;
  margin-block: 2rem;
  box-shadow: var(--shadow-lg), inset 0 1px 0 hsla(0, 0%, 100%, 0.05);
}

/* Language label above code blocks */
.highlighter-rouge::before {
  content: attr(data-lang);
  position: absolute;
  top: 0;
  padding: 8px 14px;
  font-size: var(--text-2xs);
  font-family: "JetBrains Mono", "Fira Code", monospace;
  text-transform: lowercase;
  color: #6a7c89;
  background: rgba(0, 0, 0, 0.3);
  border-radius: var(--radius-lg) var(--radius-lg) 0 0;
}
```

### Inline Code

```css
code:not(pre code) {
  background: rgba(47, 143, 157, 0.12);
  color: var(--teal);
  padding: 0.15em 0.4em;
  border-radius: 4px;
  font-size: 0.9em;
  font-family: 'JetBrains Mono', 'Fira Code', monospace;
}
```

### Syntax Highlighting

```css
.highlight .k  { color: var(--terracotta); font-weight: 600; }  /* Keywords */
.highlight .s  { color: var(--saffron); }                        /* Strings */
.highlight .c  { color: #6a7c89; font-style: italic; }           /* Comments */
.highlight .n  { color: #e5e7eb; }                               /* Names */
.highlight .nf { color: var(--teal); }                           /* Functions */
.highlight .m  { color: var(--marigold); }                       /* Numbers */
```

---

## Section Dividers

```css
.divider {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  margin-block: 3rem;
  color: var(--muted);
}

.divider::before,
.divider::after {
  content: '';
  flex: 1;
  height: 1px;
  background: linear-gradient(90deg, transparent, rgba(179,78,54,0.3), transparent);
}

.divider span {
  font-size: 1.5rem;
}
```

Usage: `<div class="divider"><span>✦</span></div>`

---

## Layout Tokens

```css
:root {
  /* Border radius */
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 18px;
  --radius-full: 999px;

  /* Shadows */
  --shadow-sm: 0 2px 8px rgba(0,0,0,0.06);
  --shadow-md: 0 6px 16px rgba(0,0,0,0.08);
  --shadow-lg: 0 8px 24px rgba(0,0,0,0.12);
  --card-shadow: 0 4px 12px rgba(0,0,0,0.06);

  /* Container */
  --container-width: 940px;
}
```

---

## Gradients

```css
/* Background */
--bg-gradient: linear-gradient(180deg, #FFFDF6 0%, var(--sand) 100%);

/* Hero sections */
background: linear-gradient(135deg, rgba(179,78,54,0.10), rgba(47,143,157,0.10));

/* Primary button */
background: linear-gradient(135deg, var(--terracotta), var(--marigold));

/* Secondary button */
background: linear-gradient(135deg, rgba(47,143,157,0.12), rgba(47,143,157,0.24));

/* Logo */
background: conic-gradient(from 210deg, var(--terracotta), var(--marigold), var(--saffron));
```

---

## Buttons

```css
.btn {
  border-radius: var(--radius-full);
  padding: 10px 16px;
  font-size: var(--text-md);
  font-weight: 650;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  box-shadow: 0 8px 18px rgba(0,0,0,0.25);
  transition: transform var(--transition-fast), box-shadow var(--transition-slow);
  text-decoration: none;
  border: none;
  cursor: pointer;
}

.btn:hover {
  transform: translateY(-1px);
  filter: brightness(1.05);
}

.btn-primary {
  background: linear-gradient(135deg, var(--terracotta), var(--marigold));
  color: var(--white);
}

.btn-teal {
  background: linear-gradient(135deg, #2a7f8c, #1e6670);
  color: var(--white);
}

.btn-saffron {
  background: linear-gradient(135deg, var(--saffron), var(--marigold));
  color: var(--night);
}
```

---

## Cards

### Base Card (`.info-card`)

```css
.info-card {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: var(--space-md) calc(var(--space-md) + 2px);
  margin-bottom: var(--space-lg);
  box-shadow: var(--card-shadow);
}

/* Modifiers */
.info-card--featured { /* 3D elevated style */ }
.info-card--flat { /* No shadow, subtle */ }
.info-card--warm { background: var(--terracotta-tint); }
.info-card--tall { /* Extra vertical padding */ }
```

### Feature Cards (Homepage)

```css
.feature-card {
  background: var(--card-bg);
  border-radius: var(--radius-lg);
  border: 1px solid var(--border);
  padding: 14px 16px 16px;
  box-shadow: var(--card-shadow);
}

[data-theme="dark"] .feature-card {
  background: var(--ink);
}
```

### Rhythm Cards (Cadence Page)

```css
.rhythm-card {
  background: var(--white);  /* White in light mode */
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 24px 24px 28px;
  box-shadow: var(--card-shadow);
  transition: transform 0.12s ease, box-shadow 0.18s ease;
}

[data-theme="dark"] .rhythm-card {
  background: var(--ink);  /* 3D style in dark mode */
}

.rhythm-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 28px rgba(0,0,0,0.12);
}
```

---

## Lists

### Unified List Classes

```css
/* Base list (no bullets) */
.list-plain {
  list-style: none;
  padding: 0;
  margin: 0;
}

/* Arrow list (neutral guidance) */
.list-arrow li::before {
  content: "→";
  color: var(--teal);
  margin-inline-end: 8px;
}

/* Checkmark list (do this) */
.list-check li::before {
  content: "✓";
  color: var(--teal);
  margin-inline-end: 8px;
}

/* X list (don't do this) */
.list-cross li::before {
  content: "✗";
  color: var(--terracotta);
  margin-inline-end: 8px;
}
```

---

## Callout Boxes

```css
.callout-box {
  border-radius: var(--radius-md);
  padding: var(--space-md);
  font-size: var(--text-md);
  background: var(--surface-elevated);
  border: 1px dashed var(--border-strong);
}

/* Info variant - teal accent */
.callout-box--info {
  border-inline-start: 3px solid var(--teal);
  background: rgba(47, 143, 157, 0.08);
}

/* White variant - for CTAs */
.callout-box--white {
  background: var(--white);
  border: 1px solid var(--border);
}
```

---

## CTA Links

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

---

## Footer — "The Campfire"

The footer uses a dark background in both modes to create a warm, gathering-at-night feeling.

### Light Mode
- Background: `#3d2a28` (Terracotta Ground — warm, earthy)
- Text: `rgba(244, 230, 196, 0.85)` (Sand at 85%)
- Accents: Saffron links on hover

### Dark Mode
- Background: `#1a2a35` (slightly lighter than main)
- Same text and accent colors

### Structure

```css
.site-footer {
  margin-top: 48px;
  padding: 32px 20px 28px;
  background: #3d2a28;  /* Terracotta Ground */
  color: rgba(244, 230, 196, 0.85);
  font-size: var(--text-sm);
  position: relative;
}

/* Terracotta glow at top */
.site-footer::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, 
    transparent, 
    var(--terracotta) 20%, 
    var(--marigold) 50%, 
    var(--terracotta) 80%, 
    transparent
  );
}

[data-theme="dark"] .site-footer {
  background: #1a2a35;
}

.footer-title {
  font-weight: 600;
  margin-bottom: 8px;
  color: var(--sand);
  font-size: var(--text-md);
}

.footer-links a {
  color: rgba(244, 230, 196, 0.7);
}

.footer-links a:hover {
  color: var(--saffron);
}

.footer-tagline {
  font-size: var(--text-sm);
  color: rgba(244, 230, 196, 0.5);
  font-style: italic;
}

.footer-copyright {
  font-size: var(--text-xs);
  color: rgba(244, 230, 196, 0.4);
}
```

---

## Hint Text

Small, muted helper text:

```css
.hint-text {
  font-size: var(--text-sm);
  color: var(--text-muted);
  margin-top: 10px;
}
```

---

## RTL Support

All layouts use CSS logical properties for automatic RTL/LTR support:

| Physical | Logical | RTL Behavior |
|----------|---------|--------------|
| `margin-left` | `margin-inline-start` | Becomes `margin-right` |
| `padding-right` | `padding-inline-end` | Becomes `padding-left` |
| `text-align: left` | `text-align: start` | Becomes `right` |
| `float: left` | `float: inline-start` | Becomes `right` |

---

## Transitions

```css
:root {
  --transition-fast: 0.1s ease;
  --transition-slow: 0.25s ease;
}
```
