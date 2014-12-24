#!/bin/bash
set -x
set -e

cd /usr/local/src/mod_mruby
sh build.sh
make install

ls -l
