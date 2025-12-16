# CSS Framework Research: Digital Bazaar

**Date:** December 2025  
**Status:** Research complete — **Custom CSS chosen** (no framework adopted)  
**Purpose:** Evaluate CSS frameworks for cross-browser compatibility, RTL support, and design flexibility

> **Outcome:** After evaluation, we chose to continue with custom CSS using design tokens 
> (CSS custom properties) rather than adopting a framework. This provides maximum flexibility 
> for our magazine aesthetic while keeping the codebase simple. The custom design system uses 
> `--text-*`, `--space-*`, and `--radius-*` tokens similar to Open Props.

---

## Executive Summary

This document analyzes CSS frameworks for adoption in Digital Bazaar, a bilingual Arabic/English Jekyll site. The primary goals are:

1. **Browser compatibility** — Eliminate cross-browser styling inconsistencies
2. **RTL support** — Native or easy-to-implement right-to-left layouts
3. **Design flexibility** — Preserve our custom Middle Eastern-inspired aesthetic
4. **Maintainability** — Reduce custom CSS maintenance burden

### Recommendation

**Tailwind CSS** is the recommended choice for Digital Bazaar, with **Open Props** as a lightweight alternative worth considering.

---

## Frameworks Analyzed

| Framework | Type | Size (minified) | RTL Support | Learning Curve |
|-----------|------|-----------------|-------------|----------------|
| **Tailwind CSS** | Utility-first | ~3-10KB (purged) | Excellent | Medium |
| **Bootstrap 5** | Component-based | ~25KB CSS | Native | Low |
| **Bulma** | Component-based | ~26KB | Plugin required | Low |
| **Open Props** | CSS custom properties | ~5KB | Manual | Low |
| **Pico CSS** | Classless/minimal | ~10KB | Limited | Very Low |

---

## 1. Tailwind CSS

### Overview
A utility-first CSS framework that provides low-level utility classes (e.g., `flex`, `pt-4`, `text-center`) instead of pre-designed components. You compose designs by combining utilities directly in your HTML.

### Pros

| Advantage | Details |
|-----------|---------|
| **Excellent browser support** | Targets modern browsers with consistent rendering; autoprefixer handles vendor prefixes automatically |
| **Native RTL support** | Built-in `rtl:` and `ltr:` variants for direction-specific styling |
| **Design freedom** | No pre-designed components to override; build anything from scratch |
| **Tiny production bundle** | PurgeCSS removes unused styles; typical sites are 3-10KB |
| **Responsive utilities** | `sm:`, `md:`, `lg:`, `xl:` prefixes for breakpoints |
| **Dark mode support** | Built-in `dark:` variant |
| **Active ecosystem** | Tailwind UI, Headless UI, community plugins |
| **CSS logical properties** | Supports `ms-*`, `me-*`, `ps-*`, `pe-*` for RTL-aware spacing |

### Cons

| Disadvantage | Details |
|--------------|---------|
| **HTML verbosity** | Class names can become long; mitigated by `@apply` or components |
| **Learning curve** | Need to learn utility class naming conventions |
| **No pre-built components** | Must build or source UI components yourself |

### RTL Implementation

```html
<!-- Tailwind's RTL support -->
<div class="ms-4 ps-2">  <!-- margin-start, padding-start -->
  <span class="text-start">Aligned to start</span>
</div>

<!-- Direction-specific -->
<div class="ltr:ml-4 rtl:mr-4">
  Direction-aware margin
</div>
```

### Jekyll Integration Options

Tailwind offers **three integration approaches** with varying complexity:

#### Option 1: Standalone CLI (Recommended for Jekyll) ⭐

**No Node.js required!** Tailwind provides a standalone executable binary.

```bash
# Download (macOS ARM)
curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
chmod +x tailwindcss-macos-arm64
mv tailwindcss-macos-arm64 ./bin/tailwindcss

# Generate CSS
./bin/tailwindcss -i src/input.css -o assets/css/tailwind.css --watch
```

**Complexity: Low** — Just one binary file, no package.json, no node_modules.

| Platform | Binary |
|----------|--------|
| macOS (Apple Silicon) | `tailwindcss-macos-arm64` |
| macOS (Intel) | `tailwindcss-macos-x64` |
| Linux | `tailwindcss-linux-x64` |
| Windows | `tailwindcss-windows-x64.exe` |

#### Option 2: Node.js + PostCSS (Full Setup)

Traditional approach with full ecosystem access:

