# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# User specific environment and startup programs
PYENV_ROOT=~/.pyenv
RBENV_ROOT=~/.rbenv

export PATH=$PATH:$PYENV_ROOT/bin
export PATH=$PATH:$RBENV_ROOT/bin
export PATH=$PATH:$HOME/.ndenv/bin

eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(ndenv init -)"

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/mariadb@10.1/bin:$PATH"

