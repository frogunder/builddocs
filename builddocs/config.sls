set_timezone:
  timezone.system:
    - name: America/Denver

minion_config:
  file.managed:
    - name: /etc/salt/minion.d/minion.conf
    - source: salt://builddocs/files/minion/minion.conf
    - makedirs: True

pillar_config:
  file.managed:
    - name: /srv/pillar/top.sls
    - source: salt://builddocs/files/pillar/top.sls
    - makedirs: True

build_script:
  file.managed:
    - name: /etc/cron.daily/builddocs
    - source: salt://builddocs/files/cron.daily/builddocs
    - mode: 700

install_fonts:
  file.recurse:
    - name: ~/.fonts
    - source: salt://builddocs/files/fonts 

install_dependencies:
  pkg.installed:
    - pkgs:
      - git
      - lftp
      - moreutils
      - texlive-xetex
      - python-pip

install_sphinx:
  pip.installed:
    - name: sphinx >= 1.3

install_pythongit:
  pip.installed:
    - name: gitpython

