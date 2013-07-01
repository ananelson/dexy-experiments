[TOC]

Here is an example of a markdown document getting information out of an ipython notebook.

{% for nb in [
    "Trapezoid Rule",
    "Part 1 - Running Code",
    "Part 2 - Basic Output"
] -%}

## {{ nb }}

The format of the notebook is {{ d[nb + '.ipynb|ipynb'].nbformat }}

{% set cells = json.loads(d[nb + '.ipynb|ipynb'].cells) -%}
{% set documents = json.loads(d[nb + '.ipynb|ipynb'].documents) -%}

### List of Cells

{% for cell in cells -%}
- {{ cell }}
{% endfor -%}

 
### List of Documents

{% for document_key in documents -%}
- {{ document_key }}
{% endfor -%}

### Document Contents

{% for document_key in documents %}
{% set ext = document_key.split(".")[1] -%}

#### {{ document_key }}

{% if ext == "png" -%}
<img src="{{ document_key }}"></img>

{% elif ext in ("txt", "md") -%}

<pre>
{{ d[document_key] }}
</pre>

{% elif ext in ("py") -%}

{{ d[document_key + "|pyg|h"] }}

{% else %}
{{ ext }}
{% endif %}

{% endfor %}

{% endfor %}
