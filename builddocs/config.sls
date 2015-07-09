python-pip:
  pkg.installed

install_sphinx:
  pip.installed:
    - name: sphinx >= 1.3
    - require:
      - pkg: python-pip

install_lftp:
  pkg.installed:
    - name: lftp
