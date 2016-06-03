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

build_daily_script:
  file.managed:
    - name: /etc/cron.daily/builddocs
    - source: salt://builddocs/files/scripts/builddocs
    - mode: 770

build_script:
  file.managed:
    - name: /root/build
    - source: salt://builddocs/files/scripts/build
    - mode: 770

release_script:
  file.managed:
    - name: /root/release
    - source: salt://builddocs/files/scripts/release
    - mode: 770

install_truetype_fonts:
  file.recurse:
    - name: /usr/share/fonts/truetype
    - source: salt://builddocs/files/fonts/truetype

install_opentype_fonts:
  file.recurse:
    - name: /usr/share/fonts/opentype
    - source: salt://builddocs/files/fonts/opentype

install_dependencies:
  pkg.installed:
    - pkgs:
      - git
      - vim
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

