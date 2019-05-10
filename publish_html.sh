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
lftp -c "open -u ${WEBSITE_USER},${WEBSITE_PASSWORD} -p 2222 sftp://saltstackdocs.wpengine.com;mirror -v -c --delete --reverse --use-cache /root/salt/doc/_build/html/ref /en/${WEBSITE_RELEASE}/ref"
lftp -c "open -u ${WEBSITE_USER},${WEBSITE_PASSWORD} -p 2222 sftp://saltstackdocs.wpengine.com;mirror -v -c --delete --reverse --use-cache /root/salt/doc/_build/html/topics /en/${WEBSITE_RELEASE}/topics"
lftp -c "open -u ${WEBSITE_USER},${WEBSITE_PASSWORD} -p 2222 sftp://saltstackdocs.wpengine.com;mirror -v -c --reverse --use-cache /root/salt/doc/_build/html /en/${WEBSITE_RELEASE}"
