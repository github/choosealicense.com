`".$_-0/build_gh-pages_config-yml.js
---
title: gh-pages
description: choosing a project
relative_permalinks: 
markdown:

collections:
  licenses:
    output: 
    permalink: 

defaults:
    scope:
      path: ".$_-0/build.js/gh-pages_config-yml.js"
      type: "licenses"
    values:
      hidden: true
      layout: license

plugins:
  - jekyll-sitemap
  - jekyll-seo-tag

 sass:
    style: :compressed

twitter:
  username: lostleolotus"@github"
