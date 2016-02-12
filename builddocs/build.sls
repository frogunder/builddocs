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

checkout_repo_{{ codename }}:
  git.latest:
    - name: https://github.com/saltstack/salt.git
    - rev: {{ revision }}
    - target: {{ clonepath }}/salt/{{ outdir }}

build_docs_{{ codename }}:
  environ.setenv:
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd.run:
    - name: make html | ts '%F (%a) %T %Z:' > {{ clonepath }}/salt/{{ codename }}.log.txt 2>&1
    - cwd: {{ clonepath }}/salt/{{ outdir }}/doc

copy_log_file_{{ codename }}:
  file.copy:
    - name: {{ clonepath }}/salt/{{ outdir }}/doc/_build/html/log.txt
    - source: {{ clonepath }}/salt/{{ codename }}.log.txt
    - force: True

remove_sources_{{ codename }}:
  file.absent:
    - name: {{ clonepath }}/salt/{{ outdir }}/doc/_build/html/_sources

copy_404_{{ codename }}:
  file.managed:
    - name: {{ clonepath }}/salt/{{ outdir }}/doc/_build/html/404.html
    - source: salt://builddocs/files/404/{{ outdir }}/404.html

copy_htaccess_{{ codename }}:
  file.managed:
    - name: {{ clonepath }}/salt/{{ outdir }}/doc/_build/html/.htaccess
    - source: salt://builddocs/files/404/{{ outdir }}/.htaccess

