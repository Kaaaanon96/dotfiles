# -------------------------------------
# bashのオプション
# -------------------------------------

export EDITOR=vim

#--------------------------------------
#histriyの設定
#--------------------------------------
HISTSIZE=10000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S'

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -u histappend

#--------------------------------------
# 自作スクリプト
#--------------------------------------
export PATH="$HOME/dotfiles/bin:$PATH"

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

# -----------------------------------
# プロンプト
# -----------------------------------

source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
export PS1="\u@\h:\W\$(__git_ps1)$ "


# -----------------------------------
# bat
# -----------------------------------
export BAT_THEME="TwoDark"

# -----------------------------------
# fzf
# -----------------------------------
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore'
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--reverse
--height=20
--bind ctrl-n:page-down,ctrl-p:page-up
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash

    # fd - cd to selected directory
    fd() {
      local dir
      dir=$(find ${1:-.} -path '*/\.*' -prune \
                      -o -type d -print 2> /dev/null | fzf +m) &&
      cd "$dir"
    }

    # fda - including hidden directories
    fda() {
      local dir
      dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
    }
fi




