timezone:
  timezone.system:
    - name: America/Denver

minion config:
  file.managed:
    - name: /etc/salt/minion.d/minion.conf
    - source: salt://builddocs/files/minion/minion.conf
    - makedirs: True

nutch site config:
  file.managed:
    - name: /root/nutch/conf/nutch-site.xml
    - source: salt://builddocs/files/solr/nutch-site.xml

nutch regex url filter config:
  file.managed:
    - name: /root/nutch/conf/regex-urlfilter.xml
    - source: salt://builddocs/files/solr/regex-urlfilter.xml

seed list of urls to crawl:
  file.managed:
    - name: /root/nutch/urls/seed.txt 
    - source: salt://builddocs/files/solr/seed.txt

solr schema:
  file.managed:
    - name: /opt/solr/server/solr/nutch_solr_data_core/conf/schema.xml
    - source: salt://builddocs/files/solr/schema.xml

restart solr:
  cmd.shell:
    - name: /opt/solr/bin/solr restart

