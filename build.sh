#!/bin/sh

set -e

PKG_VERSION=$1


if [ ! -f kibana-${PKG_VERSION}.zip ]
then
  wget -O kibana-${PKG_VERSION}.zip https://github.com/rashidkpc/Kibana/archive/v${PKG_VERSION}.zip
fi

if [ ! -f kibana_${PKG_VERSION}_all.deb ]
then
  [ -d build ] && rm -rf build
  mkdir -p build/usr/share
  unzip kibana-${PKG_VERSION}.zip
  mv Kibana-${PKG_VERSION}/ build/usr/share/kibana

  fpm -s dir -t deb \
    --architecture all \
    -n kibana \
    -v ${PKG_VERSION} \
    --prefix / \
    --after-install post-install \
    -C build usr

  rm -rf Kibana-${PKG_VERSION}
  rm -rf build
fi

