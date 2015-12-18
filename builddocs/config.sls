set_timezone:
  timezone.system:
    - name: America/Denver

install_fonts:
  file.recurse:
    - name: ~/.fonts
    - source: salt://fonts 

install_configs:
  file.recurse:
    - name: ~/files
    - source: salt://files

install_dependencies:
  pkg.installed:
    - pkgs:
      - python-git
      - lftp
      - moreutils
      - texlive-xetex
      - python-pip

install_sphinx:
  pip.installed:
    - name: sphinx >= 1.3
    - require:
      - pkg: python-pip

