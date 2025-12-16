# Image Layout Reference

Magazine-quality image layouts for articles.

> **Last Updated:** December 2024

---

## Image Classes Overview

| Class | Effect | Use When |
|-------|--------|----------|
| `.img-inline` | Standard centered image | Default for most images |
| `.img-float-left` | Floats left, text wraps right | Accent images within paragraphs |
| `.img-float-right` | Floats right, text wraps left | Accent images within paragraphs |
| `.img-wide` | Extends 60px beyond column | Emphasis, section breaks |
| `.img-bleed` | Full viewport width | Hero images, major statements |
| `.img-overlay` | Caption overlays image | Photos with context |
| `.img-pair` | Two images side-by-side | Comparisons |

---

## CSS Implementations

### Standard Inline

```css
.img-inline {
  max-width: 100%;
  border-radius: var(--radius-lg);
  margin-block: 2rem;
}
```

### Float Left (Text Wraps Right)

```css
.img-float-left {
  float: inline-start;
  max-width: 45%;
  margin-inline-end: 2rem;
  margin-block: 0.5rem 1.5rem;
  border-radius: var(--radius-lg);
  shape-outside: margin-box;
}
```

### Float Right (Text Wraps Left)

```css
.img-float-right {
  float: inline-end;
  max-width: 45%;
  margin-inline-start: 2rem;
  margin-block: 0.5rem 1.5rem;
  border-radius: var(--radius-lg);
  shape-outside: margin-box;
}
```

### Wide (Extends Beyond Column)

```css
.img-wide {
  width: calc(100% + 120px);
  max-width: 100vw;
  margin-inline: -60px;
  margin-block: 2.5rem;
  border-radius: var(--radius-lg);
}
```

### Full Bleed (Viewport Width)

```css
.img-bleed {
  width: 100vw;
  max-width: none;
  margin-inline: calc(-50vw + 50%);
  margin-block: 3rem;
}
```

### Overlay Caption

```css
.img-overlay {
  position: relative;
  margin-block: 2rem;
}

.img-overlay img {
  width: 100%;
  border-radius: var(--radius-lg);
}

.img-overlay figcaption {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 3rem 2rem 1.5rem;
  background: linear-gradient(transparent, rgba(21,32,41,0.85));
  color: var(--white);
  border-radius: 0 0 var(--radius-lg) var(--radius-lg);
  font-size: var(--text-sm);
}
```

### Side-by-Side Pair

```css
.img-pair {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-md);
  margin-block: 2rem;
}

.img-pair img {
  border-radius: var(--radius-lg);
  width: 100%;
}

/* Asymmetric (2:1) */
.img-pair-asymmetric {
  grid-template-columns: 2fr 1fr;
}
```

---

## Markdown Usage

### Standard Image

```markdown
![Alt text](/assets/img/photo.jpg){: .img-inline }
```

### Float with Text Wrap

```markdown
![Alt text](/assets/img/photo.jpg){: .img-float-left }

Lorem ipsum dolor sit amet, text wraps around the image
naturally and elegantly...
```

### Full Bleed

```markdown
![Hero image](/assets/img/hero.jpg){: .img-bleed }
```

### Wide Image

```markdown
![Wide shot](/assets/img/landscape.jpg){: .img-wide }
```

### Overlay Caption (HTML)

```html
<figure class="img-overlay">
  <img src="/assets/img/photo.jpg" alt="Description">
  <figcaption>Caption appears over the image</figcaption>
</figure>
```

### Image Pair (HTML)

```html
<div class="img-pair">
  <img src="/assets/img/left.jpg" alt="Left image">
  <img src="/assets/img/right.jpg" alt="Right image">
</div>
```

---

## RTL Considerations

All classes use CSS logical properties, so they automatically flip in Arabic (RTL):
- `float: inline-start` → floats right in RTL
- `margin-inline-end` → margin on left in RTL

No additional RTL-specific styles needed.
