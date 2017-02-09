# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# User specific environment and startup programs
PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

