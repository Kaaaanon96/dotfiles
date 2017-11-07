"# Author      : Kanon
"# Since       : 2017/02/09
"# LadtUpdate  : 2017/11/07

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

set nobackup            "バックアップファイルを作らない
set noswapfile          "スワップファイルを作らない
set autoread            "編集中のファイルが変更されたら自動再読込
set hidden              "バッファが編集中でもその他のファイルを開けるように

"################
"表示設定
"################

set number              "行番号
set cursorline          "行の強調表示
set title               "編集中のファイル名を表示
set showmatch           "括弧入力時の対応する括弧を表示
set ruler               "括弧の位置を表示
set showcmd             "コマンド表示
set pumheight=10        "補完メニューの高さ
set nowrap              "画面端改行:無効
set scrolloff=7         "余裕を持ってスクロール
set visualbell          "ビープ音を可視化
set virtualedit=onemore "行末の1文字先までカーソル

"####################
"カラースキーム
"###################

syntax on
color dracula

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
set clipboard+=unnamed  "クリップボードを共通に

map Y y$      " Y を行末までのヤンクに

"############################
"ファイルタイプ有効化
"############################

filetype plugin indent on