```bash
npm install tailwindcss postcss autoprefixer
npx tailwindcss init
```

**Complexity: Medium-High** — Requires Node.js, npm, config files.

#### Option 3: Play CDN (Development Only)

Zero setup for prototyping:

```html
<script src="https://cdn.tailwindcss.com"></script>
```

**Complexity: None** — But not suitable for production (3MB+ download).

---

## 2. Bootstrap 5

### Overview
The most popular CSS framework, offering pre-designed components (buttons, cards, modals, navbars) with JavaScript functionality. Bootstrap 5 introduced native RTL support and dropped jQuery dependency.

### Pros

| Advantage | Details |
|-----------|---------|
| **Comprehensive component library** | Buttons, forms, modals, navbars, cards, etc. ready to use |
| **Native RTL support (v5+)** | Official RTL build; just swap the CSS file |
| **Excellent browser support** | Tested across all major browsers |
| **Extensive documentation** | Well-documented with examples |
| **Large community** | Countless themes, templates, and Stack Overflow answers |
| **No build step required** | Can use CDN or downloaded CSS/JS files |
| **Grid system** | Robust 12-column responsive grid |
| **Familiar to most developers** | Industry standard; easy to find help |

### Cons

| Disadvantage | Details |
|--------------|---------|
| **Design uniformity** | Sites tend to "look like Bootstrap" unless heavily customized |
| **Opinionated styling** | Overriding default styles requires `!important` or deep customization |
| **Larger bundle size** | ~25KB CSS + ~15KB JS even with tree-shaking |
| **Component lock-in** | Deviating from Bootstrap patterns requires significant CSS work |
| **JavaScript dependency** | Many components require Bootstrap JS bundle |
| **Customization complexity** | Sass variables help, but deep changes are tedious |

### RTL Implementation

```html
<!-- Just use the RTL stylesheet -->
<link href="bootstrap.rtl.min.css" rel="stylesheet">

<!-- Or with logical properties -->
<div class="ms-3 ps-2 text-start">
  Automatically RTL-aware
</div>
```

### Jekyll Integration Complexity
**Low** — Simple CDN links or copy CSS/JS to assets folder.

---

## 3. Bulma

### Overview
A modern CSS-only framework (no JavaScript) based on Flexbox. Known for its clean, readable class names and modular architecture.

### Pros

| Advantage | Details |
|-----------|---------|
| **CSS-only** | No JavaScript required; works with any JS framework |
| **Clean syntax** | Readable class names like `is-primary`, `has-text-centered` |
| **Modular** | Import only the components you need |
| **Flexbox-based** | Modern layout system |
| **Good documentation** | Clear examples and API reference |
| **Lightweight** | Smaller than Bootstrap when using only needed modules |

### Cons

| Disadvantage | Details |
|--------------|---------|
| **No native RTL support** | Requires community plugin (bulma-rtl) or manual work |
| **Smaller ecosystem** | Fewer themes and community resources than Bootstrap/Tailwind |
| **No JavaScript components** | Must implement modals, dropdowns, etc. yourself |
| **Less active development** | Updates less frequent than Tailwind/Bootstrap |
| **Limited utility classes** | Fewer utilities compared to Tailwind |

### RTL Implementation
Requires the `bulma-rtl` package or manual CSS overrides:

```bash
npm install bulma-rtl
```

### Jekyll Integration Complexity
**Low** — Simple Sass import or CDN.

---

## 4. Open Props

### Overview
A modern approach using CSS custom properties (variables) instead of utility classes. Provides a design token system for colors, spacing, typography, shadows, etc.

### Pros

| Advantage | Details |
|-----------|---------|
| **No build step** | Pure CSS; works with any setup |
| **Design tokens approach** | Consistent design system via CSS variables |
| **Extremely lightweight** | Import only what you need (~1-5KB typical) |
| **Framework agnostic** | Works with anything; just CSS |
| **No class name learning** | Use standard CSS with variable values |
| **Progressive enhancement** | Add to existing CSS without rewriting |
| **Future-proof** | Based on CSS standards, not framework conventions |

### Cons

| Disadvantage | Details |
|--------------|---------|
| **No components** | Just design tokens; build everything yourself |
| **No RTL utilities** | Must implement direction logic manually |
| **Smaller community** | Newer, less Stack Overflow coverage |
| **More CSS writing** | You still write traditional CSS, just with better variables |
| **Learning curve for tokens** | Need to learn the variable naming system |

