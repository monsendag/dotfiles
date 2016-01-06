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
  Plug 'matze/vim-move'
  Plug 'terryma/vim-smooth-scroll'
call plug#end()


filetype plugin indent on " load indent file for specific filetypes

syntax enable " enable syntax highlighting
colorscheme onedark

" The 'scrolloff' (scroll offset) option determines 
" the number of context lines you would like to see above and below the cursor
set scrolloff=3

set autoindent " automatically keep indentation

set showmode " show the current mode (NORMAL/INSERT)

" see :help shocmd 
set showcmd

set hidden

" file completion
" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
" try :color <tab> 
set wildmode=longest,list,full
set wildmenu

set visualbell " visual instead of audio bell
set cursorline " show line below cursor

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set laststatus=2 " Always show statusline
set noswapfile " disable swap file
set number " show line number
set numberwidth=4 " set line number width
set nowrap " dont wrap lines
set mouse=nicr " enable mouse scrolling

set ruler " show ruler
set ttyfast " fast terminal mode (sends more characters)
set relativenumber " show relative numbers in margin (useful for navigating with j/k)


let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
" http://stackoverflow.com/a/22676189
let myUndoDir = expand(vimDir . '/undo')
call system('mkdir ' . myUndoDir)
let &undodir = myUndoDir
set undofile

" indent with tab character by default
" http://lea.verou.me/2012/01/why-tabs-are-clearly-superior/
set expandtab
set shiftwidth=2
set softtabstop=2

" match tags
set matchpairs+=<:>
" unix line endings
set ff=unix

nnoremap / /\v
vnoremap / /\v

" find & replace options
set ignorecase " ignore case by default
set smartcase " dont ignore case if we have both lower and upper in a search
set gdefault " do substitutions globally by default

" incsearch, showmatch and hlsearch work together to highlight search results (as you type).
" It’s really quite handy, as long as you have the next line as well
set incsearch
set showmatch
set hlsearch

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=120


" save on losing focus
au FocusLost * :wa

set timeoutlen=1000 ttimeoutlen=-1 " ensure we don't need to double click esc
set esckeys timeout nottimeout

:autocmd InsertEnter * set timeoutlen=200
:autocmd InsertLeave * set timeoutlen=1000


"filetype plugin indent on
"set wildignore+=*.zip,node_modules,.git,.svn,bower_components

" jj : exit insert mode 
:imap jj <Esc>

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


" move in display lines instead of physical lines
nnoremap j gj
nnoremap k gk

" map , to :
nnoremap , :

" Visual mode: expand/shrink selected region 
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Normal mode

"Hit Enter to go to end of file
nnoremap <CR> G

"Hit Backspace to go to beginning of file.
nnoremap <BS> gg

" ========================================================================
" <Leader> : <Space>
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"

" Space+ev - edit vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Space+wq = write quit
nmap <leader>wq :wq<CR>

" Space+p/P Space+y/Y - system clipboard shortcuts
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" space+L = toggle nerdTree
nnoremap <leader>l :NERDTreeToggle<CR>

" Space+w - vertical split
nnoremap <leader>v <C-w>v<C-w>l

" Space+o - open a new file with ctrlP fuzzy search 
nnoremap <Leader>o :CtrlP<CR> 

" Space+w - save file
nnoremap <Leader>w :w<CR> 

" Space+rl - reload vimrc
nmap <Leader>rv :source $MYVIMRC<CR>


" =======================================================================
" Plugin configuration

" terryma/vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" bling/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

" ctrlpvim/ctrlp.vim 
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

" scrooloose/nerdtree 
" close nerdtree when closing all buffers
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Ctrl+n : open NerdTree file browser
map <C-n> :NERDTreeToggle<CR>

