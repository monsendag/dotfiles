set encoding=utf-8      " use UTF-8 encoding
set nocompatible        " be iMproved
set modelines=0


call plug#begin()
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'bling/vim-airline'
  Plug 'joshdick/airline-onedark.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'kien/ctrlp.vim'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'elzr/vim-json'
  Plug 'ervandew/supertab'
  Plug 'terryma/vim-expand-region'
  Plug 'coderifous/textobj-word-column.vim'
  Plug 'wincent/terminus'
  Plug 'wellle/targets.vim'
  Plug 'bkad/CamelCaseMotion'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

filetype plugin indent on " load indent file for specific filetypes

syntax enable " enable syntax highlighting
colorscheme onedark

" reload vimrc when saved
autocmd bufwritepost .vimrc source $MYVIMRC

" The 'scrolloff' (scroll offset) option determines 
" the number of context lines you would like to see above and below the cursor
set scrolloff=3

" automatically keep indentation
set autoindent

" show the current mode (NORMAL/INSERT)
set showmode

" see :help shocmd 
set showcmd

set hidden

" file completion
" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
" try :color <tab> 
set wildmode=longest,list,full
set wildmenu

" visual instead of audio bell
set visualbell

" show line below cursor
set cursorline

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set laststatus=2 " Always show statusline
set noswapfile " disable swap file
set number " show line number
set numberwidth=4 " set line number width
set nowrap " dont wrap lines
set mouse=nicr " enable mouse scrolling

set ruler
set ttyfast
set relativenumber
set undofile

" indent with two spaces
set expandtab
set shiftwidth=2
set softtabstop=2

" match tags
set matchpairs+=<:>
" unix line endings
set ff=unix

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" fix vim regex
nnoremap / /\v
vnoremap / /\v
set ignorecase " ignore case by default
set smartcase " dont ignore case if we have both lower and upper in a search
set gdefault " do substitutions globally by default

" incsearch, showmatch and hlsearch work together to highlight search results (as you type).
" It’s really quite handy, as long as you have the next line as well
set incsearch  " 
set showmatch
set hlsearch

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=120


" use tab to match bracket pair instead of %
nnoremap <tab> %
vnoremap <tab> %

" disable arrow keys in normal mode
" force us to learn hjkl
nnoremap <Space> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" save on losing focus
au FocusLost * :wa


set timeoutlen=1000 ttimeoutlen=-1 " ensure we don't need to double click esc
set esckeys timeout nottimeout

:autocmd InsertEnter * set timeoutlen=200
:autocmd InsertLeave * set timeoutlen=1000

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"

"filetype plugin indent on
"set wildignore+=*.zip,node_modules,.git,.svn,bower_components
:imap jj <Esc>

" open nerdtree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close nerdtree when closing all buffers
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"

nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" map , to :
nnoremap , :

nnoremap <leader>l :NERDTreeToggle<CR>


" open a new vertical split and switc to it 
nnoremap <leader>w <C-w>v<C-w>l

"Type <Space>o to open a new file: 
nnoremap <Leader>o :CtrlP<CR> 
"Type <Space>w to save file
nnoremap <Leader>w :w<CR> 
" Copy & paste to system clipboard with <Space>p and <Space>yz
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
nmap <leader>wq wq

"Hit Enter to go to end of file
nnoremap <CR> G
"Hit Backspace to go to beginning of file.
nnoremap <BS> gg
