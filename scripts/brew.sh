#!/bin/sh

set -eu

if type brew > /dev/null 2>&1; then
    echo "brew has already installed"
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# brew file install
# 
# rm ~/.bash_profile
# rm ~/.bashrc
# rm ~/.gitconfig
# rm ~/.gitignore_global
# rm ~/.screenrc
# rm ~/.tmux.conf
# 
# ln -s ~/.config/rcs/bash_profile ~/.bash_profile
# ln -s ~/.config/rcs/bashrc ~/.bashrc
# ln -s ~/.config/rcs/gitconfig ~/.gitconfig
# ln -s ~/.config/rcs/gitignore_global ~/.gitignore_global
# ln -s ~/.config/rcs/tmux.conf ~/.tmux.conf
# 
