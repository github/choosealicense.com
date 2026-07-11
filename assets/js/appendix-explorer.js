class AppendixExplorer {
  constructor(root) {
    this.root = root;
    this.table = document.querySelector('.appendix-table');
    this.tbody = this.table?.querySelector('tbody');
    this.rows = Array.from(this.tbody?.querySelectorAll('tr') || []);
    this.checkboxes = Array.from(root.querySelectorAll('input[type="checkbox"]'));
    this.modeInputs = Array.from(root.querySelectorAll('input[name="appendix-filter-mode"]'));
    this.statusEl = document.querySelector('#appendix-filter-status');
    this.clearBtn = document.querySelector('#appendix-filter-clear');

    this.checkboxes.forEach((cb) => cb.addEventListener('change', () => this.apply()));
    this.modeInputs.forEach((input) => input.addEventListener('change', () => this.apply()));
    this.clearBtn?.addEventListener('click', () => {
      this.checkboxes.forEach((cb) => { cb.checked = false; });
      this.apply();
    });

    this.apply();
  }

  selectedRules() {
    return this.checkboxes.filter((cb) => cb.checked).map((cb) => cb.value);
  }

  mode() {
    return this.modeInputs.find((input) => input.checked)?.value || 'hide';
  }

  rowMatches(row, rules) {
    if (!rules.length) return true;
    const rowTags = (row.dataset.rules || '').split(',').filter(Boolean);
    return rules.every((rule) => rowTags.includes(rule));
  }

  apply() {
    const rules = this.selectedRules();
    const mode = this.mode();
    let matches = 0;

    this.rows.forEach((row) => {
      row.classList.remove('appendix-row-dimmed', 'appendix-row-match');
      row.hidden = false;
    });

    if (!rules.length) {
      if (this.statusEl) this.statusEl.textContent = `Showing all ${this.rows.length} licenses.`;
      return;
    }

    const matching = [];
    const nonMatching = [];

    this.rows.forEach((row) => {
      if (this.rowMatches(row, rules)) {
        matching.push(row);
        row.classList.add('appendix-row-match');
        matches += 1;
      } else {
        nonMatching.push(row);
      }
    });

    if (mode === 'hide') {
      nonMatching.forEach((row) => { row.hidden = true; });
    } else {
      [...matching, ...nonMatching].forEach((row) => this.tbody.appendChild(row));
      nonMatching.forEach((row) => row.classList.add('appendix-row-dimmed'));
    }

    if (this.statusEl) {
      this.statusEl.textContent = `${matches} license(s) match; ${nonMatching.length} do not (${mode === 'hide' ? 'hidden' : 'dimmed'}).`;
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('#appendix-filter');
  if (root) new AppendixExplorer(root);
});
