"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
let &runtimepath = &runtimepath . ',' . $HOME . '/.config/nvim/plugins/repos/github.com/Shougo/dein.vim'

" Required:
call dein#begin($HOME . '/.config/nvim/plugins')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')


" Add or remove your plugins here:
"=== dark matter
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('lambdalisue/gina.vim')
call dein#add('osyo-manga/unite-quickfix')
call dein#add('ujihisa/unite-colorscheme')

"=== elm
call dein#add('ambdatoast/elm.vim')

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

"=== file tree
"call dein#add('scrooloose/nerdtree')

"=== rename tab
call dein#add('gcmt/taboo.vim')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


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

syntax on

"white space
highlight whiteSpace cterm=underline ctermfg=lightblue guibg=white
match whiteSpace /__/

let g:lightline = {'colorscheme': 'PaperColor'}

set ignorecase
set smartcase
set incsearch
set nohlsearch
set langmenu=en_US.UTF-8

" Tab rename ---------------------------
let g:taboo_renamed_tab_format = "[%N:%l]%f%m"

" Deoplete ---------------------------
let g:deoplete#enable_at_startup = 1

"Alias---------------------------
nmap <C-n> :tabn <CR>
nmap <C-p> :tabp <CR>
nmap <C-l> :Denite -auto_preview grep<CR>

nmap <Leader>f :Denite file_rec<CR>
nmap <Leader>sh <Plug>GitGutterStageHunk
nmap <Leader>uh <Plug>GitGutterUndoHunk
nmap <Leader>ph <Plug>GitGutterPreviewHunk
nmap <Leader>gs :Gina status<CR>
nmap <Leader>gc :Gina commit<CR>
nmap <Leader>cc :Denite colorscheme<CR>

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby


"Color Scripts-------------------------
colorscheme solarized

" colorscheme rdark-terminal2
" colorscheme parsec
" set background=light
colorscheme PaperColor
set background=light

let $LANG = "en_US"

let g:indent_guides_auto_colors = 0
let g:vimfiler_as_default_explorer = 1
hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=236
