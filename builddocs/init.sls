{% if pillar['version'] == 'previous' %}
    {% set codename = 'previous' %}
    {% set revision = '2016.3' %}
    {% set outdir = '2016.3' %}
{% endif %}

{% if pillar['version'] == 'latest' %}
    {% set codename = 'latest' %}
    {% set revision = '2016.11' %}
    {% set outdir = 'latest' %}
{% endif %}

{% if pillar['version'] == 'develop' %}
    {% set codename = 'develop' %}
    {% set revision = 'develop' %}
    {% set outdir = 'develop' %}
{% endif %}

{% if pillar['version'] == 'next' %}
    {% set codename = 'next' %}
    {% set revision = 'develop' %}
    {% set outdir = 'develop' %}
{% endif %}

{% set pub = salt['pillar.get']('publish', False) %}
{% set prepub = salt['pillar.get']('prepublish', True) %}
{% set clonepath = '/root' %}

{% if prepub %}
checkout_repo_{{ codename }}:
  git.latest:
    - name: https://github.com/saltstack/salt.git
    - rev: {{ revision }}
    - target: {{ clonepath }}/salt/{{ outdir }}
    - force_checkout: True

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


{% elif pub %}

sftp_docs_{{ codename }}:
  cmd.run:
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c --reverse --use-cache
           {{ clonepath }}/salt/{{ outdir }}/doc/_build/html /en/{{ outdir }}"

{% endif %}
