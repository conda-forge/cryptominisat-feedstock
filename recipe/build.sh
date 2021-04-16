#!/bin/bash
set -eu -o pipefail

cd "${SRC_DIR}"

mkdir -p build && cd build

if [[ $(uname) == 'Darwin' ]] && [[ $PY3K == 1 ]]; then
    export LDFLAGS="${LDFLAGS} -undefined dynamic_lookup"
fi

# Disable -isysroot magic that breaks the build:
# clang-11: warning: no such sysroot directory: '/Applications/Xcode_12.4.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk -march=core2 -mtune=haswell -mssse3 -ftree-vectorize -fPIC -fPIE -fstack-protector-strong -O2 -pipe -isystem /Users/runner/miniforge3/conda-bld/cryptominisat_1618595078418/_h_env_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_place/include -fdebug-prefix-map=/Users/runner/miniforge3/conda-bld/cryptominisat_1618595078418/work=/usr/local/src/conda/cryptominisat-5.8.0 -fdebug-prefix-map=/Users/runner/miniforge3/conda-bld/cryptominisat_1618595078418/_h_env_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_place=/usr/local/src/conda-prefix' [-Wmissing-sysroot]
export NIX_CC=yes

# * ENABLE_TESTING: Testing requires lit which is not packaged yet:
#   https://github.com/conda-forge/staged-recipes/issues/4630
cmake \
  "-DCMAKE_INSTALL_PREFIX=$PREFIX" \
  -DENABLE_PYTHON_INTERFACE=ON \
  -DFORCE_PYTHON2=`[[ $PY3K == 1 ]] && echo OFF || echo ON` \
  -DENABLE_TESTING=OFF \
  -DBoost_NO_BOOST_CMAKE=ON \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  ${SRC_DIR}

make -j${CPU_COUNT} install
