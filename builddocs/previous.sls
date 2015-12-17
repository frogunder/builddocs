checkout_repo_previous:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2015.5
    - target: /var/salt/2015.5

build_docs_previous:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html | ts '%F %a %T %Z' > /var/salt/previous.log.txt 2>&1
    - cwd: /var/salt/2015.5/doc

copy_log_file_previous:
  file.copy:
    - name: /var/salt/2015.5/doc/_build/html/log.txt
    - source: /var/salt/previous.log.txt
    - force: True

remove_sources_previous:
  file:
    - absent
    - name: /var/salt/2015.5/doc/_build/html/_sources

copy_404_previous:
  file.copy:
    - name: /var/salt/2015.5/doc/_build/html/404.html
    - source: /var/salt/files/2015.5/404.html
    - force: True

copy_htaccess_previous:
  file.copy:
    - name: /var/salt/2015.5/doc/_build/html/.htaccess
    - source: /var/salt/files/2015.5/.htaccess
    - force: True

sftp_docs_previous:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c --reverse --delete --use-cache
           /var/salt/2015.5/doc/_build/html /en/2015.5"
