checkout_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: develop
    - target: /var/salt/develop

build_docs:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html
    - cwd: /var/salt/develop/doc

remove_sources:
  file:
    - absent
    - name: /var/salt/develop/doc/_build/html/_sources

remove_404:
  file:
    - absent
    - name: /var/salt/develop/doc/_build/html/404.html

sftp_docs:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c -R
           /var/salt/develop/doc/_build/html /en/latest"
