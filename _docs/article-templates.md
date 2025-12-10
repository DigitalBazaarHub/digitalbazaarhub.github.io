# Article Templates Reference

Page structure and components for articles.

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
  font-size: 0.9rem;
  color: var(--muted);
  margin-bottom: 1rem;
}

.article-meta .sep {
  opacity: 0.4;
}

.article-header h1 {
  font-size: clamp(2rem, 5vw, 3rem);
  line-height: 1.15;
  color: var(--night);
  margin: 0 0 1rem;
}

.article-excerpt {
  font-size: 1.25rem;
  color: var(--subtitle);
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
  border-radius: 999px;
  font-size: 0.75rem;
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
.article-content {
  font-size: 1.1rem;
  line-height: 1.8;
  color: var(--ink);
}

.article-content p {
  margin-bottom: 1.5rem;
}

.article-content h2 {
  font-size: 1.75rem;
  color: var(--night);
  margin-top: 3rem;
  margin-bottom: 1rem;
}

.article-content h3 {
  font-size: 1.35rem;
  color: var(--night);
  margin-top: 2rem;
  margin-bottom: 0.75rem;
}

/* Lists */
.article-content ul,
.article-content ol {
  padding-inline-start: 1.5rem;
  margin-bottom: 1.5rem;
}

.article-content li {
  margin-bottom: 0.5rem;
}

/* Links */
.article-content a {
  color: var(--teal);
  text-decoration: underline;
  text-underline-offset: 3px;
}

.article-content a:hover {
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
  margin-top: 4rem;
  padding-top: 3rem;
  border-top: 1px solid rgba(21, 32, 41, 0.1);
}

.related-articles h2 {
  font-size: 1.5rem;
  color: var(--night);
  margin-bottom: 1.5rem;
}

.articles-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
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
  background: var(--white);
  border-radius: 16px;
  overflow: hidden;
  box-shadow: var(--shadow-sm);
  border: 1px solid rgba(21, 32, 41, 0.06);
  transition: transform 0.15s ease, box-shadow 0.2s ease;
}

.article-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.article-card img {
  width: 100%;
  aspect-ratio: 16/10;
  object-fit: cover;
}

.article-card .card-content {
  padding: 1.25rem;
}

.article-card h3 {
  font-size: 1.1rem;
  margin: 0.75rem 0 0.5rem;
  line-height: 1.4;
}

.article-card h3 a {
  color: var(--night);
  text-decoration: none;
}

.article-card h3 a:hover {
  color: var(--terracotta);
}

.article-card .card-meta {
  font-size: 0.85rem;
  color: var(--muted);
  display: flex;
  gap: 1rem;
}
```

