"enable_at_startupdein Scripts-----------------------------
" dein.vim: Vimのプラグインマネージャー
" Vi互換モードを無効にしてNeovimの機能を使えるようにする
if &compatible
  set nocompatible               " Be iMproved
endif


" キャッシュディレクトリを ~/.cache に設定し、なければ作成する
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

" dein.vim がruntimepathに追加されていなければ、クローンして追加する
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

" deinのキャッシュディレクトリを設定
let s:dein_cache_dir = expand('~/.cache/dein')
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_cache_dir)

  " Required:
  call dein#begin(s:dein_cache_dir)

  "=== color scheime
  " PaperColorテーマ: 見やすいカラースキームプラグイン
  call dein#add('NLKNguyen/papercolor-theme')

  "=== Copilot
  " GitHub Copilot: AIによるコード補完
  call dein#add('github/copilot.vim')

  "=== denops for dark powered plugins
  " denops.vim: Deno製のVim/Neovimプラグイン基盤（ddc等が依存）
  call dein#add('vim-denops/denops.vim')

  "=== ddc
  " ddc.vim: denopsベースの高機能補完フレームワーク
  call dein#add('Shougo/ddc.vim')
  " ネイティブUIで補完候補を表示するUI
  call dein#add('Shougo/ddc-ui-native')
  " カーソル周辺のテキストを補完ソースにする
  call dein#add('Shougo/ddc-source-around')
  " 入力の先頭でフィルタリングするマッチャー
  call dein#add('Shougo/ddc-filter-matcher_head')
  " ランクベースで補完候補をソートするフィルター
  call dein#add('Shougo/ddc-filter-sorter_rank')
  " LSP（Language Server Protocol）を補完ソースにする
  call dein#add('Shougo/ddc-source-nvim-lsp')


  " LSPの設定を管理するプラグイン
  call dein#add('neovim/nvim-lspconfig')


  " Go用: ファイル保存時に自動でimportを整理する
  call dein#add('mattn/vim-goimports')



  call dein#end()
  call dein#save_state()

  " 未インストールのプラグインがあれば自動インストール
  if dein#check_install()
    call dein#install()
  endif
endif

" Required:
" ファイルタイプに応じたプラグインとインデント設定を有効化
filetype plugin indent on
" シンタックスハイライトを有効化
syntax enable

" インサートモードでEmacsのようなキーバインドを使えるようにする
imap <C-d> <Del>       " C-d: 1文字削除（Deleteキー）
imap <C-a> <home>      " C-a: 行頭に移動
imap <C-e> <End>       " C-e: 行末に移動
imap <C-p> <Up>        " C-p: 1行上に移動
imap <C-n> <Down>      " C-n: 1行下に移動
imap <C-f> <right>     " C-f: 1文字右に移動
imap <C-b> <left>      " C-b: 1文字左に移動
imap <expr> <C-y> <SID>pasteFromCtrlK()  " C-y: yレジスタからペースト

" Copilotのキーバインド設定
imap  <C-s><C-o> <Plug>(copilot-suggest)   " C-s C-o: 補完を提案
imap  <C-s><C-p> <Plug>(copilot-next)      " C-s C-p: 次の候補を表示
imap  <C-s><C-n> <Plug>(copilot-previous)  " C-s C-n: 前の候補を表示
imap  <C-s><C-d> <Plug>(copilot-dismiss)   " C-s C-d: 補完を閉じる


" C-yで使用するyレジスタの内容を返す関数
function! s:pasteFromCtrlK() abort
  return @y
endfunction




"Basic Settings---------------------------
" GUIなしの場合、256色を有効にする
if !has('gui_running')
  set t_Co=256
endif
" ステータスラインを常に表示する（0=非表示, 1=2窓以上, 2=常に表示）
set laststatus=2
" 改行時に前の行のインデントを継承する
set autoindent

" C言語スタイルのインデントを自動適用する
set cindent
" タブをスペースに展開する
set expandtab
" インデントのスペース幅
set shiftwidth=2
" タブ幅
set tabstop=2
" 行番号を表示する
set nu

" signを出し続ける（LSPのエラー/警告アイコン表示用にサインカラムを常時確保）
set signcolumn=yes

" spell check
" スペルチェックの対象言語（英語と日本語CJK文字を対象）
set spelllang=en,cjk

" 再度読み込み（外部でファイルが変更された場合、自動で再読み込みする）
set autoread

" CursorHoldイベントの発火間隔（ミリ秒）。LSPのホバー表示等に使われる
set updatetime=4000
syntax on


"white space
" 末尾スペースをアンダーラインで強調表示する
highlight whiteSpace cterm=underline ctermfg=lightblue guibg=white
match whiteSpace /__/

