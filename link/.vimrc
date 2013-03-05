set cindent
set smartindent
set autoindent

set expandtab " convert tabs to 2 spaces"
set tabstop=2 
set shiftwidth=2
set cinkeys=0{,0},:,0#,!^F

set nocompatible " no need to be 100% vi compatible
set ruler " show ruler on the botton
set number " show line number
set numberwidth=4 " line number width
set showcmd " show some useful info in the ruler
set nowrap " dont wrap lines
set showmatch " show matching braces
set autoindent " enable automatic indentation

set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

colorscheme wombat " choose color scheme
syntax on " enable syntax highlighting

if expand('%:t') =~?'bash-fc-\d\+'
  setfiletype sh
endif

" @Florian Rivoal
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
