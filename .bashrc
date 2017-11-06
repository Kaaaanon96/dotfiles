# -------------------------------------
# bashのオプション
# -------------------------------------

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

# -----------------------------------
# プロンプト
# -----------------------------------

export PS1="\u@\h:\W\$ "


