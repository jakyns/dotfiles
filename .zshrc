# zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git rails)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# os
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8

# default editor
export EDITOR=/usr/bin/vim

# enable tmux color scheme
export TERM=screen-256color

# fzf
export FZF_DEFAULT_COMMAND='ag --hidden -lg ""'

# sublime text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

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
export GO111MODULE=on

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

# stats
function stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep --color=auto -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

