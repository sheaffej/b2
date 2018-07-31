#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# export PYTHONPATH=${PYTHONPATH}:${DIR}/../src

# Unit-level tests
echo
echo "============================"
echo "     Running Unit Tests     "
echo "============================"
echo
pushd $DIR >/dev/null
/usr/bin/env pytest -v --cov=b2_logic unit/
popd > /dev/null
