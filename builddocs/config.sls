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
    - name: /usr/share/fonts/truetype
    - source: salt://builddocs/files/fonts 

install_dependencies:
  pkg.installed:
    - pkgs:
      - git
      - lftp
      - moreutils
      - texlive-latex-recommended
      - texlive-latex-extra
      - texlive-fonts-recommended
      - texlive-xetex
      - python-pip
      - fontconfig

refresh_font_cache:
  cmd.run:
    - name: fc-cache -f -v

install_sphinx:
  pip.installed:
    - name: sphinx==1.3.3

install_pythongit:
  pip.installed:
    - name: gitpython

