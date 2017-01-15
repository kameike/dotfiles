#!/bin/sh

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
dir=`pwd`
mkdir plugins
sh ./installer.sh plugins
rm installer.sh
