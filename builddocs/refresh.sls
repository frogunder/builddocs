{% set clonepath = '/root' %}

checkout_previous_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2015.5
    - target: {{ clonepath }}/salt/2015.5

checkout_latest_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2015.8
    - target: {{ clonepath }}/salt/2015.8

checkout__develop_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: develop
    - target: {{ clonepath }}/salt/develop
