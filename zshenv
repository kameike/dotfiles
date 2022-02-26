#:checkhealth provider test ! -d ~/tmp && mkdir ~/tmp
# test ! -d ~/dev && mkdir ~/dev
# test ! -d ~/go && mkdir ~/go


if [ "$(uname -m)" = 'x86_64' ]; then
  OS='Mac'
  export CPUARC='X86_64'
elif [ "$(uname -m)" = 'arm64' ]; then
  OS='Linux'
  export CPUARC='ARM64'
else
  echo "Your cpu arc ($(uname -m)) is not supported."
  exit 1
fi


if [ "$(uname)" = 'Darwin' ]; then
   OS='Mac'
   export OSTYPE='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
  OS='Linux'
  export OSTYPE='Linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi


# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
# 
export TMP=$HOME/tmp
export DEV=$HOME/dev
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec/
export CONFIG_PATH=$HOME/.config
export VISUAL=nvim
export EDITOR="$VISUAL"
export DOTFILES_REPO_PATH=$HOME/dotfiles
export AWS_SDK_LOAD_CONFIG=1
export DART_SDK=$HOME/.config/flutter/bin/cache/dart-sdk


# neovim python https://qiita.com/uasi/items/d91b77a55280e4002aae
export LC_CTYPE=ja_JP.UTF-8

# go
export PATH=$GOPATH/bin/:$PATH
export PATH=$GOROOT/bin/:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:$HOME/.pub-cache/bin

# flutter
export PATH=$HOME/.config/flutter/bin:$PATH


# Rust
export PATH=$HOME/.cargo/bin:$PATH

# my shell scripts
export PATH=$CONFIG_PATH/bin:$PATH

if [ OS = 'Mac' ]; then
  # js
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  # ruby
  export PATH=$HOME/.rbenv/bin:$PATH
  # python
  export PATH=$HOME/Library/Python/3.7/bin/:$PATH
  # flutter
  export PATH=$DEV/flutter/bin:$PATH
fi
export PATH="$HOME/.yarn/bin:$PATH"


export KAME=toroasdfasd

export TERM=xterm-256color

source ~/.env
