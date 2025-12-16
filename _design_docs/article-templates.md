# Article Templates Reference

Page structure and components for articles.

> **Last Updated:** December 2025

---

## Article Layout Structure

```
┌─────────────────────────────────────────────────────────────────┐
│                     HERO IMAGE (optional, bleed)                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ARTICLE TITLE                                                 │
│   Author · Date · Reading time · Language badge                 │
│   ─────────────────────────────────────────                     │
│                                                                 │
│   [D]rop cap opening paragraph...                               │
│                                                                 │
│   ┌─────────────┐  Body text with floated                       │
│   │  FLOAT IMG  │  images for visual interest...                │
│   └─────────────┘                                               │
│                                                                 │
│   ════════════════════════════════════════                      │
│   "Pull quote for emphasis"                                     │
│   ════════════════════════════════════════                      │
│                                                                 │
│   More content...                                               │
│                                                                 │
│   ─────────── ✦ ───────────  (divider)                          │
│                                                                 │
│   Next section...                                               │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                    WIDE IMAGE (extends beyond)                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Conclusion...                                                 │
│                                                                 │
│   ┌─────────────────────────────────────────┐                   │
│   │  RELATED ARTICLES                        │                   │
│   └─────────────────────────────────────────┘                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Article Header Component

```html
<header class="article-header">
  <div class="article-meta">
    <span class="author">{{ page.author }}</span>
    <span class="sep">·</span>
    <time datetime="{{ page.date | date_to_xmlschema }}">
      {{ page.date | date: "%B %d, %Y" }}
    </time>
    <span class="sep">·</span>
    <span class="reading-time">{{ content | number_of_words | divided_by: 200 }} min</span>
    <span class="sep">·</span>
    <span class="lang-badge lang-{{ page.lang }}">
      {% if page.lang == 'ar' %}عربي{% else %}English{% endif %}
    </span>
  </div>
  
  <h1>{{ page.title }}</h1>
  
  {% if page.excerpt %}
  <p class="article-excerpt">{{ page.excerpt }}</p>
  {% endif %}
</header>
```

### Header CSS

```css
.article-header {
  margin-bottom: 3rem;
}

.article-meta {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 0.5rem;
  font-size: var(--text-sm);
  color: var(--text-muted);
  margin-bottom: 1rem;
}

.article-meta .sep {
  opacity: 0.4;
}

.article-header h1 {
  font-size: var(--text-2xl);
  line-height: 1.15;
  color: var(--text-heading);
  margin: 0 0 1rem;
}

.article-excerpt {
  font-size: var(--text-lg);
  color: var(--text-muted);
  line-height: 1.6;
  margin: 0;
}
```

---

## Language Badge

```css
.lang-badge {
  display: inline-flex;
  align-items: center;
  padding: 0.25rem 0.6rem;
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  font-weight: 600;
}

.lang-badge.lang-ar {
  background: rgba(226, 183, 20, 0.15);
  color: #8B6914;
  border: 1px solid rgba(226, 183, 20, 0.3);
}

.lang-badge.lang-en {
  background: rgba(47, 143, 157, 0.15);
  color: var(--teal);
  border: 1px solid rgba(47, 143, 157, 0.3);
}
```

---

## Article Content Container

```css
.article-page article {
  font-size: var(--text-md);
  line-height: 1.7;
  color: var(--text);
}

.article-page article p {
  margin: 0 0 16px;
}

.article-page article h2 {
  font-size: var(--text-xl);
  color: var(--text-heading);
  margin: 26px 0 10px;
}

.article-page article h3 {
  font-size: var(--text-lg);
  color: var(--text-heading);
  margin: 22px 0 8px;
}

/* Lists */
.article-page article ul,
.article-page article ol {
  padding-inline-start: 1.5em;
  margin: 0 0 16px;
}

.article-page article li {
  margin-bottom: 8px;
}

/* Links */
.article-page article a {
  color: var(--teal);
  text-decoration: underline;
  text-underline-offset: 2px;
}

.article-page article a:hover {
  color: var(--terracotta);
}
```

---

## Related Articles Grid

```html
<section class="related-articles">
  <h2>{% if page.lang == 'ar' %}مقالات ذات صلة{% else %}Related Articles{% endif %}</h2>
  <div class="articles-grid">
    {% for post in site.posts limit:3 %}
      {% if post.url != page.url %}
        {% include article-card.html article=post %}
      {% endif %}
    {% endfor %}
  </div>
</section>
```

```css
.related-articles {
  margin-top: var(--space-2xl);
  padding-top: var(--space-xl);
  border-top: 1px solid var(--border);
}

.related-articles h2 {
  font-size: var(--text-xl);
  color: var(--text-heading);
  margin-bottom: var(--space-lg);
}

.articles-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: var(--space-lg);
}
```

---

## Article Card Component

```html
<!-- _includes/article-card.html -->
<article class="article-card">
  {% if include.article.image %}
  <img src="{{ include.article.image }}" alt="{{ include.article.title }}">
  {% endif %}
  
  <div class="card-content">
    <span class="lang-badge lang-{{ include.article.lang }}">
      {% if include.article.lang == 'ar' %}عربي{% else %}English{% endif %}
    </span>
    
    <h3>
      <a href="{{ include.article.url | relative_url }}">{{ include.article.title }}</a>
    </h3>
    
    <div class="card-meta">
      <span>{{ include.article.author }}</span>
      <span>{{ include.article.date | date: "%b %d" }}</span>
    </div>
  </div>
</article>
```

```css
.article-card {
  background: var(--surface);
  border-radius: var(--radius-lg);
  overflow: hidden;
  box-shadow: var(--card-shadow);
  border: 1px solid var(--border);
  transition: transform 0.15s ease, box-shadow 0.2s ease;
}

.article-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.article-card img {
  width: 100%;
  height: 140px;
  object-fit: cover;
}

.article-card .card-content {
  padding: 12px 14px 14px;
}

.article-card-kicker {
  font-size: var(--text-2xs);
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.15em;
  color: var(--kicker);
}

.article-card-title {
  font-size: var(--text-md);
  font-weight: 650;
  color: var(--text-heading);
  margin: 0;
}

.article-card-meta {
  font-size: var(--text-xs);
  color: var(--text-muted);
}

.article-card-excerpt {
  font-size: var(--text-sm);
  color: var(--text-muted);
  margin: 0;
}
```
