checkout_repo_previous:
  git:
    - latest
    - name: https://github.com/jacobhammons/salt.git
    - rev: release-docs-2015.5
    - target: /var/salt/2015.5

build_docs_previous:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html > _build/html/log.txt 2>&1 
    - cwd: /var/salt/2015.5/doc

remove_sources_previous:
  file:
    - absent
    - name: /var/salt/2015.5/doc/_build/html/_sources

remove_404_previous:
  file:
    - absent
    - name: /var/salt/2015.5/doc/_build/html/404.html

sftp_docs_previous:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c -R
           /var/salt/2015.5/doc/_build/html /en/2015.5"
