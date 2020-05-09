# test ! -d ~/tmp && mkdir ~/tmp
# test ! -d ~/dev && mkdir ~/dev
# test ! -d ~/go && mkdir ~/go


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

export TMP=$HOME/tmp
export DEV=$HOME/dev
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec/
export CONFIG_PATH=$HOME/.config
export VISUAL=nvim
export EDITOR="$VISUAL"
export DOTFILES_REPO_PATH=$HOME/dotfiles

# go
export PATH=$GOPATH/bin/:$PATH
export PATH=$GOROOT/bin/:$PATH

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

