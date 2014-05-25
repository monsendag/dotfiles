set encoding=utf-8      " use UTF-8 encoding
set nocompatible        " be iMproved
filetype off            " required for vundle

" enable vundle package manager
set rtp+=~/.vim/bundle/vundle/
call vundle#begin('$HOME/.vundle')

" let Vundle manage Vundle
Bundle 'gmarik/Vundle.vim'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()            

filetype plugin indent on " load indent file for specific filetypes
syntax on " enable syntax highlighting

colorscheme wombat " set theme 

set cursorline " show line below cursor
set noswapfile " disable swap file
set exrc " enable per-directory .vimrc files
set number " show line number
set numberwidth=4 " set line number width
set nowrap " dont wrap lines
set showmatch " show matching braces
set mouse=nicr " enable mouse scrolling

