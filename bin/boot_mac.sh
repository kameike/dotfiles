#!/bin/sh

if type brew > /dev/null 2>&1; then
    echo "brew has already installed"
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


brew file install

rm ~/.bash_profile > /dev/null  2>&1
rm ~/.bashrc > /dev/null  2>&1
rm ~/.gitconfig > /dev/null  2>&1
rm ~/.gitignore_global > /dev/null  2>&1
rm ~/.tmux.conf > /dev/null  2>&1

ln -s ~/.config/rcs/bash_profile ~/.bash_profile
ln -s ~/.config/rcs/bashrc ~/.bashrc
ln -s ~/.config/rcs/gitconfig ~/.gitconfig
ln -s ~/.config/rcs/gitignore_global ~/.gitignore_global
ln -s ~/.config/rcs/tmux.conf ~/.tmux.conf

