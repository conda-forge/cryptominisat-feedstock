#!/bin/bash
set -eu -o pipefail

pushd build
cmake --build . --target install --config Release
