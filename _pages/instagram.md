---
layout: instagram
title: Instagram
permalink: /instagram
---
hello world

<div class="gallery2">
{% for sf in site.static_files %}
{% if sf.extname == ".jpg" %}
<a href="/{{ sf.basename }}"><img src="..{{ sf.path }}"></a>
{% endif %}
{% endfor %}
</div>