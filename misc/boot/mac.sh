!/bin/sh

#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install neovim/neovim/neovim
brew install python3
pip3 install neovim
brew install screen
brew cask install slack
brew cask install google-chrome
brew cask install iterm2

rm ~/.bash_profile
rm ~/.bashrc
rm ~/.gitconfig
rm ~/.gitignore_global
rm ~/.screenrc

ln -s ~/.config/rcs/bash_profile ~/.bash_profile
ln -s ~/.config/rcs/bashrc ~/.bashrc
ln -s ~/.config/rcs/gitconfig ~/.gitconfig
ln -s ~/.config/rcs/gitignore_global ~/.gitignore_global
ln -s ~/.config/rcs/screenrc ~/.screenrc

