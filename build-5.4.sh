#!/bin/bash
set -x
set -e

DEBIAN_FRONTEND=noninteractive apt-get install --yes --force-yes git

DEBIAN_FRONTEND=noninteractive apt-get build-dep --yes --force-yes collectd

DEBIAN_FRONTEND=noninteractive apt-get install --yes --force-yes build-essential autoconf libtool

cd /usr/src

if [ ! -d /usr/src/collectd ]; then
  git clone git://github.com/collectd/collectd.git
fi

cd collectd
git checkout collectd-5.4.0

./clean.sh
./build.sh
./configure --enable-curl --enable-curl_json --enable-curl_xml --enable-dbi --enable-smtp --enable-ping
make
make install
