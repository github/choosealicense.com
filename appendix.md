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
      <th style="text-align: center; width:7%"><a href="#{{ rule_obj.tag }}">{{ rule_obj.label }}</a></th>
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

## Legend

<p>Open source licenses grant to the public <b>permissions</b> (<span class="license-permissions"><span class="license-sprite"></span></span>) to do things with licensed works copyright or other "intellectual property" laws might otherwise disallow.</p>

<p>Most open source licenses' grants of permissions are subject to compliance with <b>conditions</b> (<span class="license-conditions"><span class="license-sprite"></span></span>).</p>

<p>Most open source licenses also have <b>limitations</b> (<span class="license-limitations"><span class="license-sprite"></span></span>), including liability and warranties disclaimed by licensors and sometimes expressly excluding patent or trademark from licenses' grants.</p>

<dl>
{% assign seen_tags = '' %}
{% for type in types %}
  {% assign rules = site.data.rules[type] | sort: "label" %}
  {% for rule_obj in rules %}
    {% assign req = rule_obj.tag %}
    {% if seen_tags contains req %}
      {% continue %}
    {% endif %}
    <dt id="{{ req }}">{{ rule_obj.label }}</dt>
    {% capture seen_tags %}{{ seen_tags | append:req }}{% endcapture %}
    {% for t in types %}
      {% for r in site.data.rules[t] | sort: "label" %}
        {% if r.tag == req %}
          <dd class="license-{{t}}"><span class="license-sprite"></span> {{ r.description }}</dd>
        {% endif %}
      {% endfor %}
    {% endfor %}
  {% endfor %}
{% endfor %}
</dl>
