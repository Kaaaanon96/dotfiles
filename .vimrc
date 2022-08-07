"# Author      : Kanon

set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

"###############
"function
"###############

function! s:source_rc(rc_file_name)
    let rc_file = expand('~/.vim/rc/' . a:rc_file_name)
    if filereadable(rc_file)
        execute 'source' rc_file
    endif
endfunction

" call s:source_rc('benchscript.rc.vim')

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
" set completeopt=menuone " 補完メニューの表示設定
set nowrap              " 画面端改行:無効
set scrolloff=10        " 余裕を持ってスクロール
set visualbell          " ビープ音を可視化
set virtualedit=onemore " 行末の1文字先までカーソル
set laststatus=2        " ステータスラインを常に表示
set ambiwidth=double    " 全角記号を正確に表示
set updatetime=1000     " スワップファイルがディスクに書き込まれるまでの猶予時間(gitgutter用変更)

"####################
"カラースキーム
"###################

" set redrawtime=4000

"#########################
"タブ/インデント設定
"#########################

call s:source_rc('indent.rc.vim')

"################
"検索設定
"################

set ignorecase          " 大文字/小文字の区別をなく検索
set smartcase           " 検索文字列に大文字が含まれている場合は区別
set wrapscan            " 検索時に最後まで行ったら最初に戻る
set incsearch           " インクリメンタルな検索
set hlsearch            " 検索結果をハイライト

"############################
"コマンドラインモード
"############################

set wildmenu
set wildmode=longest:full,full
set history=5000

"#################################
"autocmd リセット
"#################################

augroup MyAutoCmd
  autocmd! *
augroup END

"#################################
"シンタックス追加
"#################################

autocmd MyAutoCmd BufNewFile,BufRead *.ruby set filetype=ruby

"################
"タグ周り
"################

set tags=./tags;
autocmd MyAutoCmd BufNewFile,BufRead *.php set tags=./php.tags;
autocmd MyAutoCmd BufNewFile,BufRead *.rb set tags=./ruby.tags;
" autocmd MyAutoCmd BufNewFile,BufRead *.rb set tags=./gemlock.tags;

"############################
"入力設定
"############################

set backspace=indent,eol,start  " バックスペースの有効化
"set clipboard+=unnamed          " クリップボードを共通に
set timeout timeoutlen=1000 ttimeoutlen=75

" %ジャンプの拡張
source $VIMRUNTIME/macros/matchit.vim

" leaderを変更
let mapleader = ","

" w!!でsudoで保存
cnoremap w!! w !sudo tee %<CR>

" Yで行末までヤンク
noremap Y y$

" ^と$がすぐに押せないからスペースとの組み合わせを使用
noremap <Space>h ^
noremap <Space>l $

" クリップボードからペースト
nnoremap <Space>p "*p
vnoremap <Space>p "*p
nnoremap <Space>P "*P
vnoremap <Space>P "*P
" クリップボードにヤンク
nnoremap <Space>y "*y
nnoremap <Space>Y "*y$
vnoremap <Space>y "*y
" 削除してクリップボードに
nnoremap <Space>d "*d
nnoremap <Space>D "*d$
vnoremap <Space>d "*d

" コマンドライン
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" 挿入モード
inoremap <C-b> <Left>
inoremap <C-f> <Right>
" inoremap <M-b> <S-Left>
" inoremap <M-f> <S-Right>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

" terminal
tnoremap <silent><C-w><Esc> <C-w><S-n>:set nonumber<CR>

"############################
" plugin
"############################

call s:source_rc('plug.rc.vim')


