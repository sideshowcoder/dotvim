"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC Configuration File                                              "
" philipp.fehre@googlemail.com											                    "
" http://www.sideshowcoder.com											                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autoload bundles and setup spelling
runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
	if has("gui_win32")
    call pathogen#infect()
		set spellfile=~\vimfiles\spellfile.add
	else
    call pathogen#infect()
		set spellfile=~/.vim/spellfile.add
	endif
end

" Language and encoding
set encoding=utf-8
set langmenu=en_US.UTF-8

let maplocalleader = ","
let mapleader = ","
" switch to last open file
nnoremap <leader><leader> <c-^>

" since I hit W instead of w all the time just map it to save as well
command W w
" Spellchecker ,ss
if v:version >= 700
  setlocal spell spelllang=en
  nmap <leader>ss :set spell!<CR>
endif
" off by default
set nospell

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

" interface
" turn off icons in interface
if has("gui_running")
	set guioptions-=T
endif
" set best fonts for system
if has("gui_win32") || has("gui_win32s")
	set guifont=Courier_New:h9
endif
if has("gui_macvim") || has("gui_mac")
	set guifont=Inconsolata:h13
endif
if has("gui_gnome")
	set guifont=Inconsolata\ 10
endif
if has("gui_gtk")
	set guifont=Inconsolata\ 8
endif
" don't blink and whistle
set visualbell
set t_vb=
set noerrorbells
" show something usefull in statusline
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [TYPE=%Y]\ %=[POS=%04l,%04v][%p%%]\ [LEN=%L]
" always show the status line
set laststatus=2
" make the powerline fancy
let g:Powerline_symbols="fancy"

" dont show the scrollbars since they are useless anyway
set guioptions-=L
set guioptions-=r
set guioptions-=T
" highlicht column and lin
set cursorline
set cursorcolumn
" number the lines
set number

" Miscellaneous
" Don't emulate vi
set nocompatible
" auto read on change
set autoread
" No Backupfiles and Swapfiles
set nobackup
set nowritebackup
set noswapfile
" use the Systemclipboard
set clipboard=unnamed
" Command line two lines high
set ch=1
set showmode
" Show current pos
set ruler
" Tabs don't save when switched
set hidden
set history=500
" Ignore Case while searching
set ignorecase
" Mouse behave normal
set mouse=nvi
" Show command completion menu
set wildmenu
set wildmode=list:longest

" Editing
" Syntax highlighting
if &t_Co > 2 || has("gui_running")
	syntax on
	syntax sync fromstart
endif
" Switch on Filetype Behavior
if has("autocmd")
	filetype on
	filetype indent on
	filetype plugin on
endif
" Tabs and backspace
set backspace=2
set autoindent " do indenting auto style
set tabstop=2 " tab spacing (settings below are just to unify it)
set softtabstop=2 " unify
set shiftwidth=2 " unify
set expandtab " use spaces instead of tabs
" Linewrap
set textwidth=0
set wrap
set linebreak
set nolist
" Spelling Languages
set spelllang=de,en
set langmenu=en
" Search while typing
set incsearch
" Show command while typing
set showcmd
" Switch on search pattern highlighting.
set hlsearch
" show matching brackets
set showmatch
" Hide the mouse pointer while typing
set mousehide
" Set nice colors
set t_Co=256
colorscheme zenburn
set background=dark
" always show tabbar
set showtabline=1
" how many tenths of a second to blink matching brackets for
set mat=10
" Window layout and scope
set wiw=100
set winminwidth=60
set so=10
" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Sane regex defaults
" use default "Perl" regex
nnoremap / /\v
vnoremap / /\v
" regex are line global not just the first word
set gdefault
" clear search via ,<space>
nnoremap <leader><space> :noh<cr>

" Costum filetype extensions
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.mdown set filetype=markdown
au BufNewFile,BufRead *.json set filetype=javascript
au BufNewFile,BufRead *.markdown set filetype=markdown
au BufNewFile,BufRead *.ru set filetype=ruby
au BufNewFile,BufRead *.thor set filetype=ruby
au BufNewFile,BufRead Gemfile set filetype=ruby
au BufNewFile,BufRead Vagrantfile set filetype=ruby


" Ctags
" move down tag <C-]> move up tag <C-t>
" retag
nnoremap <leader>rt :!ctags -R .<CR>


" remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" remove trailing whitespace on save
autocmd BufWritePost * :%s/\s\+$//e

" Make coffeescript linter work
let coffee_linter = '/usr/local/bin/coffeelint'

" Run JSHint if there is a jshint.json present in the project
autocmd FileType javascript map <leader>h :call RunJSHint()<cr>

function! RunJSHint(...)
  let to_hint_file = match(expand("%"), '\(.js\)$') != -1
  let options_file = "jshint.json"
  if filereadable(options_file) && to_hint_file
    echo to_hint_file
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    exec ":!jshint --config " . options_file . " " . @%
  end
endfunction

" Commands
nmap <leader>mate :!mate %:p<CR>

" Snippets
iab _pry require "pry"<cr>binding.pry
iab _log console.log(

" Run tests for Ruby and RoR
autocmd FileType ruby map <leader>T :call RunTestFile()<cr>
autocmd FileType ruby map <leader>t :call RunNearestTest()<cr>
autocmd FileType cucumber map <leader>F :w\|:!script/features<cr>
autocmd FileType cucumber map <leader>f :w\|:!script/features --profile wip<cr>
autocmd FileType ruby map <leader>F :w\|:!script/features<cr>
autocmd FileType ruby map <leader>f :w\|:!script/features --profile wip<cr>
autocmd FileType ruby map <leader>a :call RunTests('')<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:current_test_file")
        return
    end
    call RunTests(t:current_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

" Run tests for Node via Jasmin and test script
autocmd FileType javascript map <leader>t :call RunJsTestFile()<cr>
autocmd FileType javascript map <leader>a :call RunTests('')<cr>

function! RunJsTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(\.spec.js\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:current_test_file")
        return
    end
    call RunTests(t:current_test_file . command_suffix)
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:current_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("script/rails_scripts/test")
            exec ":!script/rails_scripts/test " . a:filename
        elseif filereadable("zeus.json")
            exec ":!zeus rspec " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec " . a:filename
        elseif !empty(glob("*.js")) " this is a js project so we try jasmin-node
            exec ":!jasmine-node " . a:filename
        else
            exec ":!rspec " . a:filename
        end
    end
endfunction

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
