# -------------------------------------
# bashのオプション
# -------------------------------------

export EDITOR=vim

#--------------------------------------
#histriyの設定
#--------------------------------------
HISTSIZE=10000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S'

# -------------------------------------
# エイリアス
# -------------------------------------

alias la='ls -aG'
alias ll='ls -alG'
alias grep='grep -G'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias df='df -h'
alias relogin='exec -l $SHELL'
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
alias ctags="`brew --prefix`/bin/ctags"
alias phptags="ctags -R --languages=PHP -f ./php.tags "
alias rubytags="ctags -R --languages=RUBY --exclude='*.js' -f ./ruby.tags"
alias gemtags="ctags -R --languages=RUBY --exclude='*.js' -f ./gemlock.tags . $(bundle list --paths)"

# -----------------------------------
# プロンプト
# -----------------------------------

source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
export PS1="\u@\h:\W\$(__git_ps1)$ "


# -----------------------------------
# phpbrew
# -----------------------------------

source $HOME/.phpbrew/bashrc

