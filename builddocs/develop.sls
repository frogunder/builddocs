checkout_repo_dev:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: develop
    - target: /var/salt/develop

build_docs_dev:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html > /var/salt/develop.log.txt 2>&1
    - cwd: /var/salt/develop/doc

copy_log_file_dev:
  file.copy:
    - name: /var/salt/develop/doc/_build/html/log.txt
    - source: /var/salt/develop.log.txt

remove_sources_dev:
  file:
    - absent
    - name: /var/salt/develop/doc/_build/html/_sources

copy_404_dev:
  file.copy:
    - name: /var/salt/develop/doc/_build/html/404.html
    - source: file:///var/salt/files/develop/404.html

copy_htaccess_dev:
  file.copy:
    - name: /var/salt/develop/doc/_build/html/.htaccess
    - source: file:///var/salt/files/develop/.htaccess

sftp__docs_dev:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c --reverse --delete --use-cache
           /var/salt/develop/doc/_build/html /en/develop"
