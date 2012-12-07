" Setup Plugins
call pathogen#infect()

" Global settings for all files
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

syntax on

set spell
set ruler
set number
set clipboard=unnamed

" Set encoding
set encoding=utf-8

" Better command-line completion
" set wildmenu
" set wildmode=list:longest,list:full
" set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Show partial commands in the last line of the screen
set showcmd

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Set color scheme
"let base16colorspace=256
set background=dark
colorscheme base16-tomorrow

" Whitespace config
set shiftwidth=2 softtabstop=2 tabstop=2
set expandtab
set smarttab
set autoindent
set wrap
set list listchars=tab:\ \ ,trail:·

" Code Folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Add Column Limit highlight
if exists('+colorcolumn')
  set colorcolumn=80
else
  match ErrorMsg '\%>80v.\+'
endif
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"""""""""""""""
" Key Mapings "
"""""""""""""""
set timeoutlen=500
nnoremap ,b :ls<CR>:buffer<Space>

"""""""""""""""""""
" Command Aliases "
"""""""""""""""""""
ca W w
ca WQ wq
ca Wq wq
ca Q q

""""""""""""""""""""
" Custom Functions "
""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
  " Prep: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Remove whitespace
  %s/\s\+$//e
  " Restore search and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
