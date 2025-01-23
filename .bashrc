
export EDITOR=vim
export ENV_PROFILE="$HOME/dotfiles/.bash_conf/env_profile.bash"
export PATH="$HOME/dotfiles/bin:$PATH"  #自作スクリプト
export BASH_SILENCE_DEPRECATION_WARNING=1   #macのzshの警告を非表示に

#--------------------------------------------

HISTSIZE=10000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S'

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -u histappend

#--------------------------------------------

alias la='ls -aG'
alias ll='ls -alG'
alias grep='grep -G'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias df='df -h'
alias relogin='exec -l $SHELL'
alias ctags="`brew --prefix`/bin/ctags"
alias phptags="ctags -R --languages=PHP -f ./php.tags "
alias rubytags="ctags -R --languages=RUBY --exclude='*.js' -f ./ruby.tags"

#--------------------------------------------

source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
export PS1="\u@\h:\W\$(__git_ps1)$ "


#--------------------------------------------

export BAT_THEME="Visual Studio Dark+"
export BAT_STYLE="header,numbers"

#--------------------------------------------

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

    # fgs - fzf git switch
    fgs() {
        local branch
        branch=$(git branch | sed 's/^.* //g' | fzf +m --ansi --preview "git log {} --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" --preview-window "right,70%")
        git switch $branch
    }

    # `git checkout **<TAB>`の様にgitコマンド内で`**<TAB>`でブランチ名での補完ができるようになる
    _fzf_complete_git_branch() {
      _fzf_complete +m --prompt="git branch> " \
          --preview "git log {} --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" \
          --preview-window "right,70%" -- "$@" < <(git branch | sed 's/^.* //g')
    }

    [ -n "$BASH" ] && complete -F _fzf_complete_git_branch -o bashdefault -o default -o nospace git
fi

