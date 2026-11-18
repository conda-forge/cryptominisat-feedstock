#!/bin/bash
set -euxo pipefail

export CMAKE_GENERATOR=Ninja
export CMAKE_BUILD_PARALLEL_LEVEL=${CPU_COUNT}

${PYTHON} -m pip install . -vv --no-deps --no-build-isolation \
  -Ccmake.version=">=3.18" \
  -Ccmake.args="-DBUILD_PYTHON_EXTENSION=ON;-DNOCADICAL=ON" \
  -Cbuild.targets=pycryptosat \
  -Cbuild-dir=build
