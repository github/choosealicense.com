---
layout: default
permalink: /attributions/
title: Attributions and third-party code
---

Most software projects **include code written by others**—libraries copied into a repo (**vendoring**), dependencies fetched at build time, or snippets adapted from documentation. Each component has its own **copyright** and **license**. This page describes practical steps to stay compliant. It is not legal advice.

## Preserve copyright notices

When you copy or redistribute source code, keep **copyright statements** and **license text** that came with the original work. Do not strip headers from vendored files unless the license explicitly allows it and you still satisfy attribution elsewhere (many licenses do not allow removal).

For dependencies installed via package managers, notices often live in the dependency’s repository; your **distribution** may still need to collect them for end users (especially mobile apps and shrink-wrapped products).

## Keep LICENSE files per component

Store a **LICENSE** (or **COPYING**) file **with each vendored component**, or in a clear directory layout:

```
third_party/
  libfoo/
    LICENSE
    ...
  libbar/
    LICENSE
    ...
```

If you ship a single archive, include all license texts somewhere recipients can find them—commonly `THIRD_PARTY_NOTICES` or a `licenses/` directory in your release artifact.

## Use a NOTICE file when appropriate

Licenses such as [Apache 2.0](/licenses/apache-2.0/) expect a **NOTICE** file for certain attribution and trademark notices. Even when not required, a **NOTICE** file helps you list bundled components and required text in one place.

A NOTICE file is not a substitute for including full license texts where required; it **supplements** them.

## SPDX and REUSE identifiers

**SPDX license identifiers** (for example `MIT`, `BSD-3-Clause`) make it clear which license applies to each file or package. Many ecosystems accept `"license": "MIT"` in package metadata—use [valid SPDX IDs](https://spdx.org/licenses/).

The [REUSE Specification](https://reuse.software/) defines how to mark **copyright and licensing** per file (`SPDX-FileCopyrightText`, `SPDX-License-Identifier` in comments, plus a `LICENSES/` directory). REUSE helps large repos and compliance automation stay consistent.

## Example NOTICE format

The following is a **illustrative** structure—not a template for every license:

```
MyApplication
Copyright 2026 Example Corp.

This product includes software developed by third parties:

---
Component: libexample
License: MIT
Copyright (c) 2019 Jane Developer

Permission is hereby granted, free of charge, ...
(full MIT license text)
---

---
Component: other-lib
License: Apache-2.0
(See third_party/other-lib/LICENSE)
---
```

Adjust content to match each license’s requirements. Some licenses require specific wording in **documentation** or **about** screens for binary distributions.

## Checklist

Before you release software that bundles third-party code:

1. **Inventory** components (direct and transitive where relevant).
2. **Record** SPDX IDs and URLs for each license.
3. **Include** full license texts and copyright notices in source and release artifacts.
4. **Add** a NOTICE or third-party notices file if your stack or policies expect one.
5. **Document** how users can obtain source for copyleft-licensed components when you distribute binaries.

## Related reading

{: .bullets}

* [Glossary](/glossary/) — attribution, copyright, and SPDX
* [Compliance](/compliance/) — obligations by license rule type (when available on this site)
* [Multiple licenses](/multiple-licenses/) — projects with more than one license file
