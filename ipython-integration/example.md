[TOC]


Here is an example of a markdown document getting information out of an ipython notebook.

{% for nb_name in [
    "Trapezoid Rule",
    "Part 1 - Running Code",
    "Part 2 - Basic Output"
] -%}

{% set nb = d[nb_name + '.ipynb|ipynb'].from_json() -%}

## {{ nb_name }}

The format of the notebook is {{ nb.nbformat }}
 
### List of Documents

{% for document_key in nb.documents -%}
- {{ document_key }}
{% endfor -%}

### Document Contents

{% for document_key in nb.documents %}
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
