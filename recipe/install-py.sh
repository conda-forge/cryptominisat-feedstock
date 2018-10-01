#!/bin/bash
set -eu -o pipefail

bash "${RECIPE_DIR}"/install.sh \
    -DENABLE_PYTHON_INTERFACE=ON \
    -DFORCE_PYTHON2="$( [[ $PY3K == 1 ]] && { echo OFF || : ; } || echo ON )" \
    -DONLY_SIMPLE=ON
