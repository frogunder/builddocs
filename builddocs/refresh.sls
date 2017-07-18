{% set clonepath = '/root' %}

checkout_previous_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2016.11
    - target: {{ clonepath }}/salt/2016.11
    - force_checkout: True

checkout_latest_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2016.11
    - target: {{ clonepath }}/salt/latest
    - force_checkout: True

checkout__develop_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: develop
    - target: {{ clonepath }}/salt/develop
    - force_checkout: True

