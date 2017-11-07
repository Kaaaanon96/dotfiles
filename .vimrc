"# Author      : Kanon
"# Since       : 2017/02/09
"# LadtUpdate  : 2017/04/19

set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8  " 保存時の文字コード

"##################################
"ファイルタイプ設定　無効化
"##################################

filetype off
filetype plugin indent off

"###############
"ファイル設定
"###############

set nobackup
set noswapfile
set autoread
set hidden

"################
"表示設定
"################

set number              "行番号
set cursorline          "行の強調表示
set title               "編集中のファイル名を表示
set showmatch           "括弧入力時の対応する括弧を表示
syntax on               "コードの色分け
set ruler               "括弧の位置を表示
set showcmd             "コマンド表示
set pumheight=10        "補完メニューの高さ
set nowrap              "画面端改行:無効
set clipboard+=unnamed  "クリップボードを共通に
set scrolloff=5         "余裕を持ってスクロール

"#########################
"タブ/インデント設定
"#########################

source ~/dotfiles/.vimrc.indent

"################
"検索設定
"################

set ignorecase          "大文字/小文字の区別をなく検索
set smartcase           "検索文字列に大文字が含まれている場合は区別
set wrapscan            "検索時に最後まで行ったら最初に戻る
set hlsearch            "検索結果をハイライト

"############################
"コマンドラインモード
"############################

set wildmenu
set wildmode=longest:full,full
set history=5000


"############################
"入力設定
"############################

set backspace=indent,eol,start  "バックスペースの有効化

"############################
"ファイルタイプ有効化
"############################

filetype plugin indent on

