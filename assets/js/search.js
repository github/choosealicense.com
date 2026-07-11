class SiteSearch {
  constructor(inputEl, resultsEl, catalog) {
    this.inputEl = inputEl;
    this.resultsEl = resultsEl;
    this.catalog = catalog;
    this.selectedIndex = -1;

    this.inputEl.addEventListener('input', () => this.render());
    this.inputEl.addEventListener('keydown', (event) => this.onKeyDown(event));
    this.inputEl.addEventListener('focus', () => this.render());
    document.addEventListener('click', (event) => {
      if (!event.target.closest('#site-search')) this.hideResults();
    });
  }

  normalize(text) {
    return (text || '').toLowerCase();
  }

  score(entry, query) {
    const q = this.normalize(query);
    if (!q) return -1;

    const title = this.normalize(entry.title);
    const spdx = this.normalize(entry.spdx_id);
    const description = this.normalize(entry.description);
    const tags = (entry.tags || []).join(' ');

    if (spdx === q || title === q) return 100;
    if (spdx.startsWith(q) || title.startsWith(q)) return 80;
    if (spdx.includes(q) || title.includes(q)) return 60;
    if (description.includes(q) || tags.includes(q)) return 40;
    return -1;
  }

  matches(query) {
    return this.catalog
      .map((entry) => ({ entry, score: this.score(entry, query) }))
      .filter(({ score }) => score >= 0)
      .sort((a, b) => b.score - a.score || a.entry.title.localeCompare(b.entry.title))
      .slice(0, 12)
      .map(({ entry }) => entry);
  }

  render() {
    const query = this.inputEl.value.trim();
    const results = this.matches(query);
    this.resultsEl.innerHTML = '';

    if (!query || results.length === 0) {
      this.hideResults();
      return;
    }

    results.forEach((entry, index) => {
      const li = document.createElement('li');
      const a = document.createElement('a');
      a.href = entry.url;
      a.textContent = entry.title;
      const meta = document.createElement('span');
      meta.className = 'site-search-meta';
      meta.textContent = entry.spdx_id;
      a.appendChild(meta);
      li.appendChild(a);
      if (index === this.selectedIndex) li.classList.add('is-active');
      this.resultsEl.appendChild(li);
    });

    this.resultsEl.hidden = false;
    this.inputEl.setAttribute('aria-expanded', 'true');
  }

  hideResults() {
    this.resultsEl.hidden = true;
    this.inputEl.setAttribute('aria-expanded', 'false');
    this.selectedIndex = -1;
  }

  onKeyDown(event) {
    const items = Array.from(this.resultsEl.querySelectorAll('li'));
    if (!items.length) return;

    if (event.key === 'ArrowDown') {
      event.preventDefault();
      this.selectedIndex = Math.min(this.selectedIndex + 1, items.length - 1);
      this.render();
      items[this.selectedIndex]?.querySelector('a')?.focus();
    } else if (event.key === 'ArrowUp') {
      event.preventDefault();
      this.selectedIndex = Math.max(this.selectedIndex - 1, 0);
      this.render();
      items[this.selectedIndex]?.querySelector('a')?.focus();
    } else if (event.key === 'Escape') {
      this.hideResults();
      this.inputEl.blur();
    } else if (event.key === 'Enter' && this.selectedIndex >= 0) {
      event.preventDefault();
      items[this.selectedIndex]?.querySelector('a')?.click();
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const inputEl = document.querySelector('#site-search-input');
  const resultsEl = document.querySelector('#site-search-results');
  const catalog = window.licenseCatalog || [];
  if (!inputEl || !resultsEl || !catalog.length) return;

  new SiteSearch(inputEl, resultsEl, catalog);

  document.addEventListener('keydown', (event) => {
    if (event.key === '/' && document.activeElement !== inputEl && !event.metaKey && !event.ctrlKey) {
      const tag = document.activeElement?.tagName?.toLowerCase();
      if (tag === 'input' || tag === 'textarea') return;
      event.preventDefault();
      inputEl.focus();
    }
  });
});
