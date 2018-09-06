#!/bin/bash
set -eu -o pipefail

pushd build
make -j${CPU_COUNT} install
