#!/bin/sh


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

