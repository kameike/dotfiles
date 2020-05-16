#!/bin/sh

set -eu


sudo pip3 install neovim
# taps
brew tap neovim/neovim

# lang
brew install go

#utils
brew install git
brew install docker

#ios
# brew install carthage
# brew install cocoapods

# Other Homebrew packages
# brew ffmpeg
brew install tmux
brew install neovim
brew install openssl


# Other Cask applications
brew cask install docker
brew cask install iterm2
brew cask install clipy
# cask slack
# cask sketch
# cask google-chrome
# cask adobe-creative-cloud
# cask charles
# cask sketch


brew install readline
go get -u github.com/nathany/looper
go get github.com/junegunn/fzf
