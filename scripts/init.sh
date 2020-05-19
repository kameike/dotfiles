#!/bin/sh

set -eu

xcode-select --install || echo "ok"

git -C ~/ clone https://github.com/kameike/dotfiles
cd dotfiles

make brew
make install-basic-toolchain
make install-biz-toolchain
make sync-dotfiles


echo "done"
