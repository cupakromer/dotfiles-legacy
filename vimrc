" Bundles {{{
" Pathogen is required for any of these plugins to work
"=bundle ervandew/ag
"=bundle ervandew/supertab
"=bundle godlygeek/tabular
"=bundle kchmck/vim-coffee-script
"=bundle mattn/gist-vim
"=bundle pangloss/vim-javascript
"=bundle slim-template/vim-slim
"=bundle tpope/vim-bundler
"=bundle tpope/vim-cucumber
"=bundle tpope/vim-endwise
"=bundle tpope/vim-fugitive
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-rails
"=bundle tpope/vim-rake
"=bundle tpope/vim-repeat
"=bundle tpope/vim-surround
"=bundle vim-ruby/vim-ruby
"=bundle rizzatti/funcoo.vim
"=bundle thoughtbot/vim-rspec
"=bundle ecomba/vim-ruby-refactoring
"=bundle kien/ctrlp.vim
"=bundle rizzatti/dash.vim
"=bundle airblade/vim-gitgutter


" Setup Plugins
execute pathogen#infect()

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
set list listchars=tab:»\ ,trail:•,extends:→,precedes:←,nbsp:‗

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

" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"

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

nnoremap Q gqap
vnoremap Q gq

" j and k move by screen lines
nnoremap j gj
nnoremap k gk

"""""""""""""""""""
" Custom Mappings "
"""""""""""""""""""
" Clear highlight
nnoremap <leader><space> <Esc>:noh<CR>

"""""""""""""""""""
" Command Aliases "
"""""""""""""""""""
ca W w
ca WQ wq
ca Wq wq
ca X x      # I never use the encryption command
ca Q q
ca Qa qa
ca QA qa
ca GW Gw

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
