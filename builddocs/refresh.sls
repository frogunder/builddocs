checkout_previous_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2014.7
    - target: /var/salt/2014.7

checkout_latest_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2015.5
    - target: /var/salt/2015.5

checkout__develop_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: develop
    - target: /var/salt/develop
