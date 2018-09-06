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
    -DENABLE_PYTHON_INTERFACE=ON \
    -DFORCE_PYTHON2=`[[ $PY3K == 1 ]] && echo OFF || echo ON` \
    -DENABLE_TESTING=OFF \
    -DONLY_SIMPLE=ON \
    -DCMAKE_BUILD_TYPE=Release \
    ${extra_opts} \
    ..

cmake --build . --target install --config Release