### Example Usage

```css
.card {
  padding: var(--size-4);
  border-radius: var(--radius-2);
  box-shadow: var(--shadow-2);
  background: var(--surface-1);
}
```

### Jekyll Integration Complexity
**Very Low** — Just import the CSS file.

---

## 5. Pico CSS

### Overview
A minimal, semantic CSS framework that styles native HTML elements without requiring classes. Great for content-focused sites.

### Pros

| Advantage | Details |
|-----------|---------|
| **Classless option** | Semantic HTML styled automatically |
| **Very lightweight** | ~10KB |
| **No build step** | Just include the CSS |
| **Dark mode** | Automatic dark mode via `prefers-color-scheme` |
| **Accessibility** | Focus states, ARIA support built-in |
| **Responsive** | Mobile-first by default |

### Cons

| Disadvantage | Details |
|--------------|---------|
| **Limited customization** | Designed for minimal sites; less flexible |
| **No RTL support** | Manual implementation required |
| **No component library** | Just base element styling |
| **Opinionated design** | Harder to deviate from Pico's aesthetic |
| **Not for complex UIs** | Better for documentation/blogs than web apps |

### Jekyll Integration Complexity
**Very Low** — Single CSS import.

---

## Comparison Matrix

### Browser Compatibility

| Framework | IE11 | Edge | Chrome | Firefox | Safari | Mobile |
|-----------|------|------|--------|---------|--------|--------|
| Tailwind CSS | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Bootstrap 5 | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Bulma | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Open Props | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Pico CSS | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |

*Note: IE11 reached end-of-life in June 2022. No modern frameworks support it.*

### RTL Support

| Framework | Native RTL | Implementation Effort | Quality |
|-----------|------------|----------------------|---------|
| Tailwind CSS | ✅ Built-in | Low | Excellent |
| Bootstrap 5 | ✅ Built-in | Very Low | Excellent |
| Bulma | ❌ Plugin | Medium | Good |
| Open Props | ❌ Manual | High | N/A |
| Pico CSS | ❌ Manual | High | N/A |

### Design Flexibility

| Framework | Customization | Override Difficulty | Design Freedom |
|-----------|--------------|---------------------|----------------|
| Tailwind CSS | Excellent | N/A (no defaults) | 🟢 Complete |
| Bootstrap 5 | Good | Medium-High | 🟡 Moderate |
| Bulma | Good | Medium | 🟡 Moderate |
| Open Props | Excellent | N/A (no defaults) | 🟢 Complete |
| Pico CSS | Limited | High | 🔴 Limited |

### Jekyll Integration

| Framework | Build Step | Complexity | Files to Add |
|-----------|------------|------------|--------------|
| Tailwind CSS (Standalone CLI) | Required | **Low** | Binary + tailwind.config.js |
| Tailwind CSS (Node.js) | Required | High | tailwind.config.js, postcss.config.js, package.json |
| Bootstrap 5 | Optional | Low | CSS + JS files or CDN links |
| Bulma | Optional | Low | CSS file or Sass import |
| Open Props | None | Very Low | CSS file |
| Pico CSS | None | Very Low | CSS file |

*Note: The Tailwind Standalone CLI dramatically simplifies integration — no Node.js, no npm, no node_modules.*

---

## Recommendations

### For Digital Bazaar: Tailwind CSS (Standalone CLI)

**Why Tailwind is the best fit:**

1. **RTL is first-class** — Built-in `rtl:` variants and logical properties (`ms-`, `me-`, `ps-`, `pe-`) work perfectly for Arabic/English switching

2. **Design freedom** — Our Middle Eastern-inspired palette and magazine aesthetic won't clash with framework defaults (there are none)

3. **Cross-browser consistency** — Tailwind's reset (Preflight) normalizes browser differences; autoprefixer handles vendor prefixes

4. **Performance** — PurgeCSS ensures we only ship the CSS we use (3-10KB vs 25KB+ for Bootstrap)

5. **Future-proof** — Largest community momentum; regular updates; excellent documentation

6. **Simple integration** — The standalone CLI requires no Node.js, no npm, no package.json — just a single binary

**Implementation approach (Standalone CLI):**

```bash
# Download the binary (no npm required!)
curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
chmod +x tailwindcss-macos-arm64
mv tailwindcss-macos-arm64 bin/tailwindcss

# Initialize config
./bin/tailwindcss init

# Build CSS
./bin/tailwindcss -i src/input.css -o assets/css/tailwind.css --watch
```

