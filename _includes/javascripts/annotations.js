var annotations = {
{% for type_hash in site.rules %}
  "{{ type_hash[0] }}": {
    {% for rule_hash in type_hash[1] %}
    "{{ rule_hash[0] }}" : "{{ rule_hash[1].description }}"{% if forloop.rindex0 > 0 %},{% endif %}
    {% endfor %}
  }{% if forloop.rindex0 > 0 %},{% endif %}
{% endfor %}
};
