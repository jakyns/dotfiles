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
Plugin 'morhetz/gruvbox'
Plugin 'elixir-editors/vim-elixir'
call vundle#end()

colorscheme gruvbox

" Nerdtree
let NERDTreeShowHidden=1
map <C-l> :NERDTreeToggle<CR>

" CtrlP
let g:ctrlp_show_hidden = 1

set nowrap
set textwidth=80                    " Margin enforcement
set colorcolumn=+1                  " Margin guide
set backspace=indent,eol,start      " Backspace over everything

" Editing
set number                          " Show lines numbers
set cul                             " Highlight current line for active window
set autoread                        " Check one time after 4s of inactivity in normal mode
au CursorHold * checktime

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

syntax on
filetype on
filetype indent on
filetype plugin on

let g:go_fmt_command = "goimports"