" 検索設定
set ignorecase   " 大文字・小文字を区別しない
set smartcase    " 検索語に大文字が含まれる場合のみ大文字・小文字を区別する
set incsearch    " インクリメンタルサーチ（入力しながらリアルタイム検索）
set nohlsearch   " 検索結果のハイライトをしない

" メッセージ等の言語を英語に設定（文字化け防止）
let $LANG = "en"
let $LANG = "en_US"


" " ぴょこぴょこ出さない
" :set completeopt=noinsert



"alias---------------------------
" スペースキーをリーダーキーに設定
let mapleader = "\<space>"
" C-n: 次のタブに移動
nmap <c-n> :tabn <cr>
" C-p: 前のタブに移動
nmap <c-p> :tabp <cr>


" <Leader>br: 開いている全バッファを強制再読み込みする
nmap <Leader>br :bufdo e!<CR>
" <Leader>pp: クリップボード(*)からペースト
nmap <Leader>pp "*p
" <Leader>q: ウィンドウを閉じる
nmap <Leader>q :q<CR>
" <Leader>sp: スペルチェックのオン/オフを切り替え
nmap <Leader>sp  :<C-u>setl spell! spell?<CR>
" <Leader>yy: 現在行をクリップボード(*)にヤンク（ノーマルモード）
nmap <Leader>yy "*yy
" <Leader>yy: 選択範囲をクリップボード(*)にヤンク（ビジュアルモード）
vmap <Leader>yy "*y
" <Leader>cc: 全ウィンドウを保存して終了
nmap <Leader>cc :wqa <CR>


"Commands-----------------------
" :EditVimrc で vimrc と init.lua を新しいタブで開く
command! EditVimrc :tabe ~/.config/nvim/vimrc.vim | :tabe ~/.config/nvim/init.lua
" :EditSnipet でスニペットディレクトリを新しいタブで開く
command! EditSnipet :tabe ~/.config/nvim/snipets


"Color Scripts-------------------------
" PaperColorカラースキームを適用
colorscheme PaperColor
"colorscheme molokai
" ダークテーマを使用
set background=dark

let g:indent_guides_auto_colors = 0

" Gitコミットメッセージ編集時にスペルチェックを有効にする
autocmd BufNewFile,BufRead COMMIT_EDITMSG setl spell


"===== dcc config
"
" Customize global settings

" You must set the default ui.
" NOTE: native ui
" https://github.com/Shougo/ddc-ui-native
" ddcのUIをネイティブポップアップに設定
call ddc#custom#patch_global('ui', 'native')
" Use around source.
" https://github.com/Shougo/ddc-source-around
" 補完ソースとしてカーソル周辺のテキスト（around）を使用
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
" 全ソース共通: 先頭一致でフィルタリングし、ランクでソート
call ddc#custom#patch_global('sourceOptions', #{
      \ _: #{
      \   matchers: ['matcher_head'],
      \   sorters: ['sorter_rank']},
      \ })

" Change source options
" aroundソースのマークを 'A' に設定し、最大500文字を補完対象にする
call ddc#custom#patch_global('sourceOptions', #{
      \   around: #{ mark: 'A' },
      \ })
call ddc#custom#patch_global('sourceParams', #{
      \   around: #{ maxSize: 500 },
      \ })

" Customize settings on a filetype
" C/C++ではaroundとclangdを補完ソースとして使用
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources',
      \ ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', #{
      \   clangd: #{ mark: 'C' },
      \ })
" Markdownではaroundの最大文字数を100に絞る
call ddc#custom#patch_filetype('markdown', 'sourceParams', #{
      \   around: #{ maxSize: 100 },
      \ })


" nvim-lspをメインの補完ソースに設定
call ddc#custom#patch_global('sources', ['nvim-lsp'])
" LSPソースの設定: マーク表示・ドット/矢印演算子の後に自動補完を強制発火
call ddc#custom#patch_global('sourceOptions', #{
      \   nvim-lsp: #{
      \     mark: 'lsp',
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \   },
      \ })

" LSPソースのパラメータ設定
" スニペットエンジンにvim-vsnipを使用し、アイテム解決と追加テキスト編集を有効化
call ddc#custom#patch_global('sourceParams', #{
      \   nvim-lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \     }),
      \     enableResolveItem: v:true,
      \     enableAdditionalTextEdit: v:true,
      \   }
      \ })


" <TAB>: 補完候補が表示されていれば次の候補を選択、
"        カーソルが行頭またはスペースの直後ならタブを挿入、
"        それ以外はddcの手動補完を起動
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: 補完候補が表示されていれば前の候補を選択、なければバックスペース
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
" ddcの補完を有効化
call ddc#enable()
