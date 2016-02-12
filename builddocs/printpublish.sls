{% if pillar['version'] == 'previous' %}
    {% set codename = 'previous' %}
    {% set revision = '2015.5' %}
    {% set outdir = '2015.5' %}
{% endif %}

{% if pillar['version'] == 'latest' %}
    {% set codename = 'latest' %}
    {% set revision = '2015.8' %}
    {% set outdir = 'latest' %}
{% endif %}

{% if pillar['version'] == 'develop' %}
    {% set codename = 'develop' %}
    {% set revision = 'develop' %}
    {% set outdir = 'develop' %}
{% endif %}

{% set clonepath = '/root' %}

sftp_pdf_{{ codename }}:
  cmd.run:
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;cp {{ clonepath }}/salt/*.pdf /en/pdf/"

sftp_epub_{{ codename }}:
  cmd.run:
    - name: lftp -c "open -u {{pillar['ftpusername']}},{{pillar['ftppassword']}}
           -p 2222 sftp://saltstackdocs.wpengine.com;cp {{ clonepath }}/salt/*.epub /en/epub/"