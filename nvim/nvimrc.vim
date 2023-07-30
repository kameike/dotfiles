"enable_at_startupdein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
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

let s:dein_cache_dir = expand('~/.cache/dein')
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_cache_dir)

  " Required:
  call dein#begin(s:dein_cache_dir)

  "=== color scheime
  call dein#add('NLKNguyen/papercolor-theme')

  "=== Copilot
  call dein#add('github/copilot.vim')

  "=== denops for dark powered plugins
  call dein#add('vim-denops/denops.vim')

  "=== ddc
  call dein#add('Shougo/ddc.vim')
  call dein#add('Shougo/ddc-ui-native')
  call dein#add('Shougo/ddc-source-around')
  call dein#add('Shougo/ddc-filter-matcher_head')
  call dein#add('Shougo/ddc-filter-sorter_rank')
  call dein#add('Shougo/ddc-source-nvim-lsp')


  call dein#add('neovim/nvim-lspconfig')
  


  call dein#add('mattn/vim-goimports')



  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif
endif

" Required:
filetype plugin indent on
syntax enable

"Use insert mode like emacs
imap <C-d> <Del>
imap <C-a> <home>
imap <C-e> <End>
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-f> <right>
imap <C-b> <left>
imap <expr> <C-y> <SID>pasteFromCtrlK()

"For Copilot
imap  <C-s><C-o> <Plug>(copilot-suggest)
imap  <C-s><C-p> <Plug>(copilot-next)
imap  <C-s><C-n> <Plug>(copilot-previous)
imap  <C-s><C-d> <Plug>(copilot-dismiss)


function! s:pasteFromCtrlK() abort
  return @y
endfunction





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

set ignorecase
set smartcase
set incsearch
set nohlsearch

let $LANG = "en"
let $LANG = "en_US"


" " ぴょこぴょこ出さない
" :set completeopt=noinsert



"alias---------------------------
let mapleader = "\<space>"
nmap <c-n> :tabn <cr>
nmap <c-p> :tabp <cr>


nmap <Leader>br :bufdo e!<CR>
nmap <Leader>pp "*p
nmap <Leader>q :q<CR>
nmap <Leader>so :so $MYVIMRC<CR>
nmap <Leader>sp  :<C-u>setl spell! spell?<CR>
nmap <Leader>yy "*yy
vmap <Leader>yy "*y
nmap <Leader>cc :wqa <CR>
nmap <Leader>rr :wa <CR>:!go run .<CR>


"Commands-----------------------
command! EditSource execute 'tabe ~/dotfiles/nvim'
command! EditSnipet execute 'vnew ~/.config/nvim/snipets'


" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

"Color Scripts-------------------------
colorscheme PaperColor
"colorscheme molokai
set background=dark

let g:indent_guides_auto_colors = 0

"Gitを編集するときにはスペルチェックする
autocmd BufNewFile,BufRead COMMIT_EDITMSG setl spell



"===== dcc config
"
" Customize global settings

" You must set the default ui.
" NOTE: native ui
" https://github.com/Shougo/ddc-ui-native
call ddc#custom#patch_global('ui', 'native')
" Use around source.
" https://github.com/Shougo/ddc-source-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', #{
      \ _: #{
      \   matchers: ['matcher_head'],
      \   sorters: ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', #{
      \   around: #{ mark: 'A' },
      \ })
call ddc#custom#patch_global('sourceParams', #{
      \   around: #{ maxSize: 500 },
      \ })

" Customize settings on a filetype
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources',
      \ ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', #{
      \   clangd: #{ mark: 'C' },
      \ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', #{
      \   around: #{ maxSize: 100 },
      \ })


call ddc#custom#patch_global('sources', ['nvim-lsp'])
call ddc#custom#patch_global('sourceOptions', #{
      \   nvim-lsp: #{
      \     mark: 'lsp',
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \   },
      \ })

call ddc#custom#patch_global('sourceParams', #{
      \   nvim-lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \     }),
      \     enableResolveItem: v:true,
      \     enableAdditionalTextEdit: v:true,
      \   }
      \ })


" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()
