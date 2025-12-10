# Design System Reference

Detailed CSS implementations for the Digital Bazaar theme.

---

## Typography

### System Fonts

```css
/* Base (English) */
font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;

/* Arabic enhancement */
html[lang="ar"] {
  font-family: 'Tajawal', 'Cairo', ui-sans-serif, system-ui, sans-serif;
  line-height: 1.8;
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

## Code Blocks

### Styled Code Block

```css
pre {
  background: var(--night);
  color: #E5E7EB;
  padding: 1.5rem 2rem;
  border-radius: 16px;
  overflow-x: auto;
  font-family: 'JetBrains Mono', 'Fira Code', 'SF Mono', monospace;
  font-size: 0.9rem;
  line-height: 1.7;
  margin-block: 2rem;
  box-shadow: 
    0 4px 20px rgba(21, 32, 41, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
}

/* Language header */
pre[data-lang]::before {
  content: attr(data-lang);
  display: block;
  margin: -1.5rem -2rem 1rem;
  padding: 0.5rem 2rem;
  background: rgba(255, 255, 255, 0.05);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: var(--saffron);
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
.highlight .k  { color: var(--terracotta); }   /* Keywords */
.highlight .s  { color: var(--saffron); }      /* Strings */
.highlight .c  { color: #6B7280; }             /* Comments */
.highlight .n  { color: #E5E7EB; }             /* Names */
.highlight .f  { color: var(--teal); }         /* Functions */
.highlight .m  { color: var(--marigold); }     /* Numbers */
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

## Spacing & Layout Tokens

```css
:root {
  /* Border radius */
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 16px;
  --radius-xl: 20px;

  /* Shadows */
  --shadow-sm: 0 2px 8px rgba(0,0,0,0.06);
  --shadow-md: 0 6px 16px rgba(0,0,0,0.08);
  --shadow-lg: 0 8px 24px rgba(0,0,0,0.12);

  /* Container */
  --container-width: 940px;
  --container-padding: 32px 20px 64px;
}
```

---

## Gradients

```css
/* Background */
background: linear-gradient(180deg, #FFFDF6 0%, var(--sand) 100%);

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
  padding: 12px 16px;
  font-weight: 700;
  border-radius: 12px;
  display: inline-flex;
  align-items: center;
  gap: 10px;
  box-shadow: 0 6px 16px rgba(0,0,0,0.08);
  transition: transform .06s ease, box-shadow .2s ease;
  text-decoration: none;
  border: none;
  cursor: pointer;
}

.btn:hover {
  transform: translateY(-1px);
  box-shadow: 0 10px 22px rgba(0,0,0,0.12);
}

.btn-primary {
  background: linear-gradient(135deg, var(--terracotta), var(--marigold));
  color: var(--white);
}

.btn-secondary {
  background: linear-gradient(135deg, rgba(47,143,157,0.12), rgba(47,143,157,0.24));
  color: var(--ink);
  border: 1px solid rgba(47,143,157,0.45);
}
```

