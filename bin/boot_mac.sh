#!/bin/sh

CONFIG=$HOME/.config

if [ ! $(xcode-select -p 2>/dev/null) ]; then
  xcode-select --install
fi

if [ ! -d "$CONFIG" ]; then
  git clone https://github.com/kameike/env $CONFIG
fi

echo "start copy files"

rm ~/.bash_profile > /dev/null  2>&1
ln -s ~/.config/rcs/bash_profile ~/.bash_profile

rm ~/.bashrc > /dev/null  2>&1
ln -s ~/.config/rcs/bashrc ~/.bashrc

rm ~/.gitconfig > /dev/null  2>&1
ln -s ~/.config/rcs/gitconfig ~/.gitconfig

rm ~/.gitignore_global > /dev/null  2>&1
ln -s ~/.config/rcs/gitignore_global ~/.gitignore_global

rm ~/.tmux.conf > /dev/null  2>&1
ln -s ~/.config/rcs/tmux.conf ~/.tmux.conf

rm ~/.ssh/config> /dev/null  2>&1
ln -s ~/.config/ssh/config ~/.ssh/config



echo "install brew"
if type brew > /dev/null 2>&1; then
    echo "brew has already installed"
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "install brew files"
brew file install


echo "setup nvim"
sh ~/.config/nvim/boot.sh
