"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


function! s:install_dein() abort
  echo 'Installing dein.vim'
  let cmd = 
        \ 'curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && ' .
        \ '(sh ./installer.sh ~/.cache/dein || rm installer.sh)'
  let out = system(cmd)
  if v:shell_error
    echohl ErrorMsg | echom 'Error!: ' . out | echohl None
  else
    echo 'dein.vim was install to ~/.cache/dein'
  endif
endfunction

let s:dein_repo_path = expand('~/.cache/dein/repos/github.com/Shougo/dein.vim')
if !isdirectory(s:dein_repo_path)
  call s:install_dein()
endif

let s:dein_cache_dir = expand('~/.cache/dein')
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_cache_dir)

  " Required:
  call dein#begin(s:dein_cache_dir)

  " Let dein manage dein
  call dein#add(s:dein_repo_path)


  " Add or remove your plugins here:
  "=== dark matter
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('ujihisa/unite-colorscheme')
  call dein#add('fatih/vim-go')
  call dein#add('posva/vim-vue')

  call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })

  "=== slim
  call dein#add('slim-template/vim-slim')

  "=== elm
  call dein#add('lambdatoast/elm.vim')

  "=== toml
  call dein#add('cespare/vim-toml')

  "=== color scheime
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('tomasr/molokai')
  call dein#add('jpo/vim-railscasts-theme')
  call dein#add('NLKNguyen/papercolor-theme')

  "=== visualize
  call dein#add('itchyny/lightline.vim')
  call dein#add('nathanaelkane/vim-indent-guides')


  "=== html plugin
  call dein#add('tpope/vim-surround')

  "=== html plugin
  "http://emmet.io/
  "call dein#add('mattn/emmet-vim')

  "=== excute buffer code
  call dein#add('thinca/vim-quickrun')

  "=== sytax checker
  call dein#add('scrooloose/syntastic')

  "=== sytax js helper
  call dein#add('pangloss/vim-javascript')

  "=== sytax jsx helper
  call dein#add('mxw/vim-jsx')

  "=== sytax less helper
  call dein#add('groenewege/vim-less')

  "=== sytax elixir helper
  call dein#add('elixir-lang/vim-elixir')

  "=== sytax stylus helper
  call dein#add('wavded/vim-stylus')

  "=== sytax erlang helper
  call dein#add('vim-erlang/vim-erlang-runtime')

  "=== swift
  call dein#add('keith/swift.vim')

  "=== file tree
  "call dein#add('scrooloose/nerdtree')

  "=== rename tab
  call dein#add('gcmt/taboo.vim')


  call dein#add('leafgarland/typescript-vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('neovimhaskell/haskell-vim')

  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif
endif

" Required:
filetype plugin indent on
syntax enable



"Snipet -------------------------
let g:neosnippet#snippets_directory='~/.config/nvim/snipets/'
imap <C-o> <Plug>(neosnippet_expand_or_jump)
smap <C-o> <Plug>(neosnippet_expand_or_jump)

" use insert mode like emacs
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <C-a> <home>
inoremap <C-e> <End>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <right>
inoremap <C-b> <left>


"Basic Settings---------------------------
if !has('gui_running')
  set t_Co=256
endif
set laststatus=2
set autoindent

set cindent
set expandtab
set shiftwidth=2
set tabstop=2
set nu
" signを出し続ける
set signcolumn=yes

" spell check
set spelllang=en,cjk

" 再度読み込み
set autoread

set updatetime=4000
syntax on


"white space
highlight whiteSpace cterm=underline ctermfg=lightblue guibg=white
match whiteSpace /__/

let g:lightline = {'colorscheme': 'PaperColor'}

set ignorecase
set smartcase
set incsearch
set nohlsearch


" ぴょこぴょこ出さない
:set completeopt=noinsert

" Tab rename ---------------------------
let g:taboo_renamed_tab_format = "[%N:%l]%f%m"

" Deoplete ---------------------------
let g:deoplete#enable_at_startup = 1


" $GOROOT/misc/vimLangClient
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

let g:LanguageClient_serverCommands = {
      \ 'go': ['gopls']
      \ }
let g:LanguageClient_loadSettings = 1

"alias---------------------------
let mapleader = "\<space>"
nmap <c-n> :tabn <cr>
nmap <c-p> :tabp <cr>


nmap <Leader>br :bufdo e!<CR>
nmap <Leader>ff :VimFiler -split -simple -winwidth=35 -no-quit<CR>
nmap <Leader>ga :Gina add --all<CR>
nmap <Leader>gb :Gina branch<CR>
nmap <Leader>gc :Gina commit<CR>
nmap <Leader>ggg :w<CR>:Gina add --all<CR>:Gina commit<CR>
nmap <Leader>gp :Gina push origin HEAD<CR>
nmap <Leader>gs :Gina status<CR>
nmap <Leader>lr :call LanguageClient#textDocument_rename()<CR>
nmap <Leader>ld :call LanguageClient#textDocument_definition()<CR><CR>
nmap <Leader>ll :call LanguageClient#textDocument_hover()<CR> 

nmap <Leader>ug :Unite grep/git<CR>
nmap <Leader>uf :Unite file_rec/git<CR>
nmap <Leader>u" :Unite register<CR>
nmap <Leader>us :Unite source<CR>
nmap <Leader>ub :Unite buffer<CR>
nmap <Leader>ur :Unite register<CR>
nmap <Leader>uw :Unite window<CR>
nmap <Leader>pp "*p
nmap <Leader>source :so $MYVIMRC<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>yy "*yy
nmap <Leader>s :<C-u>setl spell! spell?<CR>
vmap <Leader>yy "*y


" call denite#custom#source('file_rec', 'matchers', ['matcher_ignore_globs', 'matcher_fuzzy'])
" call denite#custom#var('file_rec', 'command', ['git', 'ls-files', '`git rev-parse --show-cdup`'])

"Commands-----------------------
command! EditSource execute 'tabe ~/dotfiles/nvimrc.vim'
command! EditSnipet execute 'vnew ~/.config/nvim/snipets'

command! RenameInGit call <SID>do_rename()

function! s:do_rename() abort
  let l:cpath = expand('%:p:h')
  let l:target = expand('<cword>')

  call inputsave()
  let l:name = input('Rename from ' . l:target . ' to: ')
  call inputrestore()
  let l:cmd = 'git -C '.l:cpath. ' ls-files $(git -C '.l:cpath.' rev-parse --show-toplevel) | sed -e "s/\n/ /g" | xargs echo'
  let l:out = system(l:cmd)
  if v:shell_error
    echohl ErrorMsg | echom 'Error!: ' . out | echohl None
    return
  endif

  echo l:out
  let @a = l:out
  exec 'argdel *'
  exec 'argadd ' . l:out
  exec 'argdo %s/'. l:target .'/'. l:name. '/g | update'
endfunction



"Align------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

"Color Scripts-------------------------
colorscheme PaperColor
set background=dark

let $LANG = "en_US"
let g:indent_guides_auto_colors = 0
" hi IndentGuidesOdd  ctermbg=235
" hi IndentGuidesEven ctermbg=236

let g:vimfiler_as_default_explorer = 1
