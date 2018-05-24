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
Plugin 'fatih/vim-go'
Plugin 'rking/ag.vim'

call vundle#end()

" Nerdtree
map <C-l> :NERDTreeToggle<CR>

set nowrap
set textwidth=70                    " Margin enforcement
set colorcolumn=+1                  " Margin guide
set backspace=indent,eol,start      " Backspace over everything

" Editing
set number                          " Show lines numbers
set cul                             " Highlight current line for active window

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" Windows resizing
nnoremap rhh :vertical resize -10<cr>
nnoremap rjj :resize +10<cr>
nnoremap rkk :resize -10<cr>
nnoremap rll :vertical resize +10<cr>

syntax on
filetype on
filetype indent on
filetype plugin on

let g:go_fmt_command = "goimports"
