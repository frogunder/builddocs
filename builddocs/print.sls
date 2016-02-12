{% if pillar['version'] == 'previous' %}
    {% set codename = 'previous' %}
    {% set revision = '2015.5' %}
    {% set outdir = '2015.5' %}
{% endif %}

{% if pillar['version'] == 'latest' %}
    {% set codename = 'latest' %}
    {% set revision = '2015.8' %}
    {% set outdir = 'latest' %}
{% endif %}

{% if pillar['version'] == 'develop' %}
    {% set codename = 'develop' %}
    {% set revision = 'develop' %}
    {% set outdir = 'develop' %}
{% endif %}

{% set clonepath = '/root' %}

build_pdf_{{ codename }}:
  cmd.run:
    - name: make pdf | ts '%F (%a) %T %Z:' > {{ clonepath }}/salt/{{ codename }}.pdf.log.txt 2>&1
    - cwd: {{ clonepath }}/salt/{{ outdir }}/doc

  file.copy:
    - name: {{ clonepath }}/salt/Salt-{{ revision }}.pdf
    - source: {{ clonepath }}/salt/{{ outdir }}/doc/_build/latex/Salt.pdf
    - force: True

build_epub_{{ codename }}:
  cmd.run:
    - name: make epub | ts '%F (%a) %T %Z:' > {{ clonepath }}/salt/{{ codename }}.epub.log.txt 2>&1
    - cwd: {{ clonepath }}/salt/{{ outdir }}/doc

  file.copy:
    - name: {{ clonepath }}/salt/Salt-{{ revision }}.epub
    - source: {{ clonepath }}/salt/{{ outdir }}/doc/_build/epub/Salt.epub
    - force: True
