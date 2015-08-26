checkout_dev_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: develop
    - target: /var/salt/develop

build_dev_docs:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html > _build/html/log.txt 2>&1
    - cwd: /var/salt/develop/doc

remove_dev_sources:
  file:
    - absent
    - name: /var/salt/develop/doc/_build/html/_sources

remove_dev_404:
  file:
    - absent
    - name: /var/salt/develop/doc/_build/html/404.html

sftp__dev_docs:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c -R
           /var/salt/develop/doc/_build/html /en/develop"
