{% set revision = salt['pillar.get']('revision', '') %}
{% set checkout = salt['pillar.get']('checkout', 'true') %}
{% set clonepath = '/root' %}

{% if co == 'true' %}

checkout_repo_{{ revision }}:
  git.latest:
    - name: https://github.com/saltstack/salt.git
    - rev: {{ revision }}
    - target: {{ clonepath }}/salt/{{ revision }}
    - force_checkout: True

{% endif %}

build_docs_{{ revision }}:
  cmd.run:
    - name: make html | ts '%F (%a) %T %Z:' > {{ clonepath }}/salt/{{ revision }}.log.txt 2>&1
    - cwd: {{ clonepath }}/salt/{{ revision }}/doc

copy_log_file_{{ revision }}:
  file.copy:
    - name: {{ clonepath }}/salt/{{ revision }}/doc/_build/html/log.txt
    - source: {{ clonepath }}/salt/{{ revision }}.log.txt
    - force: True

remove_sources_{{ revision }}:
  file.absent:
    - name: {{ clonepath }}/salt/{{ revision }}/doc/_build/html/_sources

{% set pub = salt['pillar.get']('publish', 'true') %}

{% if pub == 'true' %}

sftp_docs_{{ revision }}:
  cmd.run:
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c --reverse --use-cache
           {{ clonepath }}/salt/{{ revision }}/doc/_build/html /en/releases/{{ revision }}"

{% endif %}

