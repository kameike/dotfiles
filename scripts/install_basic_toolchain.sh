#!/bin/sh

set -eu

tap() {
  brew tap $1
}

pipinstall() {
  echo ok
}

brewlist=`brew list --full-name`
# install
install()
{
  if !(echo $brewlist | grep -q $1); then
    brew install $1
  else
    echo $1 is already installed.
  fi
} 

casklist=`brew cask list --full-name`
cask_install()
{
  
  if !(echo $casklist | grep -q $1); then
    brew cask install $1
  else
    echo $1 is already installed.
  fi
}

tap neovim/neovim

sudo pip3 install --upgrade pip
sudo pip3 install neovim

#utils
install go
install git
install docker
install tmux
install neovim
install openssl
install readline
install github/gh/gh
install terraform

cask_install docker
cask_install iterm2
cask_install clipy
cask_install google-chrome
cask_install slack
cask_install 1password
cask_install notion
cask_install macdown
cask_install microsoft-word
cask_install microsoft-powerpoint
cask_install microsoft-excel

go get github.com/nathany/looper
go get github.com/junegunn/fzf
nvim -c GoInstallBinaries -c q
