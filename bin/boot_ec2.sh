#!/bin/sh
#vim: syntax=sh

CONFIG=$HOME/.config
BINS=$CONFIG/bin

# set -eu

sudo yum install -y git
echo "ok"

cloneConfig() {
  if [ ! -d "$CONFIG" ]; then
    git clone https://github.com/kameike/env.git $CONFIG
  fi
}

setupNeovim() {
  if type neovim > /dev/null 2>&1; then
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


cloneConfig
echo "config done"
linkarcs
echo "linkrcs done"
setupNeovim
echo "neovim done"
