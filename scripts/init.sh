#!/bin/sh

set -eu

git -C ~/ clone https://github.com/kameike/dotfiles
cd dotfiles

make brew
make instal-basic-toolchain
make sync-dotfiles


echo "done"
