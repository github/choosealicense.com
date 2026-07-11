---
title: Non-Software Licenses
layout: default
permalink: /non-software/
---

Open source software licenses can be also used for non-software works and are often the best choice, especially when the works in question can be edited and versioned as source. [Choose an open source license](/).

### Data, media, etc.

[CC0-1.0](/licenses/cc0-1.0/), [CC-BY-4.0](/licenses/cc-by-4.0/), and [CC-BY-SA-4.0](/licenses/cc-by-sa-4.0/) are [open](https://opendefinition.org) licenses used for non-software material ranging from datasets to videos. Note that Creative Commons does [not recommend its licenses be used for software](https://creativecommons.org/faq/#can-i-apply-a-creative-commons-license-to-software) or hardware.

### Documentation

Any open source software license or open license for media (see [above](#data-media-etc)) also applies to software documentation. If you use different licenses for your software and its documentation, be sure to specify that source code examples in the documentation are also licensed under the software license.

### Fonts

The [SIL Open Font License 1.1](/licenses/ofl-1.1/) keeps fonts open, allowing them to be freely used in other works.

### Hardware

Designs for [open source hardware](https://oshwa.org/resources/open-source-hardware-definition/) ranging from furniture to [FPGAs](https://oshwa.org/resources/best-practices-for-sharing-fpga-designs/) are covered by CERN Open Hardware licenses: [CERN-OHL-P-2.0](/licenses/cern-ohl-p-2.0/) (permissive), [CERN-OHL-W-2.0](/licenses/cern-ohl-w-2.0/) (weakly reciprocal), and [CERN-OHL-S-2.0](/licenses/cern-ohl-s-2.0/) (strongly reciprocal).


### Hardware description languages

Verilog, VHDL, SystemVerilog, and other HDL sources are often shared as open hardware or open-source designs. Common licenses in this space include the [TAPR Open Hardware License (OHL) version 1.0](https://www.tapr.org/ohl.html) and [Solderpad Hardware License version 2.1](https://solderpad.org/licenses/SPDX-2.1/). These licenses are not cataloged here as full license pages because they do not meet choosealicense.com’s [catalog criteria](https://github.com/github/choosealicense.com/blob/gh-pages/CONTRIBUTING.md#adding-a-license) (for example, TAPR-OHL-1.0 is listed by SPDX but is not on the OSI, FSF libre, or Open Definition approval lists used for software entries). When licensing HDL, read the official license text, check whether your community expects CERN-OHL or another hardware license from the [Hardware](#hardware) section above, and prefer a license already [approved for open source software](https://opensource.org/licenses/) if you want the same terms as the rest of your repository.


### Mixed projects

If your project contains a mix of different types of material, you can include multiple licenses, as long as you are explicit about which license applies to each part of the project. See [the license notice for this site](https://github.com/github/choosealicense.com#license) as an example.
