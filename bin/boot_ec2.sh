#!/bin/sh
#vim: syntax=sh

CONFIG=$HOME/.config
BINS=$CONFIG/bin

# set -eu


install() {
  if type $1 > /dev/null 2>&1; then
    echo "$1 has already installed"
    return
  fi

  sudo yum install -y $1
}

cloneConfig() {
  if [ ! -d "$CONFIG" ]; then
    git clone git@github.com:kameike/env.git $CONFIG
  fi
}

installNode() {
  if type node > /dev/null 2>&1; then
    echo "node has already installed"
    return
  fi
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  . ~/.nvm/nvm.sh
  nvm install node
}

setupNeovim() {
  if type nvim > /dev/null 2>&1; then
    echo "neovim has already installed"
    return
  fi

  #!/usr/bin/env bash
  sudo yum groups install -y Development\ tools
  sudo yum install -y cmake
  sudo yum install -y python3
  sudo pip-3 install neovim --upgrade
  (
  cd "$(mktemp -d)"
  git clone https://github.com/neovim/neovim.git
  cd neovim
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  )
}

linkarcs() {
  $BINS/linkrcs.sh
}


install git

cloneConfig
linkarcs
setupNeovim

install tmux
install golang
installNode

$CONFIG/nvim/boot.sh
rm ~/.ssh/config
