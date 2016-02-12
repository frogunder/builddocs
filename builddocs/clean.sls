{% set clonepath = '/root' %}

clean_docs_latest:
  cmd.run:
    - name: make clean
    - cwd: {{ clonepath }}/salt/2015.8/doc
  file.absent:
    - name: {{ clonepath }}/salt/latest.log.txt

clean_docs_previous:
  cmd.run:
    - name: make clean
    - cwd: {{ clonepath }}/salt/2015.5/doc
  file.absent:
    - name: {{ clonepath }}/salt/previous.log.txt

clean_docs_dev:
  cmd.run:
    - name: make clean
    - cwd: {{ clonepath }}/salt/develop/doc
  file.absent:
    - name: {{ clonepath }}/salt/develop.log.txt
