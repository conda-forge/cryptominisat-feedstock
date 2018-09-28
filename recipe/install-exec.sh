#!/bin/bash
set -eu -o pipefail

<<<<<<< HEAD
pushd build

if [[ $(uname) == 'Darwin' ]] && [[ $PY3K == 1 ]]; then
    export LDFLAGS="${LDFLAGS} -undefined dynamic_lookup"
fi

extra_opts=""
if [ "${gpl_ok}" == "True" ]; then
    extra_opts="-DMIT=ON "
fi

# * ENABLE_TESTING: Testing requires lit which is not packaged yet:
#   https://github.com/conda-forge/staged-recipes/issues/4630
cmake \
    -G "${CMAKE_GENERATOR}" \
    "-DCMAKE_INSTALL_PREFIX=$PREFIX" \
    -DENABLE_PYTHON_INTERFACE=OFF \
    -DENABLE_TESTING=OFF \
    -DONLY_SIMPLE=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ${extra_opts} \
    ..

cmake --build . --target install --config Release
=======
bash "${RECIPE_DIR}"/install.sh \
    -DENABLE_PYTHON_INTERFACE=OFF \
    -DONLY_SIMPLE=OFF
>>>>>>> 2f5f404722b2fde6472ec860ee65ee3399f69562
