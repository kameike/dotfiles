#!/bin/sh

CONFIG=$HOME/.config


echo "install brew"
if type brew > /dev/null 2>&1; then
    echo "brew has already installed"
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install argon/mas/mas
brew install rcmdnk/file/brew-file

if [ ! -d "$CONFIG" ]; then
  git clone https://github.com/kameike/env.git $CONFIG
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


sudo chown -R $(whoami) /usr/local/lib/pkgconfig
chmod u+w /usr/local/lib/pkgconfig
echo "install brew files"
brew file install


echo "setup nvim"
sh ~/.config/nvim/boot.sh

pip3 install neovim --upgrade --user
pip3 install awscli --upgrade --user

git -C ~/.config/ remote remove origin
git -C ~/.config/ remote add origin git@github.com:kameike/env
