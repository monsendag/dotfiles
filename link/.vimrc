set encoding=utf-8      " use UTF-8 encoding
set nocompatible        " be iMproved

call plug#begin()
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'bling/vim-airline'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'kien/ctrlp.vim'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'elzr/vim-json'
  Plug 'ervandew/supertab'
  Plug 'terryma/vim-expand-region'
  Plug 'coderifous/textobj-word-column.vim'
  Plug 'wincent/terminus'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

autocmd bufwritepost .vimrc source $MYVIMRC

" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"

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

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
nmap <leader>wq wq

"Hit Enter to go to end of file
nnoremap <CR> G
"Hit Backspace to go to beginning of file.
nnoremap <BS> gg

set showcmd
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set timeoutlen=10 ttimeoutlen=0 " ensure we don't need to double click esc

filetype plugin indent on " load indent file for specific filetypes

syntax enable " enable syntax highlighting
colorscheme atom-dark-256

set laststatus=2 " Always show statusline
set cursorline " show line below cursor
set noswapfile " disable swap file
set number " show line number
set numberwidth=4 " set line number width
set nowrap " dont wrap lines
set showmatch " show matching braces
set mouse=nicr " enable mouse scrolling

" file completion
" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list,full
set wildmenu

" indent with two spaces
set expandtab
set shiftwidth=2
set softtabstop=2

" match tags
set matchpairs+=<:>
" unix line endings
set ff=unix

"filetype plugin indent on
"set wildignore+=*.zip,node_modules,.git,.svn,bower_components

" open nerdtree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close nerdtree when closing all buffers
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
