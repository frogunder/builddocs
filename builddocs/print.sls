build_pdf_latest:
  cmd.run:
    - name: make pdf > /var/salt/2015.8.pdf.log.txt 2>&1
    - cwd: /var/salt/2015.8/doc

  file.copy:
    - name: /var/salt/2015.8/Salt-2015.8.pdf
    - source: /var/salt/2015.8/doc/_build/latex/Salt.pdf

build_pdf_previous:
  cmd.run:
    - name: make pdf > /var/salt/2015.5.pdf.log.txt 2>&1
    - cwd: /var/salt/2015.5/doc

  file.copy:
    - name: /var/salt/2015.5/Salt-2015.5.pdf
    - source: /var/salt/2015.5/doc/_build/latex/Salt.pdf

build_epub_latest:
  cmd.run:
    - name: make pdf > /var/salt/2015.8.epub.log.txt 2>&1
    - cwd: /var/salt/2015.8/doc

  file.copy:
    - name: /var/salt/2015.8/Salt-2015.8.epub
    - source: /var/salt/2015.8/doc/_build/epub/Salt.epub

build_epub_previous:
  cmd.run:
    - name: make epub > /var/salt/2015.5.epub.log.txt 2>&1
    - cwd: /var/salt/2015.5/doc

  file.copy:
    - name: /var/salt/2015.5/Salt-2015.5.epub
    - source: /var/salt/2015.5/doc/_build/epub/Salt.epub
