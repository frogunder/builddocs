always_run:
  cmd.run:
    name: echo 'this ran'

{% set pub = salt[pillar.get]('publish', True) %}

{% if pub %}

test_command
  cmd.run:
    name: 'ls -l'

{% endif %}