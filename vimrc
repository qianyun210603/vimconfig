" Use vundle to manage plugin, required turn file type off and nocompatible
filetype off
set nocompatible
set rtp+=/etc/vim/bundle/vundle
call vundle#rc(expand('/etc/vim/bundle'))
" Let vundle manage vundle, required
Bundle 'gmarik/vundle'
" for auto completion
Bundle 'Valloric/YouCompleteMe'
" show tree-style folder structure
Bundle 'scrooloose/nerdtree'
" syntax check
Bundle 'scrooloose/syntastic'



" Brief help of vundle
    ":BundleList
    ":BundleInstall
    ":BundleSearch
    ":BundleClean
    ":help vundle
" End Brief help

syntax on                   " syntax highlight on
set cursorline              " highlight current line
set number                  " show line number
set ruler
set showcmd
set showmode
set laststatus=2
set cmdheight=1
set scrolloff=3

" fill space between windows
" set fillchars=stl:\ ,stlnc:\ ,vert;\

" Tab and indent
set cindent
set shiftwidth=4
set tabstop=4               " <tab> length is four spaces
set softtabstop=4
set expandtab               " replace <tab> with four spaces
set autoindent              " apply indent of previous line
set smartindent             " smart indent

" Search related
set showmatch
set ignorecase smartcase    " ignore case when search, but keep case sensitive when the word have one upper case
set nowrapscan              " no wrap scan
set incsearch               " dynamically show search result
set hlsearch                " highlight when search
set magic                   " enable Data Link Escape Character cancellation

" Close annoying error message
set noerrorbells            " close error bell
set novisualbell            " close visual bell
set t_vb=                   " empty bell

" Configure backspace to be able to across two lines
set backspace=2
set whichwrap+=<,>,h,l

" Files, backups and encoding
set nobackup
set noswapfile
set autoread                " automatically update file when changed outsidely
set autowrite               " automatically write to disk when changed
set fileencodings=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936
set fileencoding=utf-8
set fileformats=unix,dos,mac

filetype plugin on
filetype indent on

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_global_ycm_extra_conf = '/etc/vim/extra_configs/ycm_extra_conf.py'
"Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
" let g:syntastic_always_populate_loc_list = 1
"

set shortmess=atI   " remove advertisement  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   " content in status bar


" press F5 key for compile and run
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc


" automatically insert file header for c, cpp, shell, ruby, java and python 
func InsertHeader()
    " move to the beginning to the file
    normal gg
	if &filetype == 'sh' 
		call append(0, "\#!/bin/bash") 
		call append(1, "") 
    elseif &filetype == 'python'
        call append(0, "#!/usr/bin/env python")
        call append(1, "# coding=utf-8")
	    call append(2, "") 

    elseif &filetype == 'ruby'
        call append(0,"#!/usr/bin/env ruby")
        call append(1,"# encoding: utf-8")
	    call append(2, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else 
		call append(0, "/*************************************************************************") 
		call append(1, "	> File Name: ".expand("%")) 
		call append(2, "	> Author: ") 
		call append(3, "	> Mail: ") 
		call append(4, "	> Created Time: ".strftime("%c")) 
		call append(5, " ************************************************************************/") 
		call append(6, "")
	endif
	if expand("%:e") == 'h' || expand("%:e") == 'hpp' || expand("%:e") == 'hh'
		call append(7, "#ifndef _".toupper(expand("%:t:r"))."_".toupper(expand("%:e")))
		call append(8, "#define _".toupper(expand("%:t:r"))."_".toupper(expand("%:e")))
		call append(9, "")
        normal G
		call append(line("."), "")
		call append(line(".")+1, "")
		call append(line(".")+2, "#endif")
	endif
	if &filetype == 'java'
		call append(7, "public class ".expand("%:r"))
		call append(8, "")
	endif
endfunc
command InsertHeader :call InsertHeader()


" mouse behavior
set mousemodel=popup
set mouse=a

" popup confirm when exit without saving or editing read-only file
set confirm

" NERD Tree setup -- a tree like file/folder hierarchy visualization tool
autocmd vimenter * if !argc() | NERDTree | endif " if vim opened without file, show nerd tree for current folder
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if nerd tree is the only window left
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc', '\.o']


" Ctrl + C = copy
" TODO vmap <C-c> "+y

" Ctrl + W switch between windows
map <C-w> <C-w>w

" code folding
autocmd FileType cpp set foldmethod=syntax
autocmd FileType python set foldmethod=expr
set nofoldenable

" syntastic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" pylint setup
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_pylint_args='--disable=C0111,R0903,C0301'
