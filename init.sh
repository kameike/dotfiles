#!/bin/sh

set -eu

brewcmd='/opt/homebrew/bin/brew'
gocmd='/opt/homebrew/bin/go'

main()
{
  setup_repo
  setup_brew

  brew_tap neovim/neovim
  pip3 install --upgrade pip
  pip3 install neovim

  #utils
  brew_install go
  brew_install git
  brew_install docker
  brew_install tmux
  brew_install neovim
  brew_install openssl@3
  brew_install readline
  brew_install terraform
  brew_install imagemagick
  brew_install gnupg
  brew_install gh

  # cask_install applicatons
  cask_install iterm2
  cask_install clipy
  cask_install google-chrome
  cask_install slack
  cask_install 1password
  cask_install notion
  cask_install microsoft-word
  cask_install microsoft-powerpoint
  cask_install microsoft-excel
  cask_install visual-studio-code

  # install go toolchain
  go_install fzf github.com/junegunn/fzf
  go_install dotfiles github.com/rhysd/dotfiles

  if_not_exist_then_copy './git/gitconfig_local' './git/gitconfig_local_template'
  if_not_exist_then_copy './zsh/zshenv_local' './zsh/zshenv_local_template'

  go_exec dotfiles link
}

if_not_exist_then_copy() {
  # 第一引数はコピー先ファイル名
  local target_file="$1"
  # 第二引数はコピー元ファイル名
  local source_file="$2"

    # コピー先ファイルが存在しない場合にのみ処理を行う
    if [ ! -f "$target_file" ]; then
      # コピー元ファイルが存在するかを確認
      if [ -f "$source_file" ]; then
        # コピー元ファイルが存在する場合、コピーを実行
        cp "$source_file" "$target_file"
        echo "ファイルがコピーされました: $source_file -> $target_file"
      else
        # コピー元ファイルが存在しない場合、エラーメッセージを表示
        echo "エラー: コピー元ファイルが存在しません: $source_file"
      fi
    else
      # コピー先ファイルが既に存在する場合、警告メッセージを表示
      echo "✅ $target_file"
    fi
}

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
  if !(echo $brewlist | sed 's/ /\n/g' | grep -x $1 >/dev/null 2>&1); then
    $brewcmd install $1
  else
    installed_prompt $1
  fi
} 

cask_install()
{
  if !(echo $brewlist | sed 's/ /\n/g' | grep -x $1 >/dev/null 2>&1); then
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

setup_repo() {
  xcode-select --install || echo "ok"
  git -C ~/ clone https://github.com/kameike/dotfiles || echo "ok"
  cd ~/dotfiles
}

main
