"# Author      : Kanon
"# Since       : 2017/02/09
"# LadtUpdate  : 2017/02/10

set encoding=utf-8
scriptencoding utf-8

"##################################
"### ファイルタイプ設定　無効化 ###
"##################################

filetype off
filetype plugin indent off


"################
"### 表示設定 ###
"################

set number              "行番号
set title               "編集中のファイル名を表示
set showmatch           "括弧入力時の対応する括弧を表示
syntax on               "コードの色分け
set ruler               "括弧の位置を表示

set expandtab           "タブをスペースに
set autoindent          "インデントを自動で
set tabstop=2           "タブ幅 : 4
set shiftwidth=2        "自動インデント幅:4
set clipboard+=unnamed  "クリップボードを共通に
set nowrap              "画面端改行:無効

"################
"### 検索設定 ###
"################

set ignorecase          "大文字/小文字の区別をなく検索
set smartcase           "検索文字列に大文字が含まれている場合は区別
set wrapscan            "検索時に最後まで行ったら最初に戻る
set hlsearch            "検索結果をハイライト

"############################
"### コマンドラインモード ###
"############################

set wildmenu
set wildmode=longest:full,full
set history=5000


"############################
"### バックスペース有効化 ###
"############################

set backspace=indent,eol,start


"##################################
"### ファイルタイプ設定　有効化 ###
"##################################

filetype plugin indent on

