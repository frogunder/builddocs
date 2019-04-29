# builddocs
Old Salt states that used to be used to build docs on saltstack.com.

Scripts to build them on drone and publish them to saltstack.com.
Also used for testing building of the docs on drone.

To test a build, only put ./build_html.sh, ./build_pdf.sh, or ./build_epub.sh in the drone commands
If you want to publish them as well, include ./publish_html.sh, ./publish_pdf.sh, or ./publish_epub.sh as well.
