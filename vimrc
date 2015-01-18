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
"=bundle tpope/vim-dispatch
"=bundle tpope/vim-endwise
"=bundle tpope/vim-fugitive
"=bundle tpope/vim-markdown
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-projectionist
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
"=bundle wikitopian/hardmode
"=bundle hwartig/vim-seeing-is-believing
"=bundle jgdavey/tslime.vim
"=bundle jgdavey/vim-blockle
"=bundle AndrewRadev/switch.vim
"=bundle therubymug/vim-pyte
"=bundle scrooloose/syntastic
"=bundle airblade/vim-gitgutter
"=bundle emilsoman/spec-outline.vim
"=bundle rizzatti/dash.vim

" Setup Plugins
call pathogen#infect()
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Configure syntastic
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" Global settings for all files
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

syntax on

set ruler
set number
set clipboard=unnamed

" Set encoding
set encoding=utf-8

" Set Spell Check
au BufRead,BufNewFile *.md,*.markdown setlocal spell
au FileType gitcommit setlocal spell

" Better command-line completion
set complete=.,b,u,]
set wildmenu
set wildmode=longest,list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Show partial commands in the last line of the screen
set showcmd

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Set color scheme
"let base16colorspace=256
set background=dark
colorscheme base16-tomorrow
"colorscheme spacemanspiff

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

""""""""""""""""""""""
" RSpec Dispatch     "
""""""""""""""""""""""
"let g:rspec_command = 'Dispatch rspec {spec}'

""""""""""""""""""""""
" RSpec TSlime       "
""""""""""""""""""""""
"let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

""""""""""""""""""""""
" Rspec.vim mappings "
""""""""""""""""""""""
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

""""""""""""""""""""""""""
" Cucumber Test mappings "
""""""""""""""""""""""""""
"map <Leader>c :call Send_to_Tmux("cucumber --format progress\n")<CR>
"map <Leader>w :call Send_to_Tmux("cucumber --format progress -p wip\n")<CR>
"map <Leader>c :Dispatch cucumber --format progress<CR>
"map <Leader>w :Dispatch cucumber --format progress -p wip<CR>

"""""""""""""""""""
" Switch mappings "
"""""""""""""""""""
nnoremap - :Switch<cr>

"""""""""""""""""""
" Custom Mappings "
"""""""""""""""""""
" Clear highlight
nnoremap <leader><space> <Esc>:noh<CR>

" Toggle Hard Mode
"nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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
autocmd BufNewFile,BufRead *.thor set filetype=ruby

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Integrate with TMUX to allow for vim navigation
" if exists('$TMUX')
"   function! TmuxOrSplitSwitch(wincmd, tmuxdir)
"     let previous_winnr = winnr()
"     execute "wincmd " . a:wincmd
"     if previous_winnr == winnr()
"       " The sleep and & gives time to get back to vim so tmux's focus tracking
"       " can kick in and send us our ^[[O
"       execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
"       redraw!
"     endif
"   endfunction
"   let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
"   let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
"   let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
"   nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
"   nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
"   nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
"   nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
" else
"   map <C-h> <C-w>h
"   map <C-j> <C-w>j
"   map <C-k> <C-w>k
"   map <C-l> <C-w>l
" endif

" :RL <regexp> will now remove all matched lines in a file
" Thanks go to http://trevmex.com/post/62725003513/my-first-viml-command-rl
function! RemoveLine(regexp)
    exe '%s,^.*' . a:regexp . '.*$\n,,g'
endfunction
command! -nargs=1 RL call RemoveLine(<f-args>)


" Seeing is believing Plugin for Ruby Execution
nmap <buffer> <M-r> <Plug>(seeing-is-believing-run)
xmap <buffer> <M-r> <Plug>(seeing-is-believing-run)
imap <buffer> <M-r> <Plug>(seeing-is-believing-run)

nmap <buffer> <M-m> <Plug>(seeing-is-believing-mark)
xmap <buffer> <M-m> <Plug>(seeing-is-believing-mark)
imap <buffer> <M-m> <Plug>(seeing-is-believing-mark)

nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
xmap <buffer> <F5> <Plug>(seeing-is-believing-run)
imap <buffer> <F5> <Plug>(seeing-is-believing-run)

nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
imap <buffer> <F4> <Plug>(seeing-is-believing-mark)
