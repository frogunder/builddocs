checkout_repo_latest:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2015.8
    - target: /var/salt/2015.8

build_docs_latest:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html > /var/salt/latest.log.txt 2>&1
    - cwd: /var/salt/2015.8/doc

copy_log_file_latest:
  file.copy:
    - name: /var/salt/2015.8/doc/_build/html/log.txt
    - source: /var/salt/latest.log.txt

remove_sources_latest:
  file:
    - absent
    - name: /var/salt/2015.8/doc/_build/html/_sources

copy_404_latest:
  file.copy:
    - name: /var/salt/latest/doc/_build/html/404.html
    - source: /var/salt/files/latest/404.html
    - force: True

copy_htaccess_latest:
  file.copy:
    - name: /var/salt/latest/doc/_build/html/.htaccess
    - source: /var/salt/files/latest/.htaccess
    - force: True

sftp_docs_latest:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c --reverse --delete --use-cache
           /var/salt/2015.8/doc/_build/html /en/latest"
