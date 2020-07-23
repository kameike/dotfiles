#!/bin/sh

set -eu


sudo pip3 install neovim
# taps
brew tap neovim/neovim

# install
install()
{
  if !(type $1 > /dev/null 2>&1); then
    brew install $1
  else
    echo $1 is already installed.
  fi
} 

cask_install()
{
  
  if !(type $1 > /dev/null 2>&1); then
    brew cask install $1
  else
    echo $1 is already installed.
  fi
}


#utils
install go
install git
install docker

#ios
# brew install carthage
# brew install cocoapods

# Other Homebrew packages
# brew ffmpeg
install tmux
install neovim
install openssl
install readline
install github/gh/gh

# Other Cask applications
cask_install docker
cask_install iterm2
cask_install clipy
cask_install google-chrome
cask_install slack
cask_install 1password
cask_install notion
cask_install macdown
# cask sketch
# cask adobe-creative-cloud
# cask charles
# cask sketch


go get -u github.com/nathany/looper
go get -u github.com/junegunn/fzf
nvim -c GoInstallBinaries -c q
