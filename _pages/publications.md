---
layout: page
permalink: /publications/
title: publications
description: Peer-reviewed papers and my PhD thesis, newest first.
nav: true
nav_order: 3
---
<!-- _pages/publications.md -->
<div class="publications">

{%- comment -%}
  Years are derived from the bibliography by _plugins/publication-years.rb.
  Set `years:` in the front matter to override.
{%- endcomment -%}
{%- assign years = page.years | default: site.data.bib_years -%}
{%- for y in years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f {{ site.scholar.bibliography }} -q @*[year={{y}}]* %}
{% endfor %}

</div>
