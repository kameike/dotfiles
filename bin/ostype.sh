#!/bin/sh
#vim: syntax=sh

set -eu

if [ "$(uname)" == 'Darwin' ]; then
  echo 'Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  echo 'Linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi


