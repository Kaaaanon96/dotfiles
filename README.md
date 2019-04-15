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

dark poweredなプラグイン周りで更新の必要があるっぽいけどできてない。

## terminal用background image

`svn export https://github.com/LazoCoder/Pokemon-Terminal/trunk/pokemonterminal/Images`

## 手動で必要な作業

- Brewfileを用いたhomebrew環境の復元
  - `brew tap Homebrew/bundle`
  - `brew bundle`

- deopleteの設定
  - `pip3 install neovim`
  - `pip3 install --user pynvim`
    - pyenvで環境作ってるとうまくいかんかも

- vim-go
  - `:GoInstallBinaries`
  - `https://github.com/stamblerre/gocode`

- golspを使う
  - `go get -u golang.org/x/tools/cmd/golsp`

- solargraph
  - rbenv等を使っている場合使用するversionでそれぞれ入れる
    - いい感じに1つで済ませたい
  - Install
    - `gem install solargraph`
  - setup
    - `yard gems `
    - `yard config --gem-install-yri`

- (php-intelephense)[https://www.npmjs.com/package/intelephense]
  - `npm i intelephense -g`
  - 内部のlspの呼び出しが環境依存でイケてないのでどうにかする

- vimproc
  - buildした結果が標準と違う場所に入る。
  - `~/.cache/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_mac.so`
  - 今のdotfiles設定でmacに入れると上記の場所。
  - 他の環境に入れた場合は場所を確認してvimrcを変更

- プラグイン設定を変更した時
  - `call map(dein#check_clean(), "delete(v:val, 'rf')")`
  - `call dein#recache_runtimepath()`

#### todo

golang, ruby, python, phpあたりの導入の自動化


tomlのhook系が適当すぎるのでちゃんと調べて修正
