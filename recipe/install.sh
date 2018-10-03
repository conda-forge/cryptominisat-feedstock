set -eu -o pipefail

mkdir -p build && pushd build

if [[ $(uname) == 'Darwin' ]] && [[ $PY3K == 1 ]]; then
    export LDFLAGS="${LDFLAGS} -undefined dynamic_lookup"
fi

if [[ ${target_platform} =~ win* ]]; then
    install_prefix="${LIBRARY_PREFIX}"
else
    install_prefix="${PREFIX}"
fi

# * ENABLE_TESTING: Testing requires lit which is not packaged yet:
#   https://github.com/conda-forge/staged-recipes/issues/4630
cmake \
    -G "${CMAKE_GENERATOR}" \
    -DCMAKE_INSTALL_PREFIX="${install_prefix}" \
    -DENABLE_TESTING=OFF \
    -DMIT=ON \
    "${@}" \
    ..

cmake --build . --target install --config RelWithDebInfo
popd && rm -r build
