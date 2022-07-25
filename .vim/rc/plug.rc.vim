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
  let g:airline#extensions#branch#enabled   = 1
  let g:airline_powerline_fonts=1

  let g:airline_left_sep = "\ue0b8"
  let g:airline_left_alt_sep = "\ue0b9"
  let g:airline_right_sep = "\ue0be"
  let g:airline_right_alt_sep = "\ue0b9"

  " Plug#endあとにsyntax設定ある

  "################################
  " File tree
  "################################
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  let g:fern#disable_default_mappings = 1
  let g:fern#default_hidden = 1
  let g:fern#default_exclude = '.DS_Store\|.localized'

  nnoremap <silent><C-e> :<C-u>:Fern . -drawer<CR>
  nnoremap <leader>vf :<C-u>vsp<CR>:<C-u>:Fern . -reveal=%<CR>
  nnoremap <leader>f :<C-u>:Fern . -reveal=%<CR>

  function! s:configure_fern() abort
    nmap <buffer><nowait> <C-c> <Plug>(fern-action-cancel)
    nmap <buffer><nowait> <C-l> <Plug>(fern-action-redraw)
    nmap <buffer><nowait> <C-r> <Plug>(fern-action-reload)
    nmap <buffer><nowait> -     <Plug>(fern-action-mark:toggle)

    nmap <buffer><expr>
          \ <Plug>(my-fern-toggle-or-open)
          \ fern#smart#leaf(
          \   "\<Plug>(fern-action-open)",
          \   "\<Plug>(fern-action-expand)",
          \   "\<Plug>(fern-action-collapse)",
          \ )
    nmap <buffer><expr>
          \ <Plug>(my-fern-expand-or-enter)
          \ fern#smart#drawer(
          \   "\<Plug>(fern-action-open-or-expand)",
          \   "\<Plug>(fern-action-open-or-enter)",
          \ )
    nmap <buffer><expr>
          \ <Plug>(my-fern-collapse-or-leave)
          \ fern#smart#drawer(
          \   "\<Plug>(fern-action-collapse)",
          \   "\<Plug>(fern-action-leave)",
          \ )

    nmap <buffer><nowait> <C-m> <plug>(my-fern-toggle-or-open)
    nmap <buffer><nowait> l <Plug>(my-fern-expand-or-enter)
    nmap <buffer><nowait> h <plug>(my-fern-collapse-or-leave)

    nmap <buffer> o <Plug>(fern-action-open:select)
    nmap <buffer> i <Plug>(fern-action-open:split)
    nmap <buffer> s <Plug>(fern-action-open:vsplit)

    " nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
    " nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
    " nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p

    nmap <buffer> mo <Plug>(fern-action-open:system)
    nmap <buffer> ma <Plug>(fern-action-new-path)
    nmap <buffer> mk <Plug>(fern-action-new-dir)
    nmap <buffer> mc <Plug>(fern-action-copy)
    nmap <buffer> mm <Plug>(fern-action-move)
    nmap <buffer> mr <Plug>(fern-action-rename)
    nmap <buffer> md <Plug>(fern-action-trash)
    nmap <buffer> my <Plug>(fern-action-yank:label)

    nmap <buffer><expr>
          \ <Plug>(my-fern-quit-or-nop)
          \ fern#smart#drawer(
          \   "\:<C-u>quit<CR>",
          \   "",
          \ )

    nmap <buffer> q <Plug>(my-fern-quit-or-nop)

    highlight link FernGitStatusIndex DraculaGreenBold
    highlight link FernGitStatusWorktree DraculaRed
  endfunction

  augroup MyFern
    autocmd!
    autocmd FileType fern call s:configure_fern()
  augroup END

  "################################
  " Git
  "################################
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  let g:gitgutter_map_keys = 0
  let g:gitgutter_preview_win_floating = 1
  let g:gitgutter_floating_window_options = {
        \ 'line': 'cursor-1',
        \ 'col': 'cursor+2',
        \ 'moved': 'any',
        \ 'pos': 'botleft',
        \ 'padding': [0,5,0,1],
        \ 'border': [1,1,1,1],
        \ }

  nmap [c <Plug>(GitGutterPrevHunk)
  nmap ]c <Plug>(GitGutterNextHunk)

  nmap <leader>gp <Plug>(GitGutterPreviewHunk)

  omap ic <Plug>(GitGutterTextObjectInnerPending)
  omap ac <Plug>(GitGutterTextObjectOuterPending)
  xmap ic <Plug>(GitGutterTextObjectInnerVisual)
  xmap ac <Plug>(GitGutterTextObjectOuterVisual)

  let g:fugitive_no_maps = 1

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
  let g:fzf_action = {
        \ 'ctrl-i': 'split',
        \ 'ctrl-v': 'vsplit'
        \ }
  let g:fzf_colors = {
        \ 'bg': ['bg', 'DraculaBgLight'],
        \ 'bg+': ['bg', 'DraculaBgLighter'],
        \ 'preview-bg': ['bg', 'DraculaBgDark'],
        \ 'gutter': ['bg', 'DraculaBgLight'],
        \ 'border':  ['fg', 'Error'],
        \ }
  let g:fzf_layout = {
        \ 'window': {
          \ 'width': 0.9,
          \ 'height': 0.65,
          \ },
        \ }

  command! -bang -nargs=? -complete=dir MyFzfRgFiles
        \ call fzf#vim#files(
        \ <q-args>,
        \ fzf#vim#with_preview({'options': ['--reverse'], 'source': 'rg --files --hidden --follow --no-ignore --glob "!.git/*"'}),
        \ <bang>0)

  command! -bang -nargs=* MyFzfRg
        \ call fzf#vim#grep(
        \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always --glob "!.git/*" '.shellescape(<q-args>),
        \ 1,
        \ fzf#vim#with_preview({'options': ['--reverse', '--nth', '4..', '--preview-window', '~1,+{2}-/2']}),
        \ <bang>0)

  command! -bang -nargs=* MyFzfTags
        \ call fzf#vim#tags(
        \ expand('<cword>'),
        \ fzf#vim#with_preview({ "placeholder": "--tag {2}:{-1}:{3}" }),
        \ <bang>0)

  command! -bang -nargs=* MyFzfBTags
        \ call fzf#vim#buffer_tags(
        \ expand('<cword>'),
        \ fzf#vim#with_preview({ "placeholder": "{2}:{3}" }),
        \ <bang>0)

  function! s:delete_buf_sink(lines)
    if len(a:lines) < 2
      return
    endif
    let b = matchstr(a:lines[1], '\[\zs[0-9]*\ze\]')
    call feedkeys(':bdelete '.b)
  endfunction

  command! -bang -nargs=* MyFzfDeleteBuffer
        \ call fzf#vim#buffers(
        \ {'sink*': {lines -> s:delete_buf_sink(lines)}},
        \ <bang>0)

  nnoremap <C-u><C-i> :<C-u>FzfGFiles?<CR>
  nnoremap <C-u><C-p> :<C-u>MyFzfRgFiles<CR>
  nnoremap <C-u><C-b> :<C-u>FzfBuffers<CR>
  nnoremap <C-u><C-g> :<C-u>MyFzfRg<CR>
  nnoremap <C-u><C-j> :<C-u>FzfBLines<CR>
  nnoremap <C-u><C-h> :<C-u>FzfHistory<CR>
  nnoremap <C-u><C-r> :<C-u>FzfHistory:<CR>
  nnoremap <C-u><C-s> :<C-u>FzfCommands<CR>

  nnoremap <C-u><C-d><C-b> :<C-u>MyFzfDeleteBuffer<CR>

  nnoremap <expr> <C-u><C-]> &filetype == 'help' ? "g\<C-]>" : ":<C-u>MyFzfTags<CR>"
  nnoremap <expr> <C-u><C-]><C-b> &filetype == 'help' ? "g\<C-]>" : ":<C-u>MyFzfBTags<CR>"
  inoremap <expr> <C-x><C-u><C-f> fzf#vim#complete#path('rg --files --hidden --no-ignore', {'options': '--reverse', 'down': 10})

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
  Plug 'Kanon159/vim-lsp-settings', {'branch': 'kanon'}
  " Plug 'mattn/vim-lsp-settings'

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
  let g:lsp_settings['intelephense'] = {
    \  'workspace_config': {
    \    'intelephense': {
    \      'maxMemory': 1024,
    \      'stubs': intelephense_stubs_default,
    \      'files': {
    \        'maxSize': 1000000,
    \      },
    \      'completion': {
    \        'insertUseDeclaration': v:true,
    \        'fullyQualifyGlobalConstantsAndFunctions': v:false,
    \        'triggerParameterHints': v:true,
    \        'maxItems': 100,
    \      },
    \      'diagnostics': {
    \        'run': 'onSave',
    \      },
    \      'format': {
    \        'enable': v:true,
    \      },
    \    },
    \  },
    \}
  let g:lsp_settings['solargraph'] = {'initialization_options': {'diagnostics': v:true, 'formatting': v:true}}
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

  let g:lsp_settings_filetype_ruby = 'solargraph'
  " let g:vim_lsp_settings_volar_experimental_multiple_servers = v:true

  if !empty(glob('./.vim-lsp-settings/settings.json'))
    function! s:overwrite_lsp_settings() abort
      let l:lsp_local_conf = json_decode(join(readfile('./.vim-lsp-settings/settings.json'), "\n"))

      let l:solargraph_docker_conf = get(l:lsp_local_conf, 'solargraph-docker', '')
      if !empty(l:solargraph_docker_conf)
        let g:lsp_settings_filetype_ruby = 'solargraph-docker'
      endif

      let l:volar_docker_conf = get(l:lsp_local_conf, 'volar-docker', '')
      if !empty(l:volar_docker_conf)
        let g:lsp_settings_filetype_vue = 'volar-docker'
      endif
    endfunction

    call s:overwrite_lsp_settings()
  endif

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
    nnoremap <leader>l] :<C-u>LspDefinition<CR>
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

  " Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
  " let g:markdown_enable_insert_mode_leader_mappings = 1
  " let g:markdown_enable_spell_checking = 0

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

