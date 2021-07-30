let s:plugvim = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plugvim))
  execute "silent !curl -fLo " . s:plugvim . " --create-dirs "
        \ . "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  " autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if !empty(glob(s:plugvim))
  call plug#begin('~/.vim/plugged')

  Plug 'vim-jp/vimdoc-ja'
  set helplang=ja

  "################################
  " View, Design
  "################################
  Plug 'dracula/vim', { 'as': 'dracula' }

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline#extensions#tabline#enabled  = 1
  let g:airline#extensions#branch#enavled   = 1

  " Plug#endあとにsyntax設定ある

  "################################
  " File tree
  "################################
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let NERDTreeShowHidden = 1
  nnoremap <silent><C-e> :NERDTreeToggle<CR>

  autocmd MyAutoCmd StdinReadPre * let s:std_in=1
  autocmd MyAutoCmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  "################################
  " Git
  "################################
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  "################################
  " Text 
  "################################
  Plug 'cohama/lexima.vim'
  Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'eruby', 'php'] }

  "################################
  " Substitute
  "################################
  Plug 'osyo-manga/vim-over'
  nnoremap <silent> <Space>o :OverCommandLine<CR>%s//g<Left><Left>
  vnoremap <silent> <Space>o :OverCommandLine<CR>s//g<Left><Left>
  nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

  "################################
  " Search
  "################################
  Plug 'haya14busa/is.vim'
  Plug 'haya14busa/vim-asterisk'
  map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
  map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
  map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
  map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

  Plug '~/.cache/.fzf'
  Plug 'junegunn/fzf.vim'
  let g:fzf_buffers_jump = 1
  let g:fzf_command_prefix = 'Fzf'
  let g:fzf_action ={
    \ 'ctrl-i': 'split',
    \ 'ctrl-v': 'vsplit' }

  command! -bang -nargs=? -complete=dir RgFiles
        \ call fzf#vim#files(
        \ <q-args>,
        \ fzf#vim#with_preview({'options': '--reverse', 'source': 'rg --files --hidden --follow --no-ignore --glob "!.git/*"'}),
        \ <bang>0)

  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>),
        \ 1,
        \ fzf#vim#with_preview({'options': '--reverse --delimiter : --nth 4..'}),
        \ <bang>0)

  command! -bang -nargs=* Tags
        \ call fzf#vim#tags(
        \ expand('<cword>'),
        \ fzf#vim#with_preview({ "placeholder": "--tag {2}:{-1}:{3}" }),
        \ <bang>0)

  command! -bang -nargs=* BTags
        \ call fzf#vim#buffer_tags(
        \ expand('<cword>'),
        \ fzf#vim#with_preview({ "placeholder": "{2}:{3}" }),
        \ <bang>0)


  nnoremap <C-u><C-t> :<C-u><CR>
  nnoremap <C-u><C-p> :<C-u>RgFiles<CR>
  nnoremap <C-u><C-b> :<C-u>FzfBuffers<CR>
  nnoremap <C-u><C-g> :<C-u>Rg<CR>
  nnoremap <C-u><C-j> :<C-u>FzfBLines<CR>
  nnoremap <C-u><C-h> :<C-u>FzfHistory<CR>
  nnoremap <C-u><C-r> :<C-u>FzfHistory:<CR>
  nnoremap <C-u><C-s> :<C-u>FzfCommands<CR>
  nnoremap <expr> <C-u><C-]> &filetype == 'help' ? "g\<C-]>" : ":<C-u>Tags<CR>"
  nnoremap <expr> <C-u><C-b><C-]> &filetype == 'help' ? "g\<C-]>" : ":<C-u>BTags<CR>"

  inoremap <expr> <C-x><C-u><C-f> fzf#vim#complete#path('rg --files --hidden --no-ignore', {'options': '--reverse', 'down': 10})

  " tnoremap <C-u><C-y> <C-w>:Denite register<CR>

  "################################
  " style
  "################################
  Plug 'editorconfig/editorconfig-vim'
  let g:EditorConfig_exclude_patterns = ['fugitive：//.*']

  "################################
  " Complement
  "################################
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'

  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'

  let g:lsp_fold_enabled = 0
  let g:lsp_diagnostics_enabled = 1
  let g:lsp_diagnostics_echo_cursor = 1
  let g:lsp_text_edit_enabled = 1

  " ドキュメンから持ってきたやつ
  let intelephense_stubs_default = [
        \ "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl",
        \ "date", "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm",
        \ "ftp", "gd", "gettext", "gmp", "hash", "iconv", "imap", "intl", "json", "ldap",
        \ "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl", "pcntl",
        \ "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
        \ "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop",
        \ "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3", "standard",
        \ "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "xml",
        \ "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib"
        \ ]
  call add(intelephense_stubs_default, "redis")

  let g:lsp_settings = {}
  let g:lsp_settings['intelephense'] = {'workspace_config': {'intelephense': {'stubs': intelephense_stubs_default}}}
  let g:lsp_settings['solargraph'] = {'initialization_options': {'diagnostics': v:true}}
  let g:lsp_settings['gopls'] = {
    \  'workspace_config': {
    \    'completeUnimported': v:true,
    \    'analyses': {
    \      'fillstruct': v:true,
    \    },
    \  },
    \  'initialization_options': {
    \    'usePlaceholders': v:true,
    \    'staticcheck': v:true,
    \    'analyses': {
    \      'fillstruct': v:true,
    \    },
    \  },
    \}

  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 1
  let g:asyncomplete_popup_delay = 200

  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


  function! s:configure_lsp() abort
    setlocal omnifunc=lsp#complete

    inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"

    nnoremap <leader>ld :<C-u>vsp<CR>:<C-u>LspDefinition<CR>
    nnoremap <leader>lr :<C-u>LspRename<CR>
    nnoremap <leader>lf :<C-u>LspDocumentFormat<CR>
    vnoremap <leader>lf :<C-u>LspDocumentRangeFormat<CR>
    nnoremap <leader>lt :<C-u>vsp<CR>:<C-u>LspTypeDefinition<CR>
    nnoremap <leader>lx :<C-u>vsp<CR>:<C-u>LspReferences<CR>
    nnoremap <leader>lh :<C-u>LspHover<CR>
    nnoremap <leader>ls :<C-u>LspDocumentSymbol<CR>
    nnoremap <leader>lws :<C-u>LspWorkspaceSymbol<CR>
    nnoremap <leader>ln :<C-u>LspNextDiagnostic<CR>
    nnoremap <leader>lp :<C-u>LspPreviousDiagnostic<CR>
    nnoremap <leader>la :<C-u>LspCodeAction<CR>
    nnoremap <leader>lcl :<C-u>LspCodeLens<CR>

  endfunction

  augroup MyLsp
    autocmd!
    autocmd User lsp_buffer_enabled call s:configure_lsp()
  augroup END

  "################################
  " language
  "################################
  Plug 'mattn/vim-gomod'

  Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
  let g:markdown_enable_insert_mode_leader_mappings = 1 
  let g:markdown_enable_spell_checking = 0

  Plug 'hail2u/vim-css3-syntax', { 'for': ['html', 'css'] }
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'cespare/vim-toml', { 'for': 'toml' }
  Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx', 'jsx'] }

  "################################
  " tag
  "################################
  Plug 'majutsushi/tagbar'
  let g:tagbar_sort = 0
  nnoremap <silent><Space><C-e> :TagbarToggle<CR>
  let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
  \ }

  "################################
  " quickrun
  "################################
  Plug 'thinca/vim-quickrun'

  let g:quickrun_config = {
  \   '_': {
  \     'runner': 'job'
  \   },
  \   'php': {
  \     'command' : 'php-docker',
  \     'cmdopt'  : '',
  \     'exec'    : '%c %s'
  \   }
  \ }

  "################################
  " Showtime
  "################################
  Plug 'thinca/vim-showtime'

  call plug#end()
endif

if !empty(glob('~/.vim/plugged/dracula'))
  set termguicolors
  let g:dracula_colorterm = 0
  let g:dracula_italic = 0
  autocmd MyAutoCmd ColorScheme * highlight Visual term=reverse ctermbg=242 guibg=#6c6c6c
  colorscheme dracula
  let g:airline_theme = 'dracula'
else
  color dracula_old
  let g:airline_theme = 'dracula_old'
endif

