[TOC]

{% macro display_cell(tup) -%}
{% set cell_type, cell = tup -%}

{% if (cell_type == 'code') -%}

{{ highlight(cell.input, cell.language) }}

{% for output in cell.outputs -%}

{% if sorted(output) == ['prompt_number', 'text'] -%}
<pre>
OUT[{{ output['prompt_number'] }}]: {{ output['text'] }}
</pre>

{% elif sorted(output) == ['stream', 'text'] -%}
<pre>
{{ output.text }}
</pre>

{% elif sorted(output) == ['ename', 'evalue', 'traceback'] -%}
<pre>
{# TODO use ansi2html.py to convert traceback #}
{% for line in output.traceback -%}
{{ line }}
{% endfor -%}
</pre>

{% elif 'png' in output -%}
<img src="{{ output.png }}"></img>

{% else -%}
HAVEN'T IMPLEMENTED THIS CASE YET! KEYS: {{ sorted(output.keys()) }}

{% endif -%}

{% endfor -%}

{% elif (cell_type == 'heading') -%}
{{ '#' * (cell.level+1) }} {{ cell.source }}

{% elif (cell_type == 'markdown') -%}
{{ cell.source }}

{% else -%}
{{ raise(cell_type) }}

{% endif -%}
{% endmacro -%}

{% for nb_name in [
    "Trapezoid Rule",
    "Part 1 - Running Code",
    "Part 2 - Basic Output"
] -%}

{% set nb = d[nb_name + '.ipynb|ipynb'].from_json() -%}

{% for i, cell in enumerate(nb.cells) %}
{{ display_cell(cell) }}
{% endfor %}

{% endfor -%}
