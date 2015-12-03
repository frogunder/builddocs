checkout_2014_7_repo:
  git:
    - latest
    - name: https://github.com/saltstack/salt.git
    - rev: 2014.7
    - target: /var/salt/2014.7

build_2014_7_docs:
  environ:
    - setenv
    - name: SALT_ON_SALTSTACK
    - value: "true"
  cmd:
    - run
    - name: make html > /var/salt/2014-7.log.txt 2>&1
    - cwd: /var/salt/2014.7/doc

copy_log_file_2014_7:
  file.copy:
    - name: /var/salt/2014.7/doc/_build/html/log.txt
    - source: /var/salt/2014-7.log.txt

remove_2014_7_sources:
  file:
    - absent
    - name: /var/salt/2014.7/doc/_build/html/_sources

remove_2014_7_404:
  file:
    - absent
    - name: /var/salt/2014.7/doc/_build/html/404.html

sftp_2014_7_docs:
  cmd:
    - run
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;mirror -c --reverse --delete --use-cache
           /var/salt/2014.7/doc/_build/html /en/2014.7"
