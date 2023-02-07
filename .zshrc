# brew
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# zsh
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true

plugins=(git rails)

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

# asdf
. $HOME/.asdf/asdf.sh

# python
alias python=python3
alias pip=pip3

export PIPENV_VENV_IN_PROJECT=1

# golang
export GOPATH="$HOME/Sites/go"
export PATH="$PATH:$GOPATH/bin"

# kubectl_aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
kubectl() { echo "+ kubectl $@">&2; command kubectl $@; }

# gcloud
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

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
