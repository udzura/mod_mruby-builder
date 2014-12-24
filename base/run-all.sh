#!/bin/bash
set -x
set -e

if [ "$1" = "check" ]; then
  check=true
fi

sh build.sh 1>&2
make install 1>&2

if [ -z "$check" ]; then
  cat /usr/local/src/mod_mruby/src/.libs/mod_mruby.so
else
  file /usr/local/src/mod_mruby/src/.libs/mod_mruby.so
  ls -l /usr/local/src/mod_mruby/src/.libs/mod_mruby.so
fi
