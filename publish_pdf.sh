#!/bin/bash -ex

if [ -z "${WEBSITE_USER}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_USER"
	exit 1
fi

if [ -z "${WEBSITE_PASSWORD}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_PASSWORD"
	exit 1
fi

if [ -z "${WEBSITE_RELEASE}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_RELEASE"
	exit 1
fi

if [ -z "${WEBSITE_POINT_RELEASE}" ]
then
	echo "ERROR: Missing environment variable WEBSITE_POINT_RELEASE"
	exit 1
fi

./publish_env.sh
lftp -c "open -u ${WEBSITE_USER},${WEBSITE_PASSWORD} -p 2222 sftp://saltstackdocs.wpengine.com;mkdir -f -p /en/pdf;put -e -O /en/pdf /root/salt/doc/_build/latex/Salt.pdf -o Salt-${WEBSITE_POINT_RELEASE}.pdf"
