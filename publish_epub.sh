#!/bin/bash -ex

if [ -z "${WEBSITE_USER}" ]
then
	echo "Missing environment variable WEBSITE_USER"
	exit 1
fi

if [ -z "${WEBSITE_PASSWORD}" ]
then
	echo "Missing environment variable WEBSITE_PASSWORD"
	exit 1
fi

if [ -z "${WEBSITE_RELEASE}" ]
then
	echo "Missing environment variable WEBSITE_RELEASE"
	exit 1
fi

if [ -z "${WEBSITE_POINT_RELEASE}" ]
then
	echo "Missing environment variable WEBSITE_POINT_RELEASE"
	exit 1
fi

./publish_env.sh
lftp -c "open -u ${WEBSITE_USER},${WEBSITE_PASSWORD} -p 2222 sftp://saltstackdocs.wpengine.com;mkdir -f -p /en/epub;put -c -O /en/epub /root/salt/doc/_build/epub/Salt.epub -o Salt-${WEBSITE_POINT_RELEASE}.epub"
