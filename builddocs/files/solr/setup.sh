#!/bin/bash

# install Oracle Java 8

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install -y oracle-java8-installer
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

# install SOLR
wget http://apache.cs.utah.edu/lucene/solr/5.3.1/solr-5.3.1.tgz
tar xzf solr-5.3.1.tgz
mv solr-5.3.1 /opt/solr
/opt/solr/bin/solr start

# install Nutch
wget http://apache.cs.utah.edu/nutch/1.11/apache-nutch-1.11-bin.tar.gz
tar xzf apache-nutch-1.11-bin.tar.gz
mv apache-nutch-1.11 nutch

