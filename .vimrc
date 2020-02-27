"# Author      : Kanon
"# Since       : 2017/02/09
"# LadtUpdate  : 2018/04/11

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
" set completeopt=menuone " 補完メニューの表示設定
set nowrap              " 画面端改行:無効
set scrolloff=10        " 余裕を持ってスクロール
set visualbell          " ビープ音を可視化
set virtualedit=onemore " 行末の1文字先までカーソル
set laststatus=2        " ステータスラインを常に表示
set ambiwidth=double    " 全角記号を正確に表示

"####################
"カラースキーム
"###################

set redrawtime=4000
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


"#########################
"util script
"#########################

source ~/dotfiles/.vimrc.script " 外部ファイル読み込み

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
" if dein#check_install()
"   call dein#install()
" endif

"#################################
"インデント・プラグイン on
"#################################

filetype plugin indent on

"################################
"ぷらぎん関係の設定
"tomlに移行する
"################################

" airline の設定
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled  = 1
let g:airline#extensions#branch#enavled   = 1

" vim-indent-guides
"let g:indent_guides_guide_size  = 1
let g:indent_guides_start_level = 3
let g:indent_guides_auto_colors = 0
autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#1e1f28 ctermbg=235
autocmd MyAutoCmd Vimenter,Colorscheme * :hi IndentGuidesOdd guibg=#232530 ctermbg=237
let g:indent_guides_color_change_percent = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" NERDTree
let NERDTreeShowHidden = 1
nnoremap <silent><C-e> :NERDTreeToggle<CR>

autocmd MyAutoCmd StdinReadPre * let s:std_in=1
autocmd MyAutoCmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" tagbar
let g:tagbar_sort = 0
nnoremap <silent><Space><C-e> :TagbarToggle<CR>

" markdown
autocmd MyAutoCmd BufRead,BufNewFile *.md  :set filetype=markdown
let g:markdown_enable_insert_mode_leader_mappings = 1 
let g:markdown_enable_spell_checking = 0

" vim-asterisk
map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

" vim-over
nnoremap <silent> <Space>o :OverCommandLine<CR>%s//g<Left><Left>
vnoremap <silent> <Space>o :OverCommandLine<CR>s//g<Left><Left>
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

" vim-quickrun
" 成功したらbuffer,失敗したらquickfix
let g:quickrun_config = {
      \   "_" : {
      \         'runner'    : 'job',
      \         'outputter' : 'error',
      \         'outputter/error/success' : 'buffer',
      \         'outputter/error/error'   : 'quickfix',
      \         'outputter/buffer/split'  : 'botright 10sp',
      \         'outputter/buffer/into': 1,
      \         'outputter/buffer/close_on_empty' : 1,
      \   },
      \}

nnoremap <Leader>r :QuickRun<Cr>
vnoremap <Leader>r :QuickRun -mode v<CR>

" vimproc
let g:vimproc_dll_path = '~/.cache/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_mac.so'

" editconfig
let g:EditorConfig_exclude_patterns = ['fugitive：//.*']

