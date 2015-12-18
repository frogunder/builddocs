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

build_pdf_{{ codename }}:
  cmd.run:
    - name: make pdf | ts '%F (%a) %T %Z:' > /var/salt/{{ codename }}.pdf.log.txt 2>&1
    - cwd: /var/salt/{{ outdir }}/doc

  file.copy:
    - name: /var/salt/{{ outdir }}/Salt-{{ revision }}.pdf
    - source: /var/salt/{{ outdir }}/doc/_build/latex/Salt.pdf
    - force: True

build_epub_{{ codename }}:
  cmd.run:
    - name: make epub | ts '%F (%a) %T %Z:' > /var/salt/{{ codename }}.epub.log.txt 2>&1
    - cwd: /var/salt/{{ outdir }}/doc

  file.copy:
    - name: /var/salt/{{ outdir }}/Salt-{{ revision }}.epub
    - source: /var/salt/{{ outdir }}/doc/_build/epub/Salt.epub
    - force: True

