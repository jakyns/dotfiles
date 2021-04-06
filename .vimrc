set nocompatible
filetype off

set rtp+=/opt/homebrew/opt/fzf
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
Plugin 'itchyny/lightline.vim'
Plugin 'mustache/vim-mustache-handlebars'
" Python
Plugin 'vim-scripts/indentpython.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'psf/black'
" Ruby
Plugin 'vim-ruby/vim-ruby'
" Go
Plugin 'fatih/vim-go'
" Elixir
Plugin 'elixir-editors/vim-elixir'
Plugin 'mhinz/vim-mix-format'
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
set tags=./tags;,tags;
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

" lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Python
let python_highlight_all=1
let g:python_host_prog  = '~/.pyenv/shims/python'
let g:python3_host_prog  = '~/.pyenv/shims/python3'
let g:black_virtualenv = '~/.vim/black'

autocmd BufWritePre *.py execute ':Black'

" Ruby
let g:ruby_host_prog = '~/.rbenv/shims/ruby'

" Node.js
let g:node_host_prog = '/opt/homebrew/bin/neovim-node-host'

" Go
let g:go_fmt_command = "goimports"

" Elixir
let g:mix_format_on_save = 1
