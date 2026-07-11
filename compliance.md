---
layout: default
permalink: /compliance/
title: Practical license compliance
---

When you **use**, **modify**, or **distribute** open source software, the license may require specific actions. This page groups common **conditions** (the “rules” shown on license pages on this site) into practical checklists. It is **not legal advice**—use it as a starting point for engineering and release processes, and involve counsel for product decisions.

Pick a license on the [license list](/licenses/) to see which rules apply to that license. Rule names here match tags used in the site’s license annotations.

## Include copyright and license notice (`include-copyright`)

Many licenses require that recipients receive **copyright statements** and a **copy of the license** when you distribute the software (source or binaries).

**Checklist**

- [ ] Keep original copyright headers in source files you redistribute.
- [ ] Include the full license text in source distributions (for example, a `LICENSE` file in the repo or release tarball).
- [ ] For **binary** or app store releases, provide notices in an **About**, **Legal**, or **Third-party notices** screen or file, as required by the license.
- [ ] When vendoring, preserve notices per component; see [Attributions](/attributions/).

Some licenses (for example certain LGPL interpretations on binaries) distinguish **source** vs **binary** notice requirements—read the specific license if you only ship compiled artifacts.

## Disclose source (`disclose-source`)

**Copyleft** licenses such as [GPL](/licenses/gpl-3.0/) require that when you **distribute** the licensed program (often including combined works, depending on how code is linked), you make **corresponding source** available under compatible terms.

**Checklist**

- [ ] Identify whether your use is **distribution** (shipping to customers, publishing binaries, etc.) vs internal-only use.
- [ ] For distributed binaries, plan how you will offer source (same repository, written offer, or accompanying source package).
- [ ] Ensure build scripts and instructions needed to reproduce the binary are available where the license requires it.
- [ ] Track **modified** files so you can publish the exact corresponding source.

## Same license (`same-license`)

When this rule applies, **derivatives you distribute** must be licensed under the **same** (or compatible) license, so downstream users receive the same freedoms.

**Checklist**

- [ ] Do not relicense combined or modified work under proprietary terms when distributing, if the license requires same-license.
- [ ] Mark your files and repository with the correct license and SPDX identifier.
- [ ] When mixing code under different licenses, check **compatibility** before merging copyleft with other terms.
- [ ] Document license boundaries in monorepos; see [Multiple licenses](/multiple-licenses/).

Variants on this site (`same-license--file`, `same-license--library`) reflect licenses that apply the rule to **file-level** modifications or **library** linking differently—read the license text for your scenario.

## Network use and source disclosure (`network-use-disclose`)

Licenses such as [AGPL-3.0](/licenses/agpl-3.0/) extend obligations to users who **interact with modified software over a network**, not only to recipients of physical or downloaded copies.

**Checklist**

- [ ] Determine whether you run **modified** AGPL (or similar) code as a network service for others.
- [ ] If so, plan how remote users can **download corresponding source** (for example, a prominent offer in the UI or documentation).
- [ ] Separate **unmodified** upstream use from **derivative** services that trigger network-use conditions.
- [ ] Review [FAQ](/faq/) — network use and the AGPL for a high-level overview.

## Document changes (`document-changes`)

Some licenses require that you **state significant changes** made to the licensed files when you distribute them.

**Checklist**

- [ ] Maintain a **CHANGELOG** or commit history that identifies modifications to upstream files.
- [ ] In source distributions, add notices in modified files or accompanying documentation as the license requires.
- [ ] For bundled components, distinguish **your** changes from pristine upstream versions.

## Putting it together

1. **Inventory** dependencies and vendored code (names, versions, licenses, SPDX IDs).
2. **Map** each dependency to the rules on its license page on this site.
3. **Automate** where possible (SBOM tools, CI checks for missing `LICENSE` files, REUSE linting).
4. **Review** before each release—especially mobile, embedded, and SaaS deliverables.

## Related reading

{: .bullets}

* [Attributions](/attributions/) — third-party notices
* [Glossary](/glossary/) — copyleft, permissive, derivative work
* [The Legal Side of Open Source](https://opensource.guide/legal/) — Open Source Guide
