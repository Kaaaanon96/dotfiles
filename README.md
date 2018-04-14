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
  - previewが別windowで開くようになった時
    - `set completeopt-=preview`を設定に足す
      - このvimrcには追加済み

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

- airline
  - `.vim/autoload/airline/themes/dracula.vim`
    - 上記のファイルをairlineのthemeディレクトリの中に

- プラグイン設定を変更した時
  - `call map(dein#check_clean(), "delete(v:val, 'rf')")`
  - `call dein#recache_runtimepath()`


#### メモ

`on_i`は非推奨らしいので`on_event = 'InsertEnter'`を使う


