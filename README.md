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

- deolete-rct
  - `gem install rcodetools`

- airline
  - `.vim/autoload/airline/themes/dracula.vim`
    - 上記のファイルをairlineのthemeディレクトリの中に
