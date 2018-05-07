## dotfiles

****

- 中身
	- .bash_profile
	- .bashrc
	- .gnuplot
	- .vimrc
  - .vimrc.indent
  - .vim
  - Brewfile
 

setup.shでシンボリックリンクはるかんじで

## 手動で必要な作業

- Brewfileを用いたhomebrew環境の復元
  - `brew tap Homebrew/bundle`
  - `brew bundle`

- deopleteの設定
  - `pip3 install neovim`
    - PATHが通ってなくてエラーを吐く時がある

- vim-go
  - `:GoInstallBinaries`

- deoplete-go
  - `go get -u github.com/nsf/gocode`

- deoplete-solargraph
  - Install
    - `gem install solargraph`
    - `pip install solargraph-utils.py --user`
  - setup
    - `yard gems `
    - `yard config --gem-install-yri`

- vimproc
  - buildした結果が標準と違う場所に入る。
  - `~/.cache/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_mac.so`
  - 今のdotfiles設定でmacに入れると上記の場所。
  - 他の環境に入れた場合は場所を確認してvimrcを変更

- プラグイン設定を変更した時
  - `call map(dein#check_clean(), "delete(v:val, 'rf')")`
  - `call dein#recache_runtimepath()`


#### メモ

`on_i`は非推奨らしいので`on_event = 'InsertEnter'`を使う

