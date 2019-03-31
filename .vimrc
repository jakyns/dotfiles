set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'rking/ag.vim'
Plugin 'morhetz/gruvbox'
Plugin 'tmhedberg/SimpylFold'
" Python
Plugin 'vim-scripts/indentpython.vim'
" Go
Plugin 'fatih/vim-go'
" Elixir
Plugin 'elixir-editors/vim-elixir'
call vundle#end()

syntax on
filetype on
filetype indent on
filetype plugin on

set encoding=utf-8
set clipboard=unnamed
set background=dark
colorscheme gruvbox

set nowrap
set textwidth=80                    " Margin enforcement
set colorcolumn=+1                  " Margin guide
set backspace=indent,eol,start      " Backspace over everything

" Editing
set number                          " Show lines numbers
set cul                             " Highlight current line for active window
set autoread                        " Check one time after 4s of inactivity in normal mode
set timeoutlen=1000
set ttimeoutlen=0
au CursorHold * checktime

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" Nerdtree
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeNodeDelimiter = "\u00a0"
map <C-l> :NERDTreeToggle<CR>

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 0

" SimpylFold
set foldlevelstart=99
set foldmethod=indent
let g:SimpylFold_docstring_preview = 1

" Python
let python_highlight_all=1

" Go
let g:go_fmt_command = "goimports"

