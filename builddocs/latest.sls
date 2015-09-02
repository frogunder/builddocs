checkout_repo_latest:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2015.5
    - target: /var/salt/2015.5

build_docs_latest:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html > _build/html/log.txt 2>&1 
    - cwd: /var/salt/2015.5/doc

remove_sources_latest:
  file:
    - absent
    - name: /var/salt/2015.5/doc/_build/html/_sources

remove_404_latest:
  file:
    - absent
    - name: /var/salt/2015.5/doc/_build/html/404.html

sftp_docs_latest:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c -R
           /var/salt/2015.5/doc/_build/html /en/latest"

sftp_docs_branch_latest:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c -R
           /var/salt/2015.5/doc/_build/html /en/2015.5"
