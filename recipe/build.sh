#!/bin/bash
set -eu -o pipefail

cd "${SRC_DIR}"

mkdir -p build && cd build

if [[ $(uname) == 'Darwin' ]] && [[ $PY3K == 1 ]]; then
    export LDFLAGS="${LDFLAGS} -undefined dynamic_lookup"
fi

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
