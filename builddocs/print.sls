{% if pillar['version'] == 'previous' %}
    {% set codename = 'previous' %}
    {% set revision = '2017.7' %}
    {% set release = '2017.7.7' %}
    {% set outdir = '2017.7' %}
{% endif %}

{% if pillar['version'] == 'latest' %}
    {% set codename = 'latest' %}
    {% set revision = '2018.3' %}
    {% set release = '2018.3.3' %}
    {% set outdir = 'latest' %}
{% endif %}

{% if pillar['version'] == 'develop' %}
    {% set codename = 'develop' %}
    {% set revision = 'develop' %}
    {% set release = 'develop' %}
    {% set outdir = 'develop' %}
{% endif %}

{% if pillar['version'] == 'next' %}
    {% set codename = 'next' %}
    {% set revision = 'develop' %}
    {% set release = 'develop' %}
    {% set outdir = 'next' %}
{% endif %}

{% set clonepath = '/root' %}
{% set publish = salt['pillar.get']('publish', False) %}
{% set build = salt['pillar.get']('build', True) %}
{% set staging = salt['pillar.get']('stage', 'false') %}

{% if build %}
remove_pdf_{{ codename }}:
  file.absent:
    - name: {{ clonepath }}/salt/{{ outdir }}/doc/_build/latex/Salt.pdf

remove_epub_{{ codename }}:
  file.absent:
    - name: {{ clonepath }}/salt/{{ outdir }}/doc/_build/epub/Salt.epub

build_pdf_{{ codename }}:
  cmd.run:
    - name: make pdf | ts '%F (%a) %T %Z:' > {{ clonepath }}/salt/{{ codename }}.pdf.log.txt 2>&1
    - cwd: {{ clonepath }}/salt/{{ outdir }}/doc

  file.copy:
    - name: {{ clonepath }}/salt/Salt-{{ release }}{% if staging == 'true' %}-stage{% endif %}.pdf
    - source: {{ clonepath }}/salt/{{ outdir }}/doc/_build/latex/Salt.pdf
    - force: True

build_epub_{{ codename }}:
  cmd.run:
    - name: make epub | ts '%F (%a) %T %Z:' > {{ clonepath }}/salt/{{ codename }}.epub.log.txt 2>&1
    - cwd: {{ clonepath }}/salt/{{ outdir }}/doc

  file.copy:
    - name: {{ clonepath }}/salt/Salt-{{ release }}{% if staging == 'true' %}-stage{% endif %}.epub
    - source: {{ clonepath }}/salt/{{ outdir }}/doc/_build/epub/Salt.epub
    - force: True
{% endif %}

{% if publish %}
sftp_pdf_{{ codename }}:
  cmd.run:
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;put -O /en/pdf/ {{ clonepath }}/salt/Salt-{{ release }}{% if staging == 'true' %}-stage{% endif %}.pdf"

sftp_epub_{{ codename }}:
  cmd.run:
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;put -O /en/epub/ {{ clonepath }}/salt/Salt-{{ release }}{% if staging == 'true' %}-stage{% endif %}.epub"
{% endif %}
