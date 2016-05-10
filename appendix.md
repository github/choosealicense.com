---
layout: default
permalink: /appendix/
title: Appendix
class: license-types
---

All licenses described in the choosealicense.com [repository](https://github.com/github/choosealicense.com), in a table.

<table border style="font-size: xx-small">
{% assign types = "permissions|conditions|limitations" | split: "|" %}
<tr>
  <th>License</th>
  {% assign seen_tags = '' %}
  {% for type in types %}
    {% assign rules = site.data.rules[type] | sort: "label" %}
    {% for rule_obj in rules %}
      {% if seen_tags contains rule_obj.tag %}
        {% continue %}
      {% endif %}
      {% capture seen_tags %}{{ seen_tags | append:rule_obj.tag }}{% endcapture %}
      <th style="text-align: center; width:7%">{{ rule_obj.label }}</th>
    {% endfor %}
  {% endfor %}
</tr>
{% for license in site.licenses | sort: 'path' %}
  <tr style="height: 3em"><td><a href="{{ license.id }}">{{ license.title }}</a></td>
  {% assign seen_tags = '' %}
  {% for type in types %}
    {% assign rules = site.data.rules[type] | sort: "label" %}
    {% for rule_obj in rules %}
      {% assign req = rule_obj.tag %}
      {% if seen_tags contains req %}
        {% continue %}
      {% endif %}
      {% capture seen_tags %}{{ seen_tags | append:req }}{% endcapture %}
      {% assign seen_req = false %}
      {% for t in types %}
        {% if license[t] contains req %}
          <td class="license-{{ t }}" style="text-align:center">
            <span class="{{ req }}">
              <span class="license-sprite {{ req }}"></span>
            </span>
          </td>
          {% assign seen_req = true %}
        {% endif %}
      {% endfor %}
      {% unless seen_req %}
        <td></td>
      {% endunless %}
    {% endfor %}
  {% endfor %}
  </tr>
{% endfor %}
</table>
