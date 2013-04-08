"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC Configuration File                                              "
" philipp.fehre@googlemail.com											                    "
" http://www.sideshowcoder.com											                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autoload bundles and setup spelling
runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
  call pathogen#infect()
  set spellfile=~/.vim/spellfile.add
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
	set guifont=Inconsolata:h13
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
set nospell

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
set spelllang=en,de
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
colorscheme github
set background=light
set nocursorline
set mat=10
set showtabline=1
set wiw=100
set winminwidth=60
set so=10

" Filetypes
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.mdown set filetype=markdown
au BufNewFile,BufRead *.json set filetype=javascript
au BufNewFile,BufRead *.markdown set filetype=markdown
au BufNewFile,BufRead *.ru set filetype=ruby
au BufNewFile,BufRead *.thor set filetype=ruby
au BufNewFile,BufRead Gemfile set filetype=ruby
au BufNewFile,BufRead Vagrantfile set filetype=ruby

" Switch to last open file
nnoremap <leader><leader> <c-^>

" Spellchecker ,ss
if v:version >= 700
  setlocal spell spelllang=en
  nmap <leader>ss :set spell!<CR>
endif

" Smart Tab completion
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" toggle show trailing whitespace
nmap <silent> <leader>s :set nolist!<cr>
set listchars=tab:▸\ ,eol:¬
set list

" Ctags move down tag <C-]> move up tag <C-t>
nmap <leader>rt :!ctags -R .<CR>
nmap <leader>oe :!open -a TextEdit %:p<CR>

" Remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
autocmd BufWritePost * :%s/\s\+$//e

" Ctrl-P
let g:ctrlp_map = '<leader>d'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>. :CtrlPTag<cr>

" Xmpfilter
nmap <buffer> <leader>x <Plug>(xmpfilter-run)
xmap <buffer> <leader>x <Plug>(xmpfilter-run)
imap <buffer> <leader>x <Plug>(xmpfilter-run)
nmap <buffer> <leader>xx <Plug>(xmpfilter-mark)
xmap <buffer> <leader>xx <Plug>(xmpfilter-mark)
imap <buffer> <leader>xx <Plug>(xmpfilter-mark)

" Closetag
:let g:closetag_html_style=1
autocmd Filetype html,xml,eruby source ~/.vim/scripts/closetag.vim

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
