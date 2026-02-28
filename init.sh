#!/bin/sh

set -eu

brewcmd='/opt/homebrew/bin/brew'
gocmd='/opt/homebrew/bin/go'

main()
{
  env_name="${1:-main}"

  section "🔧 環境セットアップ"
  setup_repo

  section "🍺 Homebrew"
  setup_brew

  section "📁 ディレクトリ作成"
  make_directory_if_not_exists ~/tmp
  make_directory_if_not_exists ~/dev
  make_directory_if_not_exists ~/.config

  section "🐍 Python パッケージ"
  pip3 install --upgrade pip > /dev/null 2>&1 && echo "✅ pip is ready"
  pip3 install pynvim > /dev/null 2>&1 && echo "✅ pynvim is ready"

  section "📦 パッケージインストール"
  install_for_env "$env_name"

  section "⚙️  設定ファイル"
  if_not_exist_then_copy './git/gitconfig_local' './git/gitconfig_local_template'
  if_not_exist_then_copy './zsh/zshenv_local' './zsh/zshenv_local_template'

  section "🔗 dotfiles リンク"
  go_exec dotfiles link
}

install_for_env() {
  case "$1" in
    main)
      install_main
      ;;
    dev)
      install_dev
      ;;
    agent)
      install_agent
      ;;
    *)
      echo "❌ エラー: 不明な環境名です: $1"
      echo "   利用可能な環境: main, dev, agent"
      exit 1
      ;;
  esac
}

install_main() {
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
  brew_install jq
  brew_install ripgrep
  brew_install fzf

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
  go_install dotfiles github.com/rhysd/dotfiles
  # go_install toolcmd github.com/kameike/tool/toolcmd
}

install_dev() {
  # brew_install node
  # brew_install python
  # brew_install postgresql
  # cask_install intellij-idea
  # go_install gopls golang.org/x/tools/gopls
  :
}

install_agent() {
  brew_install jq
  brew_install ripgrep
  brew_install fd
  brew_install openclaw-cli
  # cask_install cursor
  # go_install mockgen go.uber.org/mock/mockgen
}

if_not_exist_then_copy() {
  local target_file="$1"
  local source_file="$2"

  if [ ! -f "$target_file" ]; then
    if [ -f "$source_file" ]; then
      cp "$source_file" "$target_file"
      echo "📋 コピー完了: $source_file -> $target_file"
    else
      echo "❌ エラー: テンプレートが見つかりません: $source_file"
    fi
  else
    echo "✅ $target_file"
  fi
}

# setup brew
setup_brew()
{
  if type brew > /dev/null 2>&1; then
    printf "🍺 Homebrew アップデート中... "
    $brewcmd update > /dev/null 2>&1
    echo "✅ brew is ready"
  else
    echo "🍺 Homebrew をインストール中..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ Homebrew インストール完了"
  fi
}

brew_tap() {
  $brewcmd tap $1
}

pip_install() {
  echo ok
}


# install
brew_install()
{
  if !("$brewcmd" list --formula | grep -qx "$1" >/dev/null 2>&1); then
    "$brewcmd" install "$1"
  else
    installed_prompt "$1"
  fi
}

cask_install()
{
  if !("$brewcmd" list --cask | grep -qx "$1" >/dev/null 2>&1); then
    "$brewcmd" install --cask "$1"
  else
    installed_prompt "$1"
  fi
}

go_install()
{
  if ! type go > /dev/null 2>&1; then
    echo "Need go env to run this script"
    return 1
  fi

  if ! type $1 > /dev/null 2>&1; then
    echo "📦 インストール中: $1"
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
  $cmd "$@"
}


installed_prompt()
{
  echo "✅ $1 is ready"
}

section()
{
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  $1"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

setup_repo() {
  printf "🛠️  Xcode CLI tools... "
  if xcode-select --install > /dev/null 2>&1; then
    echo "✅ インストール完了"
  else
    echo "✅ インストール済み"
  fi

  printf "📂 dotfiles リポジトリ... "
  if git -C ~/ clone https://github.com/kameike/dotfiles > /dev/null 2>&1; then
    echo "✅ クローン完了"
  else
    echo "✅ 既に存在します"
  fi

  cd ~/dotfiles
}

# 関数定義
make_directory_if_not_exists() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "📁 作成: $dir"
  else
    echo "✅ $dir"
  fi
}



main "$@"
