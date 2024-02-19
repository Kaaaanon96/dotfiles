#!/bin/sh

DOT_FILES=( 
  .bash_profile 
  .bashrc 
  .bash_conf
  .gnuplot 
  .vimrc 
  .vim
  .ctags.d
  .gitignore_global
  )

for file in ${DOT_FILES[@]}
do
  if [ -a $HOME/$file ]; then
    if [ -L $HOME/$file ]; then
      echo "既にシンボリックリンクが存在します.: $file"
    elif [ -d $HOME/$file ]; then
      echo "既にディレクトリが存在します. : $file"
    else
      echo "既存ファイルが存在します。: $file"
    fi
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
    echo "シンボリックリンクを張りまして: $file"
  fi
done

git config --global core.excludesfile ~/.gitignore_global
# 全体の流れを見る
git config --global alias.tree 'log --graph --all --format="%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s"'
# 作業中のブランチの流れを見る
git config --global alias.graph 'log --graph --date=format:"%Y/%m/%d %H:%M:%S" --pretty=format:"%x09%Cgreen[%ad] %Creset%C(auto)%h %Creset%C(auto)%d %C(auto)%s  (%Cresetby %C(cyan)%an%Creset)"'

echo "終わり"


