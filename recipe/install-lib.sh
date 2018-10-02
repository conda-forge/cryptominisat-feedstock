#!/bin/bash
set -eu -o pipefail

bash "${RECIPE_DIR}"/install.sh \
    -DENABLE_PYTHON_INTERFACE=OFF \
    -DONLY_SIMPLE=ON