This approach is as simple as downloading a file and running a command — comparable to Bootstrap/Bulma in setup complexity, but with all the power of Tailwind.

### Alternative: Open Props (Simpler Approach)

If the Node.js build step is a concern, **Open Props** offers:

- Zero build configuration
- Design tokens that complement our existing CSS
- Gradual adoption (add variables without rewriting)

However, you'd need to implement RTL manually with CSS logical properties.

### Not Recommended: Bootstrap

While Bootstrap has excellent RTL support and is easy to set up, its opinionated component styling would require significant overrides to achieve our magazine aesthetic. The "Bootstrap look" is hard to escape without substantial CSS work.

---

## Implementation Plan (Tailwind Standalone CLI)

### Phase 1: Setup (30 minutes)

1. **Download the Tailwind CLI binary:**

```bash
# Create bin directory
mkdir -p bin

# Download (macOS Apple Silicon)
curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-arm64
chmod +x tailwindcss-macos-arm64
mv tailwindcss-macos-arm64 bin/tailwindcss

# Add to .gitignore
echo "bin/tailwindcss" >> .gitignore
```

2. **Create `tailwind.config.js`:**

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './_includes/**/*.html',
    './_layouts/**/*.html',
    './ar/**/*.html',
    './en/**/*.html',
    './_posts/**/*.md',
  ],
  theme: {
    extend: {
      colors: {
        sand: '#F4E6C4',
        saffron: '#E2B714',
        terracotta: '#B34E36',
        marigold: '#D9912A',
        teal: '#2F8F9D',
        night: '#152029',
        ink: '#21313B',
      },
      fontFamily: {
        arabic: ['IBM Plex Sans Arabic', 'sans-serif'],
        english: ['DM Sans', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
```

3. **Create `src/input.css`:**

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Your existing custom styles can go here */
```

4. **Update Makefile:**

```makefile
css: ## Build Tailwind CSS
	./bin/tailwindcss -i src/input.css -o assets/css/tailwind.css --minify

css-watch: ## Watch and rebuild Tailwind CSS
	./bin/tailwindcss -i src/input.css -o assets/css/tailwind.css --watch

dev: css-watch serve ## Run CSS watcher and Jekyll server
```

### Phase 2: Migration (Gradual)

1. Keep existing `styles.css` — include both stylesheets initially
2. Add Tailwind utilities alongside existing classes
3. Migrate component-by-component using `@apply` for complex patterns
4. Remove redundant custom CSS as Tailwind replaces it

### Phase 3: RTL Enhancement

1. Replace physical properties (`margin-left`) with logical (`ms-`)
2. Add `rtl:` variants where direction-specific styling needed
3. Test both `/ar/` and `/en/` thoroughly

### Directory Structure After Setup

```
├── bin/
│   └── tailwindcss          # Standalone binary (gitignored)
├── src/
│   └── input.css            # Tailwind directives + custom CSS
├── assets/css/
│   ├── styles.css           # Existing styles (keep during migration)
│   └── tailwind.css         # Generated output
├── tailwind.config.js       # Color palette, fonts, content paths
└── Makefile                 # Updated with css commands
```

---

## Appendix: CSS Logical Properties Reference

For RTL/LTR support, use CSS logical properties regardless of framework choice:

| Physical Property | Logical Property | RTL Behavior |
|-------------------|------------------|--------------|
| `margin-left` | `margin-inline-start` | Becomes `margin-right` |
| `margin-right` | `margin-inline-end` | Becomes `margin-left` |
| `padding-left` | `padding-inline-start` | Becomes `padding-right` |
| `text-align: left` | `text-align: start` | Becomes `right` |
| `float: left` | `float: inline-start` | Becomes `right` |
| `left: 0` | `inset-inline-start: 0` | Becomes `right: 0` |

These work in all modern browsers and are the future-proof approach to bidirectional layouts.

---

## References

- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Tailwind RTL Support](https://tailwindcss.com/docs/hover-focus-and-other-states#rtl-support)
- [Bootstrap 5 RTL](https://getbootstrap.com/docs/5.3/getting-started/rtl/)
- [Bulma Framework](https://bulma.io/)
- [Open Props](https://open-props.style/)
- [Pico CSS](https://picocss.com/)
- [CSS Logical Properties MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_logical_properties_and_values)
- [Can I Use: CSS Logical Properties](https://caniuse.com/css-logical-props)

