

```
/bin/bash -c "`curl https://raw.githubusercontent.com/kameike/dotfiles/master/init.sh`"
```

## Gitコミットの署名

gitのコミットを署名できるようにするまでの忘備録です。

```
gpg --gen-key
```

下記を設定します。
```
User: kameike
Email: kameike@users.noreply.github.com
```

その後、gitのcommitの署名に生成した鍵を利用するために、
下記のコマンドを実行します。
```
gpg --list-secret-keys --keyid-format LONG
```

下記のxxxxxxxxxxxxxxxxの個所を控えます。
```
sec   ed25519/xxxxxxxxxxxxxxxx YYYY-MM-DD [SC]
      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
uid                 kameike <kameike@users.noreply.github.com>
ssb   cv25519/XXXXXXXXXXXXXXXX YYYY-MM-DD [SC]
```

その後、gitconfigの`user.signingkey`に設定します。

`git config --global user.signingkey xxxxxxxxxxxxxxxx` のコマンドでも設定が可能ですが、gitconfigに設定します。

現在は署名用の鍵は端末ごとに設定しているため、個別に設定する必要があります。
dotfilesには、グローバルな、`gitconfig`から、個別の端末に設定される値を設定するための仕組みがあります。下記はその説明です。
`init.sh` を実行後に `git/gitconfig_local`というファイルが生まれます。
これに `user.signingkey`のプロパティが準備されるため、これを設定することで端末個別に値を設定することができます。

次にGitHubに鍵を登録します。
```
gpg --armor --export xxxxxxxxxxxxxxxx
```
により表示される公開鍵をすべてコピーし[こちら](https://github.com/settings/gpg/new) に設定します。


## itermの設定

dotfileのlink後設定を下記に変更する

```
/Users/kei/.config/iterm2
```

## 