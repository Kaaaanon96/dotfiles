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

eval "$(pyenv init -)"
eval "$(rbenv init -)"

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
