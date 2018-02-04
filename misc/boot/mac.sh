#!/bin/sh

# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install neovim/neovim/neovim
brew install python3
pip3 install neovim
brew install screen

ln -f ~/.config/rcs/bashrc ~/.bashrc
ln -f ~/.config/rcs/bash_profile ~/.bash_profile
ln -f ~/.config/rcs/screenrc ~/.screenrc

