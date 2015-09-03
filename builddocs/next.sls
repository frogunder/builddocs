checkout_repo_next:
  git:
    - latest
    - name: https://github.com/jacobhammons/salt
    - rev: 2015.8
    - target: /var/salt/2015.8

build_docs_next:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html > _build/html/log.txt 2>&1
    - cwd: /var/salt/2015.8/doc

remove_sources_next:
  file:
    - absent
    - name: /var/salt/2015.8/doc/_build/html/_sources

remove_404_next:
  file:
    - absent
    - name: /var/salt/2015.8/doc/_build/html/404.html

sftp_docs_next:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c -R
           /var/salt/2015.8/doc/_build/html /en/2015.8"
