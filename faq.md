---
layout: default
permalink: /faq/
title: Frequently asked questions
---

Choosing and applying a license is straightforward for many projects, but real situations can be unclear. These answers summarize common questions in plain language. They are not legal advice; when in doubt, consult your organization’s counsel or a qualified attorney.

## Can I fork a project and keep my changes proprietary?

It depends on the **original project’s license** and what you do with the fork.

If the project uses a **permissive** license (for example [MIT](/licenses/mit/) or [Apache 2.0](/licenses/apache-2.0/)), you may often create a private fork and modify it without sharing your changes, as long as you comply with that license (typically **attribution** and preserving notices).

If the project uses a **copyleft** license (for example [GPLv3](/licenses/gpl-3.0/)), distributing a modified version usually requires you to offer corresponding source under the same license. Keeping changes entirely private on your own systems may be allowed in some cases, but **distributing** binaries or offering the software to others often triggers copyleft obligations.

If the project has **no license**, you do not have clear permission to use or fork it for proprietary products—see [contributing to unlicensed projects](#contributing-to-a-project-with-no-license) below.

## Can I offer support or services for open source software?

Generally **yes**. Open source licenses regulate **copying and distribution of the software**, not whether you may charge for installation, training, hosting, or support. Many businesses build services around open source stacks.

You must still **follow the license** for the code you distribute (include notices, honor copyleft if you distribute modified GPL code, etc.). Trademarks are separate: do not imply official affiliation unless allowed.

## Can I change the license on my own project?

If you are the **sole copyright holder**, you may generally relicense the project going forward (and optionally dual-license). Document the change clearly in the repository history and README.

If others have **contributed** under the existing license, their contributions remain licensed that way unless they agree to a **license change** or **copyright assignment**. In practice, relicensing often requires tracking contributors and obtaining permission, or rewriting affected parts. For large projects, this is a significant community process.

## Contributing to a project with no license

A repository without a license is **not open source** by default: default copyright rules apply, and others may not have permission to copy or distribute the code. See [No permission](/no-permission/).

If you still want to contribute, consider asking maintainers to add a license before you submit substantial work. If you contribute without a clear license from the project, clarify in writing what license applies to **your** contributions (many projects use a contributor license agreement or state that contributions are under the project license once one is added).

## Using open source code at work

Employees should follow **employer policy** on open source use, contribution, and approval workflows. Common concerns include:

* **License compliance** when shipping products (notices, source offers, copyleft triggers)
* **Patent** and **export** considerations for some stacks
* **Contribution** rules (who owns work done on company time)

Permissive licenses are often easier to embed in proprietary products; strong copyleft may require legal review before linking or distributing combined works. Your company may maintain an allowlist of licenses—check before you depend on a new library.

## What about network use and the AGPL?

The [GNU Affero GPL (AGPL)](/licenses/agpl-3.0/) is designed so that users who interact with a **modified** program over a network can receive source code. If you run AGPL software as a service and modify it, you may need to offer source to users who interact with it remotely—even if you do not “distribute” binaries in the traditional sense.

If you only use unmodified AGPL software internally without providing network access to outsiders, obligations differ from running a public SaaS on modified AGPL code. Read the specific license and your deployment model carefully; AGPL is often chosen precisely to require sharing changes for network-facing software.

## More help

{: .bullets}

* [Glossary](/glossary/) — definitions of common terms (when available on this site)
* [About](/about/) — what choosealicense.com covers
* [Community](/community/) — licenses common in your ecosystem
* [The Legal Side of Open Source](https://opensource.guide/legal/) — Open Source Guide
