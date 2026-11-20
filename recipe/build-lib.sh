#!/bin/bash
set -euxo pipefail

# * NOCADICAL: CadiBack and the meelgroup fork of CaDiCaL it needs are not on
#   conda-forge yet, so backbone simplification is disabled. Without this the
#   build would git clone them via FetchContent.
cmake ${CMAKE_ARGS} -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DBUILD_SHARED_LIBS=ON \
  -DSTATIC_BINARY=OFF \
  -DNOCADICAL=ON \
  -DENABLE_TESTING=OFF \
  -DIPASIR=OFF \
  -B build -S .

cmake --build build --parallel ${CPU_COUNT}
cmake --install build

# The oracle sub-solver is an internal helper that libcryptominisat5 does not
# link against; its generic file names would clash with other packages.
rm -v "${PREFIX}/bin/oracle" "${PREFIX}"/lib/liboracle${SHLIB_EXT}* "${PREFIX}/include/oracle/oracle.h"
rmdir "${PREFIX}/include/oracle"
