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

eval "$(pyenv init --path)"
eval "$(rbenv init -)"
eval "$(nodenv init -)"


export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PATH="/usr/local/opt/mariadb@10.3/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/mariadb@10.3/lib"
export CPPFLAGS="-I/usr/local/opt/mariadb@10.3/include"

# react native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# brew
export HOMEBREW_NO_AUTO_UPDATE=1


