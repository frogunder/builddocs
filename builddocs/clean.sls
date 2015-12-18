clean_docs_latest:
  cmd.run:
    - name: make clean
    - cwd: /var/salt/2015.8/doc
  file.absent:
    - name: /var/salt/latest.log.txt

clean_docs_previous:
  cmd.run:
    - name: make clean
    - cwd: /var/salt/2015.5/doc
  file.absent:
    - name: /var/salt/previous.log.txt

clean_docs_dev:
  cmd.run:
    - name: make clean
    - cwd: /var/salt/develop/doc
  file.absent:
    - name: /var/salt/develop.log.txt
