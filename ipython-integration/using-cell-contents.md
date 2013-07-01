{% set nb = d['Trapezoid Rule.ipynb|ipynb'].from_json() -%}

Here's a standalone call to highlight on the contents of a `code` cell:

<pre>
{{ d['using-cell-contents.md|htmlsections']['standalone-code'] }}
</pre>

Here is the result of running this:

<!-- section "standalone-code" -->
{% set cell_type, cell = nb.cells[3] -%}
{{ highlight(cell.input, cell.language) }}
<!-- section "end" -->

Here is a test of foo:

{{ foo("bar") }}
