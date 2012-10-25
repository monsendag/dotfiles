set noexpandtab "don't convert tabs to spaces
set tabstop=4 " make \t 4 characters wide
set shiftwidth=4 " make indentation shift single tab

set nocompatible " no need to be 100% vi compatible
set ruler " show ruler on the botton
set number " show line number
set numberwidth=4 " line number width
set showcmd " show some useful info in the ruler
set nowrap " dont wrap lines
set showmatch " show matching braces
set autoindent " enable automatic indentation

colorscheme graywh " choose color scheme
syntax on " enable syntax highlighting

if expand('%:t') =~?'bash-fc-\d\+'
  setfiletype sh
endif

" @Florian Rivoal
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
