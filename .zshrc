# brew
export PATH=/opt/homebrew/bin:$PATH

# zsh
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true

plugins=(git rails django)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

# os
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8

# default editor
alias vi=nvim
alias vim=nvim
export EDITOR=/opt/homebrew/bin/nvim

# enable tmux color scheme
export TERM=screen-256color

# fzf
export FZF_DEFAULT_COMMAND='ag --hidden -lg ""'

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# python
alias python=python3
alias pip=pip3

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pipenv
eval "$(pipenv --completion)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# golang
export GOPATH="$HOME/Sites/go"
export PATH="$PATH:$GOPATH/bin"

# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

autoload -U add-zsh-hook

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# kubectl_aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
kubectl() { echo "+ kubectl $@">&2; command kubectl $@; }

# watch
watch () {
  while true
  do
    $@
    fswatch -1r .
    clear
    sleep 1
  done
}
