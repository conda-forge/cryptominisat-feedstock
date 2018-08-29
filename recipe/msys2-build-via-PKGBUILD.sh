#!/usr/bin/env bash

export MINGW_PREFIX="/Library/mingw-w64"
export CARCH=${ARCH}
export MINGW_CHOST=$(gcc -dumpmachine)
export srcdir=${SRC_DIR}
export MAKEFLAGS=-j${CPU_COUNT}
echo PWD $PWD
cp ${RECIPE_DIR}/PKGBUILD .
echo PATH $PATH
. ./PKGBUILD
build
if [[ $? != 0 ]]; then
  exit 1
fi
export pkgdir="${PREFIX}"
export pkgver=5.6.4
package_icu
if [[ $? != 0 ]]; then
  exit 1
fi
rm -rf "${PREFIX}"/Library/dev
rm -rf "${PREFIX}"/Library/etc
