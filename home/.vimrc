"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC Configuration File                                              "
" philipp.fehre@googlemail.com											                    "
" http://www.sideshowcoder.com											                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Split switching made easy
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright


" get rid of the F1 help menu
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" interface
" turn off icons in interface
if has("gui_running")
  set guioptions-=T
endif
" set best fonts for system
if has("gui_macvim") || has("gui_mac")
  set guifont=Inconsolata:h14
endif

" don't blink and whistle
set visualbell
set t_vb=
set noerrorbells
" show something usefull in statusline
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [TYPE=%Y]\ %=[POS=%04l,%04v][%p%%]\ [LEN=%L]
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
set clipboard=unnamed
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
au BufNewFile,BufRead *.thor set filetype=ruby
au BufNewFile,BufRead Gemfile set filetype=ruby
au BufNewFile,BufRead Gruntfile set filetype=javascript
au BufNewFile,BufRead Vagrantfile set filetype=ruby

" Switch to last open file
nnoremap <leader><leader> <c-^>

" Spellchecker ,ss
if v:version >= 700
  set spellfile=~/.vim/spellfile.add
  set spelllang=en,de
  setlocal spell spelllang=en
  nmap <leader>ss :set spell!<CR>
endif
set nospell

" toggle show whitespace
nmap <silent> <leader>s :set nolist!<cr>
set listchars=tab:▸\ ,eol:¬
set nolist

" Ctags move down tag <C-]> move up tag <C-t>
nmap <leader>rt :!ctags *<CR>
nmap <leader>oe :!mate %:p<CR>

" Move to directoy of current active file
"autocmd BufEnter * silent! lcd %:p:h

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
let NERDTreeIgnore = ['\.pyc$', '\.beam$']

" Golang
set rtp+=$GOROOT/misc/vim

" R
let vimrplugin_screenplugin = 0

" rooter
let g:rooter_patterns = ['Rakefile', '.git/', 'Gemfile']
let g:rooter_manual_only = 1

" Custom mappings
map <leader>mn :vsplit ~/Dropbox/Notes/scratch.txt<cr>
map <leader>mt :vsplit ~/Dropbox/todo.txt\|:set filetype=todotxt<cr>
map <leader>rs :source $MYVIMRC<cr>
map <leader>ev :vsplit $MYVIMRC<cr>
map <leader>oe :!open -a TextEdit %<cr>
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
autocmd BufWritePre * :FixWhitespace

