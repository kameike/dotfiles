#!/bin/sh

set -eu

cd ~/.config/nvim/
mkdir plugins
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh plugins
rm installer.sh
