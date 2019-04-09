set nocompatible
filetype off

set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'rking/ag.vim'
Plugin 'morhetz/gruvbox'
Plugin 'tmhedberg/SimpylFold'
Plugin 'junegunn/fzf.vim'
" Python
Plugin 'vim-scripts/indentpython.vim'
Plugin 'davidhalter/jedi-vim'
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

" fzf
nnoremap <silent> <C-p> :FZF<CR>

" SimpylFold
set foldlevelstart=99
set foldmethod=indent
let g:SimpylFold_docstring_preview = 1

" Python
let python_highlight_all=1
let g:python_host_prog  = '~/.pyenv/shims/python'
let g:python3_host_prog  = '~/.pyenv/shims/python3'

" Ruby
let g:ruby_host_prog = '~/.rbenv/shims/ruby'

" Node.js
let g:node_host_prog = '/usr/local/bin/node'

" Go
let g:go_fmt_command = "goimports"

