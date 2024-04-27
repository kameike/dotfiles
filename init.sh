#!/bin/sh

set -eu

brewcmd='/opt/homebrew/bin/brew'
gocmd='/opt/homebrew/bin/go'

# setup brew
setup_brew()
{

  if type brew > /dev/null 2>&1; then
    installed_prompt brew
    $brewcmd update
  else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

brew_tap() {
  $brewcmd tap $1
}

pip_install() {
  echo ok
}


brewlist=`$brewcmd list --full-name`
# install
brew_install()
{
  if !(echo $brewlist | grep -q $1); then
    $brewcmd install $1
  else
    installed_prompt $1
  fi
} 

casklist=`$brewcmd list --cask --full-name`
cask_install()
{
  
  if !(echo $casklist | grep -q $1); then
    $brewcmd install --cask $1
  else
    installed_prompt $1
  fi
}

cask_install()
{
  
  if !(echo $casklist | grep -q $1); then
    $brewcmd install --cask $1
  else
    installed_prompt $1
  fi
}

go_install()
{
  if !(type go > /dev/null 2>&1); then
    echo "Need go env to run this script"
  fi

  if !(type $1 > /dev/null 2>&1); then
    echo "install dotfiles"
    go install $2@latest
  else
    installed_prompt $1
  fi
}

go_exec()
{
  gopath=$($gocmd env | grep ^GOPATH | sed "s/GOPATH='\(.*\)'/\1/g")
  cmd=$gopath/bin/$1
  shift
  $cmd $@
}


installed_prompt()
{
  echo ✅ $1 is ready
}


### main
setup_brew

brew_tap neovim/neovim
pip3 install --upgrade pip
# pip3 install neovim

#utils
brew_install go
brew_install git
brew_install docker
brew_install tmux
brew_install neovim
brew_install openssl
brew_install readline
brew_install terraform
brew_install imagemagick
brew_install gpg
# install github/gh/gh

# cask_install applicatons
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

# install go toolchain
go_install fzf github.com/junegunn/fzf
go_install dotfiles github.com/rhysd/dotfiles

go_exec dotfiles link
