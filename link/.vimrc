execute pathogen#infect()

syntax on
filetype plugin indent on

colorscheme wombat 

set noswapfile " disable swap file
set exrc " enable per-directory .vimrc files
set number " show line number
set numberwidth=4 " line number width
set nowrap " dont wrap lines
set showmatch " show matching braces
set nocompatible " no need to be 100% vi compatible
set mouse=nicr " enable mouse scrolling

function Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction
