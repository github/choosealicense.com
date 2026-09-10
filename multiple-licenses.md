---
layout: default
permalink: /multiple-licenses/
title: Multiple licenses in one project
---

Real repositories often contain **more than one license**: application code under one terms, documentation under another, and vendored or submodule trees under their own files. Clarity helps contributors and users comply without guessing.

## LICENSE vs LICENSE-MIT vs docs/LICENSE

There is no single required filename. Convention on many platforms is a **`LICENSE`** or **`LICENSE.txt`** at the **repository root** for the **default** license applying to the project.

When projects use **multiple licenses** for different parts, common patterns include:

* **`LICENSE-MIT`**, **`LICENSE-Apache-2.0`**, or **`COPYING`** — named files when the root `LICENSE` would be ambiguous
* **`docs/LICENSE`** or **`documentation/LICENSE`** — license that applies only to documentation in that tree
* **`LICENSE` in a subdirectory** — license for code under that directory (see per-directory licensing below)

The README should state **which paths** each file covers. A root `LICENSE` alone does not automatically license every file unless you say so (or use tooling that marks files).

## SPDX license expressions in package metadata

Package manifests often have a **`license`** field. Use a [valid SPDX identifier](https://spdx.org/licenses/) for a single license (`MIT`, `Apache-2.0`, `GPL-3.0-only`).

When components use **different** licenses, SPDX supports **expressions**, for example:

* `MIT OR Apache-2.0` — recipient may choose either license where dual licensing is intended
* `LGPL-2.1-only WITH Classpath-exception-2.0` — common patterns for exceptions
* `(GPL-2.0-only OR GPL-3.0-only)` — upgrade paths described in license text

Use expressions only when they **accurately** reflect your licensing intent; incorrect metadata confuses users and tools. For complex repos, document the mapping in the README and use per-file markers where possible.

## REUSE.toml

[REUSE](https://reuse.software/) projects may include **`REUSE.toml`** at the repository root (or in subtrees) to declare **default licensing** for paths via globs— for example, “all files under `doc/` are CC-BY-4.0 unless overridden.” This reduces repetitive header comments while staying machine-readable.

REUSE still expects **`LICENSES/`** storage for license texts and per-file annotations where defaults do not apply.

## Per-directory licensing

Monorepos and mixed stacks often license **`packages/foo`** differently from **`packages/bar`**. Practices that work well:

1. Place a **`LICENSE`** (or `LICENSE.md`) in each package directory that needs distinct terms.
2. Set **package metadata** (`package.json`, `Cargo.toml`, `pyproject.toml`, etc.) per package.
3. Avoid copying code across license boundaries without checking **compatibility** (especially copyleft with permissive code).

Tools and CI can check that each directory’s declared license matches its files.

## README license section

A short **License** or **Licensing** section in the README helps humans more than a filename alone. Suggested content:

* Default license for the project (with SPDX ID and link to `LICENSE`)
* Exceptions (for example, “Documentation in `/docs` is CC-BY-4.0”)
* Pointers to **`NOTICE`** or **third-party** attributions if you bundle others’ code

Example:

```markdown
## License

Source code is licensed under the Apache License 2.0 (`LICENSE`).

Documentation in `docs/` is licensed under [CC BY 4.0](docs/LICENSE).

See [THIRD_PARTY_NOTICES](THIRD_PARTY_NOTICES) for bundled libraries.
```

## Related reading

{: .bullets}

* [Attributions](/attributions/) — third-party notices and NOTICE files
* [Appendix](/appendix/) — SPDX IDs for licenses on this site
* [FAQ](/faq/) — relicensing and workplace use
