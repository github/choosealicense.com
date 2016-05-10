---
layout: default
permalink: /appendix/
title: Appendix
class: license-types
---

All licenses described in the choosealicense.com [repository](https://github.com/github/choosealicense.com), in a table.

<table border style="font-size: xx-small">
<tr><th>License</th>
{% assign types = "permissions|conditions|limitations" | split: "|" %}
{% for type in types %}
  {% assign rules = site.data.rules[type] | sort: "label" %}
  {% for rule_obj in rules %}
    <th style="text-align: center; width:7%">{{ rule_obj.label }}</th>
  {% endfor %}
{% endfor %}
</tr>
{% for license in site.licenses | sort: 'path' %}
  <tr style="height: 3em"><td><a href="{{ license.id }}">{{ license.title }}</a></td>
  {% for type in types %}
    {% assign rules = site.data.rules[type] | sort: "label" %}
    {% for rule_obj in rules %}
      <td class="license-{{ type }}" style="text-align:center">{% assign req = rule_obj.tag %}
      {% if license[type] contains req %}
          <span class="license-sprite {{ req }}"></span>
      {% endif %}</td>
    {% endfor %}
  {% endfor %}
  </tr>
{% endfor %}
</table>
