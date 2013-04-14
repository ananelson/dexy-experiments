[TOC]

## Here is the log for the dexy-templates repo:

<pre>
{{ d['dexy-templates.repo|gitlog'] }}
</pre>

## Here is a file from the repo:

<pre>
{{ d['setup.py'] }}
</pre>

{% set commit = d['dexy-templates.repo|gitcommit'] -%}
{% set patches = json.loads(commit['patches']) -%}

## Here is the last commit:

{{ commit.message }}

Limiting to 4 patches only

IMPORTANT these are diffs vs. nothing so they are just the full contents of the file - need to pass 2 revisions in to get a normal looking diff, haven't implemented that yet.

{% for i, patch in enumerate(patches) -%}
{% if i < 4 -%}
### {{ patch['new-file-path'] }}

{{ len(patch.hunks) }} hunks.

<pre>
{% for hunk in patch.hunks -%}
{{ "".join(hunk.lines) | e }}
{% endfor -%}
</pre>

{% endif -%}
{% endfor -%}

