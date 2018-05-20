# zsh
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(zsh-autosuggestions git rails)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# sublime text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# pipenv
eval "$(pipenv --completion)"

# golang
export GOPATH="$HOME/Sites/go"
export PATH="$PATH:$GOPATH/bin"

# os
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=/usr/bin/vim
