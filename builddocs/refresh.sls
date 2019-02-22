{% set clonepath = '/root' %}

checkout_previous_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2018.3
    - target: {{ clonepath }}/salt/2018.3
    - force_checkout: True

checkout_latest_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2019.2
    - target: {{ clonepath }}/salt/latest
    - force_checkout: True

checkout__develop_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: develop
    - target: {{ clonepath }}/salt/develop
    - force_checkout: True

