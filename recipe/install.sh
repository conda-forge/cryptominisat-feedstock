set -eu -o pipefail

mkdir build && pushd build

if [[ $(uname) == 'Darwin' ]] && [[ $PY3K == 1 ]]; then
    export LDFLAGS="${LDFLAGS} -undefined dynamic_lookup"
fi

extra_opts="${@} "
if [[ "${gpl_ok}" == 'True' ]]; then
    extra_opts="-DREQUIRE_M4RI=ON ${extra_opts}"
else
    extra_opts="-DMIT=ON ${extra_opts}"
fi

# * ENABLE_TESTING: Testing requires lit which is not packaged yet:
#   https://github.com/conda-forge/staged-recipes/issues/4630
cmake \
    -G "${CMAKE_GENERATOR}" \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DENABLE_TESTING=OFF \
    -DCMAKE_BUILD_TYPE=Release
    ${extra_opts} \
    ..

cmake --build . --target install --config Release -- -j${CPU_COUNT}
popd && rm -r build
