set encoding=utf-8      " use UTF-8 encoding
set nocompatible        " be iMproved

call plug#begin()
  Plug 'bling/vim-airline'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'kien/ctrlp.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'elzr/vim-json'
call plug#end()

set laststatus=2 " Always show statusline

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set timeoutlen=1000 ttimeoutlen=0 " ensure we don't need to double click esc

filetype plugin indent on " load indent file for specific filetypes

syntax enable " enable syntax highlighting
colorscheme atom-dark-256


set cursorline " show line below cursor
set noswapfile " disable swap file
set number " show line number
set numberwidth=4 " set line number width
set nowrap " dont wrap lines
set showmatch " show matching braces
set mouse=nicr " enable mouse scrolling

set wildignore+=*.zip,node_modules,.git,.svn,bower_components

" open nerdtree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" close nerdtree when closing all buffers
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
