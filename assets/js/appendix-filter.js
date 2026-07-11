class AppendixFilter {
  constructor(root) {
    this.root = root;
    this.table = document.querySelector('.appendix-table');
    this.rows = Array.from(this.table?.querySelectorAll('tbody tr') || []);
    this.checkboxes = Array.from(root.querySelectorAll('input[type="checkbox"]'));
    this.statusEl = document.querySelector('#appendix-filter-status');
    this.clearBtn = document.querySelector('#appendix-filter-clear');

    this.checkboxes.forEach((cb) => cb.addEventListener('change', () => this.apply()));
    this.clearBtn?.addEventListener('click', () => {
      this.checkboxes.forEach((cb) => { cb.checked = false; });
      this.apply();
    });

    this.apply();
  }

  selectedRules() {
    return this.checkboxes.filter((cb) => cb.checked).map((cb) => cb.value);
  }

  rowMatches(row, rules) {
    if (!rules.length) return true;
    const rowTags = (row.dataset.rules || '').split(',').filter(Boolean);
    return rules.every((rule) => rowTags.includes(rule));
  }

  apply() {
    const rules = this.selectedRules();
    let visible = 0;

    this.rows.forEach((row) => {
      const match = this.rowMatches(row, rules);
      row.hidden = !match;
      if (match) visible += 1;
    });

    if (this.statusEl) {
      if (!rules.length) {
        this.statusEl.textContent = `Showing all ${this.rows.length} licenses.`;
      } else {
        this.statusEl.textContent = `Showing ${visible} of ${this.rows.length} licenses matching ${rules.length} selected rule(s).`;
      }
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('#appendix-filter');
  if (root) new AppendixFilter(root);
});
