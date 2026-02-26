# dotfiles

macOS 環境のセットアップ用 dotfiles リポジトリです。

## セットアップ

新しい Mac に以下のコマンドを実行するだけで環境を構築できます。

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kameike/dotfiles/master/init.sh)"
```

または、リポジトリをクローン後に `make init` を実行します。

```sh
git clone https://github.com/kameike/dotfiles ~/dotfiles
cd ~/dotfiles
make init
```

環境名を指定したい場合は、`init.sh` の第2引数に `main` / `dev` / `agent` を渡します。

```sh
./init.sh _ dev
```

> 第2引数未指定時は `main` として実行されます。


## init.sh が行うこと

## インストールプロファイル

- `main` (デフォルト): 既存のインストール内容をそのまま実行
- `dev`: コメントアウト済みのサンプル 5 行のみ（必要なものを有効化して利用）
- `agent`: コメントアウト済みのサンプル 5 行のみ（必要なものを有効化して利用）

1. Xcode Command Line Tools のインストール
2. [Homebrew](https://brew.sh/) のインストール・更新
3. 以下のツールを brew でインストール:
   - go, git, docker, tmux, neovim, openssl, terraform, imagemagick, gnupg, gh
4. 以下のアプリを brew cask でインストール:
   - iTerm2, Clipy, Google Chrome, Slack, 1Password, Notion
   - Microsoft Word / PowerPoint / Excel
   - Visual Studio Code
5. Go 製ツールのインストール:
   - [fzf](https://github.com/junegunn/fzf)
   - [rhysd/dotfiles](https://github.com/rhysd/dotfiles) (シンボリックリンク管理)
6. `git/gitconfig_local` と `zsh/zshenv_local` のローカル設定ファイルを生成
7. `dotfiles link` でシンボリックリンクを作成

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

## ローカル設定

端末ごとに異なる設定は以下のファイルで管理します。これらは `init.sh` 実行時にテンプレートからコピーされます。

- `git/gitconfig_local` — git の署名鍵など端末固有の設定
- `zsh/zshenv_local` — 端末固有の環境変数

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

## iTerm2 の設定

`dotfiles link` 実行後、iTerm2 の設定ディレクトリを以下に変更します。

```
/Users/kei/.config/iterm2
```
