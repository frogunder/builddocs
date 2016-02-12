always_run:
  cmd.run:
    - name: echo 'this ran'

{% set pub = salt['pillar.get']('publish', 'true') %}

{% if pub == true  %}

conditional_run:
  cmd.run:
    - name: echo '{{ pub }}'

{% endif %}