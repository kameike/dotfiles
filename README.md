# dotfiles

macOS 環境のセットアップ用 dotfiles リポジトリです。

## 環境の種類

| 環境名 | 用途 |
|---|---|
| `main` | 個人 Mac のフル環境（デフォルト） |
| `dev` | 開発用途に絞った軽量環境 |
| `agent` | AI エージェント・自動化用途の環境 |

---

## セットアップ

### main 環境（個人 Mac・デフォルト）

個人 Mac に全ツールとアプリをインストールします。

**ワンライナー（新しい Mac に初めてセットアップする場合）:**

```sh
# main（デフォルト）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kameike/dotfiles/master/init.sh)" bash

# 環境を指定する場合
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kameike/dotfiles/master/init.sh)" bash main
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kameike/dotfiles/master/init.sh)" bash dev
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kameike/dotfiles/master/init.sh)" bash agent
```

**リポジトリをクローン済みの場合:**

```sh
cd ~/dotfiles
./init.sh        # main（デフォルト）
./init.sh main
./init.sh dev
./init.sh agent
```

インストールされるもの:

- **CLI ツール**: go, git, docker, tmux, neovim, openssl, terraform, imagemagick, gnupg, gh, jq, ripgrep, fzf
- **アプリ**: iTerm2, Clipy, Google Chrome, Slack, 1Password, Notion, Microsoft Office (Word / PowerPoint / Excel), VS Code
- **Go ツール**: [rhysd/dotfiles](https://github.com/rhysd/dotfiles)（シンボリックリンク管理）

---

### dev 環境（開発用）

言語ランタイムや開発ツールを追加インストールする環境です。
デフォルトはコメントアウト済みのため、`init.sh` の `install_dev()` を編集して必要なものを有効化してから実行します。

```sh
./init.sh dev
```

`install_dev()` のカスタマイズ例 (`init.sh`):

```sh
install_dev() {
  brew_install node
  brew_install python
  brew_install postgresql
  cask_install intellij-idea
  go_install gopls golang.org/x/tools/gopls
}
```

---

### agent 環境（AI エージェント・自動化用）

AI エージェントや CI/CD など自動化環境向けの最小構成です。
GUI アプリは含まず、スクリプト処理に必要なツールのみをインストールします。

```sh
./init.sh agent
```

インストールされるもの:

- **CLI ツール**: jq, ripgrep, fd

オプション（コメントアウトを外して有効化）:

- `cursor` (cask)
- `mockgen` (go tool)

---

## init.sh が行うこと（共通）

環境を問わず以下の処理が実行されます。

1. Xcode Command Line Tools のインストール
2. [Homebrew](https://brew.sh/) のインストール・更新
3. ディレクトリの作成: `~/tmp`, `~/dev`, `~/.config`
4. `pip3 install pynvim` の実行
5. 環境ごとのパッケージインストール（上記参照）
6. `git/gitconfig_local` と `zsh/zshenv_local` のローカル設定ファイルを生成（未存在時のみ）
7. `dotfiles link` でシンボリックリンクを作成

---

## ディレクトリ構成

```
dotfiles/
├── bin/               # ユーティリティスクリプト
├── git/               # git 設定
│   ├── gitconfig
│   ├── gitconfig_local_template
│   └── gitignore
├── nvim/              # Neovim 設定
│   ├── init.lua
│   └── nvimrc.vim
├── ssh/               # SSH 設定
│   └── config
├── zsh/               # Zsh 設定
│   ├── zshrc
│   ├── zshenv
│   └── zshenv_local_template
├── tmux.conf          # tmux 設定
├── init.sh            # セットアップスクリプト
└── Makefile
```

---

## ユーティリティスクリプト (`bin/`)

| スクリプト | 説明 |
|---|---|
| `memo` | メモを素早く作成・開く |
| `opennote` | ノートを開く |
| `tmpnote_new` | 一時ノートを新規作成 |
| `tmpnote_open` | 一時ノートを開く |
| `syncgit` | Git リポジトリを同期 |
| `gtd` | GTD タスク管理 |
| `gtd_insert_routine` | GTD ルーティンタスクの挿入 |
| `enczip` | ZIP ファイルを暗号化 |
| `togif` | 動画を GIF に変換 |
| `clean-desktop` | デスクトップを整理 |
| `open_notion_root` | Notion のルートを開く |
| `passemail` | メールアドレスをペースト |
| `rand` | ランダム文字列を生成 |
| `editbin` | bin/ 内のスクリプトを編集 |
| `localenv` | fzf で `~/.zshenv_local` の環境変数を選択・更新（追加時にテンプレート更新も確認） |

---

## ローカル設定

端末ごとに異なる設定は以下のファイルで管理します。これらは `init.sh` 実行時にテンプレートからコピーされます。

- `git/gitconfig_local` — git の署名鍵など端末固有の設定
- `zsh/zshenv_local` — 端末固有の環境変数

---

## Git コミット署名の設定

GPG キーを生成します。

```sh
gpg --gen-key
```

以下の情報で設定します。

```
User: kameike
Email: kameike@users.noreply.github.com
```

キー ID を確認します。

```sh
gpg --list-secret-keys --keyid-format LONG
```

出力例:

```
sec   ed25519/xxxxxxxxxxxxxxxx YYYY-MM-DD [SC]
      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
uid                 kameike <kameike@users.noreply.github.com>
ssb   cv25519/XXXXXXXXXXXXXXXX YYYY-MM-DD [SC]
```

`git/gitconfig_local` の `user.signingkey` に上記のキー ID を設定します。

GitHub に公開鍵を登録します。

```sh
gpg --armor --export xxxxxxxxxxxxxxxx
```

表示された公開鍵を [GitHub GPG keys 設定](https://github.com/settings/gpg/new) に追加します。

---

## iTerm2 の設定

`dotfiles link` 実行後、iTerm2 の設定ディレクトリを以下に変更します。

```
/Users/kei/.config/iterm2
```
