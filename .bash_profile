# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi

if [ -f ~/.bash_conf/env_profile.bash ] ; then
    . ~/.bash_conf/env_profile.bash
fi

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
