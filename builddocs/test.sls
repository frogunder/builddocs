always_run:
  cmd.run:
    - name: echo 'this ran'

{% set pub = salt['pillar.get']('publish', 'True') %}

{% if pub %}

conditional_run:
  cmd.run:
    - name: echo '{{ pub }}'

{% endif %}