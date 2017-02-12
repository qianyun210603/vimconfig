" Use vundle to manage plugin, required turn file type off and nocompatible
filetype off
set nocompatible
set rtp+=/etc/vim/bundle/vundle
call vundle#rc(expand('/etc/vim/bundle'))
" Let vundle manage vundle, required
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'

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
