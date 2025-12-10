(function() {
  'use strict';

  // State
  const state = {
    lang: 'all',
    category: 'all',
    author: 'all',
    time: 'all',
    sort: 'newest'
  };

  // Elements
  const grid = document.getElementById('articlesGrid');
  const empty = document.getElementById('articlesEmpty');
  const clearBtn = document.getElementById('clearFilters');
  const resultsDiv = document.getElementById('filtersResults');
  const resultsCount = document.getElementById('resultsCount');

  if (!grid) return;

  const cards = Array.from(grid.querySelectorAll('.article-card'));

  // Bind filter dropdowns
  document.querySelectorAll('.filter-select').forEach(select => {
    const filterType = select.dataset.filter;
    select.addEventListener('change', () => {
      state[filterType] = select.value;
      applyFilters();
    });
  });

  // Clear filters
  if (clearBtn) {
    clearBtn.addEventListener('click', () => {
      Object.keys(state).forEach(key => {
        state[key] = key === 'sort' ? 'newest' : 'all';
      });
      document.querySelectorAll('.filter-select').forEach(select => {
        const filterType = select.dataset.filter;
        select.value = state[filterType];
      });
      applyFilters();
    });
  }

  function applyFilters() {
    const now = new Date();
    const oneWeekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
    const oneMonthAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
    const startOfYear = new Date(now.getFullYear(), 0, 1);

    let visibleCards = [];

    cards.forEach(card => {
      const cardLang = card.dataset.lang;
      const cardCategory = card.dataset.category;
      const cardAuthor = card.dataset.author;
      const cardDate = new Date(card.dataset.date);

      let visible = true;

      // Language filter
      if (state.lang !== 'all' && cardLang !== state.lang) {
        visible = false;
      }

      // Category filter
      if (state.category !== 'all' && cardCategory !== state.category) {
        visible = false;
      }

      // Author filter
      if (state.author !== 'all' && cardAuthor !== state.author) {
        visible = false;
      }

      // Time filter
      if (state.time !== 'all') {
        if (state.time === 'week' && cardDate < oneWeekAgo) visible = false;
        if (state.time === 'month' && cardDate < oneMonthAgo) visible = false;
        if (state.time === 'year' && cardDate < startOfYear) visible = false;
      }

      card.style.display = visible ? '' : 'none';
      if (visible) visibleCards.push(card);
    });

    // Sort visible cards
    visibleCards.sort((a, b) => {
      const dateA = new Date(a.dataset.date);
      const dateB = new Date(b.dataset.date);
      return state.sort === 'newest' ? dateB - dateA : dateA - dateB;
    });

    // Reorder in DOM
    visibleCards.forEach(card => grid.appendChild(card));

    // Show/hide empty state
    const hasResults = visibleCards.length > 0;
    empty.style.display = hasResults ? 'none' : 'block';
    grid.style.display = hasResults ? '' : 'none';

    // Update results count
    if (resultsDiv && resultsCount) {
      const hasActiveFilters = Object.entries(state).some(([key, val]) => {
        if (key === 'sort') return false;
        return val !== 'all';
      });
      
      resultsDiv.style.display = hasActiveFilters ? 'block' : 'none';
      resultsCount.textContent = visibleCards.length;
      
      if (clearBtn) {
        clearBtn.style.display = hasActiveFilters ? 'inline-flex' : 'none';
      }
    }
  }

  // Initial filter
  applyFilters();
})();
