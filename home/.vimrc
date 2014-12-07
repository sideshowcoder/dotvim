" VIMRC Configuration File
" philipp@fehre.co.uk
" http://www.sideshowcoder.com

" Autoload bundles and setup spelling
runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
  call pathogen#infect()
end

" Language and encoding
set encoding=utf-8
set langmenu=en_US.UTF-8

let maplocalleader = ","
let mapleader = ","

" Linewrap Navigation
map j gj
map k gk
" disable the arrow key default behavior
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
" Make arrowkey do something usefull, resize the viewports accordingly
nnoremap <Left> :vertical resize +5<CR>
nnoremap <Right> :vertical resize -5<CR>
nnoremap <Up> :resize +5<CR>
nnoremap <Down> :resize -5<CR>
"
" Split switching made easy
nnoremap <C-J> <C-W>w
nnoremap <C-K> <C-W>W
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
set splitbelow
set splitright

" get rid of the F1 help menu
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" vim like tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" interface
" turn off icons in interface
if has("gui_running")
  set guioptions-=T
endif
" set best fonts for system
if has("gui_macvim") || has("gui_mac")
  set guifont=Inconsolata:h13
endif

" don't blink and whistle
set visualbell
set t_vb=
set noerrorbells
" show something usefull in statusline
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ %=[POS=%04l,%04v][%p%%]\ [LEN=%L]
" always show the status line
set laststatus=2

" dont show the scrollbars since they are useless anyway
set guioptions-=L
set guioptions-=r
set guioptions-=T
" number the lines
set number

" Miscellaneous
set nocompatible
set autoread
set nobackup
set nowritebackup
set noswapfile

" tmux does not use the unnamed clipboard? WTF?
if $TMUX == ''
  set clipboard+=unnamed
endif

set showmode
set ruler
set hidden
set history=500
set ignorecase
set mouse=nvi
set wildmenu
set wildmode=list:longest

" Editing
if &t_Co > 2 || has("gui_running")
  syntax on
  syntax sync fromstart
endif
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif
set backspace=2
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set textwidth=0
set wrap
set linebreak
set nolist
set langmenu=en
set incsearch
set showcmd
set hlsearch
set showmatch
set mousehide
set backspace=indent,eol,start
nnoremap / /\v
vnoremap / /\v
set gdefault
nnoremap <leader><space> :noh<cr>

" Theme
set t_Co=256
set background=dark
colorscheme solarized
set nocursorline
set mat=10
set showtabline=1
set wiw=84
set winminwidth=40
set so=10

" Filetypes
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead todo.txt set filetype=todotxt
au BufNewFile,BufRead *.mdown set filetype=markdown
au BufNewFile,BufRead *.markdown set filetype=markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.txt set filetype=text
au BufNewFile,BufRead *.json set filetype=javascript
au BufNewFile,BufRead *.ru set filetype=ruby
au BufNewFile,BufRead *.god set filetype=ruby
au BufNewFile,BufRead *.thor set filetype=ruby
au BufNewFile,BufRead Gemfile set filetype=ruby
au BufNewFile,BufRead Gruntfile set filetype=javascript
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead Podfile set filetype=ruby
" Erlang filetypes proudly presented by OTP and rebar
au BufNewFile,BufRead *.app.src set filetype=erlang
au BufNewFile,BufRead rebar.conf set filetype=erlang
au BufNewFile,BufRead rebar.config set filetype=erlang
au BufNewFile,BufRead app.config set filetype=erlang

" Switch to last open file
nnoremap <leader><leader> <c-^>

" Make the RVMs work
set shell=/usr/local/bin/zsh

" Spellchecker ,sp
if v:version >= 700
  set spellfile=~/.vim/spellfile.add
  set spelllang=en,de
  setlocal spell spelllang=en_us
  nmap <leader>sp :set spell!<CR>
endif
set nospell

" toggle show whitespace ,w
nmap <silent> <leader>w :set nolist!<cr>
set listchars=tab:▸\ ,eol:¬
set nolist

" Ctags move down tag <C-]> move up tag <C-t>
nmap <leader>rt :!ctags --fields=+l -R .<CR>
set tags+=./tags
nmap <leader>oe :!mvim '%:p'<CR>

" Ctrl-P
let g:ctrlp_map = '<leader>d'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>. :CtrlPTag<cr>

" Xmpfilter
autocmd FileType ruby nmap <buffer> <leader>x <Plug>(xmpfilter-run)
autocmd Filetype ruby xmap <buffer> <leader>x <Plug>(xmpfilter-run)
autocmd Filetype ruby imap <buffer> <leader>x <Plug>(xmpfilter-run)
autocmd Filetype ruby nmap <buffer> <leader>xx <Plug>(xmpfilter-mark)
autocmd Filetype ruby xmap <buffer> <leader>xx <Plug>(xmpfilter-mark)
autocmd Filetype ruby imap <buffer> <leader>xx <Plug>(xmpfilter-mark)


" Text
autocmd Filetype text,markdown set textwidth=80

" Todo
autocmd BufRead todo.txt set filetype=todotxt


" Closetag
:let g:closetag_html_style=1
autocmd Filetype html,xml,eruby source ~/.vim/scripts/closetag.vim

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$', '\.beam$', '\.o$']

" Golang
set rtp+=$GOROOT/misc/vim

" R
let vimrplugin_screenplugin = 0

" rooter
let g:rooter_patterns = ['Rakefile', '.git/', 'Gemfile']
let g:rooter_manual_only = 1

" Custom mappings
map <leader>mt :vsplit ~/Dropbox/todo.txt\|:set filetype=todotxt<cr>
map <leader>rs :source $MYVIMRC<cr>
map <leader>ev :vsplit $MYVIMRC<cr>
" reindet the whole buffer and save position
map <leader>ri :norm mz<cr>gg=G:norm 'z<cr>
map <leader>lt <Plug>TaskList

" highlight long lines
nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
hi OverLength ctermbg=none cterm=none
match OverLength /\%>80v/
fun! s:LongLineHLToggle()
  if !exists('w:longlinehl')
    let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
    echo "Long lines highlighted"
  else
    call matchdelete(w:longlinehl)
    unl w:longlinehl
    echo "Long lines unhighlighted"
  endif
endfunction

" remove trailing whitespace by command or on save
map <leader>fw :FixWhitespace<cr>

" configure dash
nmap <silent> <leader>g <Plug>DashSearch
nmap <silent> <leader>G <Plug>DashGlobalSearch

let g:dash_map = {
      \ 'ruby'       : 'ruby2',
      \ 'javascript' : 'javascript'
      \ }

" configure syntastic
" don't check text files by default since atdtool makes a call to the
" internet which takes a loooong time!
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['markdown', 'text', 'rdoc'] }
let g:syntastic_javascript_checkers = ['jshint']

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
" put compile options in .syntastic_cpp_config or set this variable
"let g:syntastic_cpp_config_file = '.cpp_config'

" change checker
" let g:syntastic_<filetype>_checkers = ['<checker-name>']
" macruby / rubymotion
" let g:syntastic_ruby_checkers = ['macruby']

" use ag instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" gist vim
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1

" supertab
" use context completion to work with eclim (user defined or just complete)
let g:SuperTabDefaultCompletionType = 'context'


" Scratch
nmap <leader>n :Scratch<cr>

"""""""""""""""""""""""""""""""
""" Yammer specifc commands """
"""""""""""""""""""""""""""""""

" run a workfeed test on vagrant from the workfeed directory
nmap <leader>wt :!echo "cd /opt/workfeed && bundle exec ruby %" \| ssh -tt yammer-local-dev<cr>
