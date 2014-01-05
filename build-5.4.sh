#!/bin/bash
set -x
set -e

apt-get install -y git

apt-get build-dep -y collectd

apt-get install --yes flex bison libperl-dev python-dev libdbi-dev libyajl-dev libxml2-dev libmysqlclient-dev iptables-dev git make build-essential automake libtool pkg-config libgcrypt11-dev curl libesmtp-dev liboping-dev libpcap0.8-dev libcurl4-gnutls-dev

cd /usr/src
git clone git://github.com/collectd/collectd.git
cd collectd
git checkout collectd-5.4.0

./clean.sh
./build.sh
./configure --enable-curl --enable-curl_json --enable-curl_xml --enable-dbi --enable-smtp --enable-ping
make
make install

