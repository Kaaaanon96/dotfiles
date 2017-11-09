"# Author      : Kanon
"# Since       : 2017/02/09
"# LadtUpdate  : 2017/11/09

set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

"##################################
"ファイルタイプ・プラグイン無効化
"##################################

filetype off
filetype plugin indent off

"###############
"ファイル設定
"###############

set nobackup            " バックアップファイルを作らない
set noswapfile          " スワップファイルを作らない
set autoread            " 編集中のファイルが変更されたら自動再読込
set hidden              " バッファが編集中でもその他のファイルを開けるように

"################
"表示設定
"################

set number              " 行番号
set cursorline          " 行の強調表示
set title               " 編集中のファイル名を表示
set showmatch           " 括弧入力時の対応する括弧を表示
set ruler               " 括弧の位置を表示
"set showcmd             " コマンド表示
set noshowmode          " コマンドを表示しない
set pumheight=10        " 補完メニューの高さ
set nowrap              " 画面端改行:無効
set scrolloff=7         " 余裕を持ってスクロール
set visualbell          " ビープ音を可視化
set virtualedit=onemore " 行末の1文字先までカーソル
set laststatus=2        " ステータスラインを常に表示

"####################
"カラースキーム
"###################

syntax on
color dracula

"#########################
"タブ/インデント設定
"#########################

source ~/dotfiles/.vimrc.indent " 外部ファイル読み込み

"################
"検索設定
"################

set ignorecase          " 大文字/小文字の区別をなく検索
set smartcase           " 検索文字列に大文字が含まれている場合は区別
set wrapscan            " 検索時に最後まで行ったら最初に戻る
set hlsearch            " 検索結果をハイライト

"############################
"コマンドラインモード
"############################

set wildmenu
set wildmode=longest:full,full
set history=5000


"############################
"入力設定
"############################

set backspace=indent,eol,start  " バックスペースの有効化
set clipboard+=unnamed          " クリップボードを共通に
set timeout timeoutlen=1000 ttimeoutlen=75

noremap Y y$

"############################
"dein設定
"############################

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,       {'lazy': 0})
  call dein#load_toml(s:lazy_toml,  {'lazy': 1})

  " 設定完了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールのものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"#################################
"インデント・プラグイン on
"#################################

filetype plugin indent on

"################################
"ぷらぎん関係の設定
"################################

" lightlineの設定
let g:lightline = {
  \ 'colorscheme': 'Dracula'
  \ }





