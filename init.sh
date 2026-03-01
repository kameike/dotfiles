#!/bin/sh

set -eu

brewcmd='/opt/homebrew/bin/brew'
gocmd='/opt/homebrew/bin/go'

main()
{
  env_name="${1:-main}"

  section "🔧 System Setup"
  setup_repo

  section "🍺 Homebrew"
  setup_brew

  section "📁 Directories"
  make_directory_if_not_exists ~/tmp
  make_directory_if_not_exists ~/dev
  make_directory_if_not_exists ~/.config

  section "🐍 Python Packages"
  pip3 install --upgrade pip > /dev/null 2>&1 && echo "✅ pip is ready"
  pip3 install pynvim > /dev/null 2>&1 && echo "✅ pynvim is ready"

  section "📦 Packages"
  install_for_env "$env_name"

  section "⚙️  Config Files"
  if_not_exist_then_copy './git/gitconfig_local' './git/gitconfig_local_template'
  if_not_exist_then_copy './zsh/zshenv_local' './zsh/zshenv_local_template'

  section "🔗 Dotfiles Linking"
  go_exec dotfiles link | sed \
    -e 's/^Exist:/🔗/g' \
    -e 's/^Linked:/✅/g' \
    -e 's/^Failed:/❌/g'
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
      echo "❌ Error: unknown environment: $1"
      echo "   Available environments: main, dev, agent"
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
  cask_install claude-code
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
      echo "📋 Copied: $source_file -> $target_file"
    else
      echo "❌ Error: template not found: $source_file"
    fi
  else
    echo "✅ $target_file"
  fi
}

# setup brew
setup_brew()
{
  if type brew > /dev/null 2>&1; then
    printf "🍺 Updating Homebrew... "
    $brewcmd update > /dev/null 2>&1
    echo "✅ brew is ready"
  else
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ Homebrew installed"
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
    echo "📦 Installing: $1"
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
    echo "✅ installed"
  else
    echo "✅ already installed"
  fi

  printf "📂 dotfiles repository... "
  if git -C ~/ clone https://github.com/kameike/dotfiles > /dev/null 2>&1; then
    echo "✅ cloned"
  else
    echo "✅ already exists"
  fi

  cd ~/dotfiles
}

make_directory_if_not_exists() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "📁 Created: $dir"
  else
    echo "✅ $dir"
  fi
}



main "$@"
