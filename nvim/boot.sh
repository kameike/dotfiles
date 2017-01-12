#!/bin/sh

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
dir=`pwd`
mkdir plugins
echo let g:config_plugins_path = \"${dir}/plugins\" > env.vim
sh ./installer.sh plugins
rm installer.sh
