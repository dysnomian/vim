"---------------------------------------------------------------------------
" Plugin:
"

" Formatting

" thermal
  au Syntax thermal    runtime! syntax/themal.vim

  nmap <Space>t
    \ :<C-u>call <SID>thermal_toggle()<CR>

  function! s:thermal_toggle()
    if exists('b:thermal_original_filetype')
      exe "set syntax=" . b:thermal_original_filetype
      unlet b:thermal_original_filetype
      echo "Thermal mode off"
    else
      let b:thermal_original_filetype = &filetype
      set syntax=thermal
      echo 'Thermal mode on'
    endif
  endfunction

" findent
augroup findent
  autocmd!
  autocmd BufRead * Findent! --no-warnings
augroup END

" FastFold
let g:tex_fold_enabled = 1

" Vim script
" augroup: a
" function: f
" lua: l
" perl: p
" ruby: r
" python: P
" tcl: t
" mzscheme: m
let g:vimsyn_folding = 'af'

let g:xml_syntax_folding = 1
let g:php_folding = 1
let g:perl_fold = 1

" vim-autoformat {{{
if !exists('g:formatdef_standard_javascript')
  let g:formatdef_standard_javascript = '"standard --stdin ".(&expandtab ? "s ".shiftwidth() : "t").(&textwidth ? " -w ".&textwidth : "")'
endif

if !exists('g:formatters_javascript')
  let g:formatters_javascript = [
        \ 'jsbeautify_javascript',
        \ 'standard_javascript',
        \ 'pyjsbeautify_javascript',
        \ 'jscs'
        \ ]
endif
" }}}

" CamelCaseMotion
nmap <silent> w <Plug>CamelCaseMotion_w
xmap <silent> w <Plug>CamelCaseMotion_w
omap <silent> W <Plug>CamelCaseMotion_w
nmap <silent> b <Plug>CamelCaseMotion_b
xmap <silent> b <Plug>CamelCaseMotion_b
omap <silent> B <Plug>CamelCaseMotion_b

" caw.vim
autocmd MyAutoCmd FileType * call s:init_caw()
function! s:init_caw() abort
  if !&l:modifiable
    silent! nunmap <buffer> gc
    silent! xunmap <buffer> gc
    silent! nunmap <buffer> gcc
    silent! xunmap <buffer> gcc
  else
    nmap <buffer> gc <Plug>(caw:prefix)
    xmap <buffer> gc <Plug>(caw:prefix)
    nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
    xmap <buffer> gcc <Plug>(caw:hatpos:toggle)
  endif
endfunction

" deoplete

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"

" omnifuncs

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

  "

  " vim-monster

  let g:monster#completion#rcodetools#backend = "async_rct_complete"
  let g:deoplete#sources#omni#input_patterns = {
        \   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
        \}

  "

  " tern_for_vim
  if exists('g:plugs["tern_for_vim"]')
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]

    let g:tern_show_argument_hints = 'on_hold'
    let g:tern_request_timeout = 1
    let g:tern_show_signature_in_pum = 0

    autocmd FileType javascript setlocal omnifunc=tern#Complete
  endif
  "

  " Easy Align

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap <Space>- <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
  "

  " Neoterm
  let g:neoterm_position = 'horizontal'
  let g:neoterm_automap_keys = ',tt'

  nnoremap <silent> <f10> :TREPLSendFile<cr>
  nnoremap <silent> <f9>  :TREPLSend<cr>
  vnoremap <silent> <f9>  :TREPLSend<cr>
  "

  " run set test lib
  nnoremap <silent> ,rt :call neoterm#test#run('all')<cr>
  nnoremap <silent> ,rf :call neoterm#test#run('file')<cr>
  nnoremap <silent> ,rn :call neoterm#test#run('current')<cr>
  nnoremap <silent> ,rr :call neoterm#test#rerun()<cr>

  " Useful maps
  " hide/close terminal
  nnoremap <silent> ,tc :call neoterm#close()<cr>
  " clear terminal
  nnoremap <silent> ,tl :call neoterm#clear()<cr>
  " kills the current job (send a <c-c>)
  nnoremap <silent> ,tc :call neoterm#kill()<cr>

  " Rails commands
  command! Troutes :T rake routes
  command! -nargs=+ Troute :T rake routes | grep <args>
  command! Tmigrate :T rake db:migrate

  " Git commands
  command! -nargs=+ Tg :T git <args>

  " Snippets

  " Ultisnips

  let g:UltiSnipsExpandTrigger="<S-Tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  "

  " Navigation

  " accelerated-jk
  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap gj j
  nmap <silent>k <Plug>(accelerated_jk_gk)
  nmap gk k

  " open-browser.vim
  nmap gs <Plug>(open-browser-wwwsearch)

  nnoremap <Plug>(open-browser-wwwsearch)
        \ :<C-u>call <SID>www_search()<CR>
  function! s:www_search() abort
    let search_word = input('Please input search word: ')
    if search_word != ''
      execute 'OpenBrowserSearch' escape(search_word, '"')
    endif
  endfunction

  " Sidebar utilities

  """ Mappings
  nmap <C-m>   :TagbarToggle<CR>
  " nmap <C-,>   :GundoToggle<CR>
  " nmap <C-b>   :BuffergatorToggle<CR>
  nmap <C-n>   :NERDTreeToggle<CR>
  map <Space>n :NERDTreeFind<CR>

  " Tagbar

  let g:tagbar_autofocus = 1

  " NERDTree

  " Close NERDTree if it's the only window
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " nerdtree-git-plugin
  let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ "Unknown"   : "?"
        \ }


  " Sidebar {{{
  " Set position (left or right) if neccesary (default: "left").
  let g:sidepanel_pos = "left"
  " Set width if neccesary (default: 32)
  let g:sidepanel_width = 26

  " To use rabbit-ui.vim
  let g:sidepanel_use_rabbit_ui = 1

  " Activate plugins in SidePanel
  let g:sidepanel_config = {}
  let g:sidepanel_config['nerdtree'] = {}
  let g:sidepanel_config['tagbar'] = {}
  let g:sidepanel_config['gundo'] = {}
  let g:sidepanel_config['buffergator'] = {}
  let g:sidepanel_config['vimfiler'] = {}

  " }}}

  " Pry {{{

  iabbr bpry require'pry';binding.pry

  syntax keyword bindingPry
        \ binding
        \ pry
        \ remote_pry

  highlight link bindingPry Error

  " …also, Insert Mode as bpry<space>
  iabbr bpry require'pry';binding.pry
  " And admit that the typos happen:
  iabbr bpry require'pry';binding.pry

  " Add the pry debug line with \bp (or <Space>bp, if you did: map <Space> <Leader> )
  map <Leader>bp orequire'pry';binding.pry<esc>:w<cr>
  " Alias for one-handed operation:
  map <Leader><Leader>p <Leader>bp

  " Keep pry from annoyingly hanging around when using, e.g. pry-rescue/minitest
  map <f3> :wa<cr>:call system('kill-pry-rescue')<cr>

  " Nab lines from ~/.pry_history (respects "count")
  nmap <Leader>ph :<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.pry_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>
  " ↑ thanks to Houl, ZyX-i, and paradigm of #vim for all dogpiling on this one.

  " }}}

  " ack.vim

  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  endif

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack

  " Appearance

  " Airline
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1

  " vim-gitgutter
  silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

" Thematic

" Toggle backgrounds (ideally, dark to light and back)
nnoremap <silent> [Space]bg
      \ :ThematicNext<CR>

let g:thematic#themes = {
    \ 'homu' : {'colorscheme': 'puellamagi',
    \             'background': 'dark',
    \             'airline-theme': 'fairyfloss',
    \          },
    \ 'fairyfloss' : {'colorscheme': 'puellamagi-light',
    \             'background': 'light',
    \             'airline-theme': 'fairyfloss',
    \          },
    \ 'jellybeans'   : {'colorscheme': 'jellybeans',
    \                   'background': 'dark',
    \                   'airline-theme': 'jellybeans',
    \                   'ruler': 1,
    \                },
    \ 'molokai'    : {'colorscheme': 'molokai',
    \                   'background': 'dark',
    \                   'airline-theme': 'molokai',
    \                }
    \ }

" let g:thematic#themes = {
"       \ 'demon' :      {'colorscheme': 'puellamagi',
"       \                   'background': 'dark',
"       \                   'airline-theme': 'fairyfloss',
"       \                },
"       \ 'fairyfloss' : {'colorscheme': 'fairyfloss',
"       \                   'background': 'dark',
"       \                   'airline-theme': 'fairyfloss',
"       \                },
"       \ 'javascript' : {'colorscheme': 'molokai',
"       \                   'background': 'dark',
"       \                   'airline-theme': 'molokai',
"       \                },
"       \ 'clojure'    : {'colorscheme': 'molokai',
"       \                   'background': 'dark',
"       \                   'airline-theme': 'molokai',
"       \                },
"       \ 'markdown'   : {'colorscheme': 'jellybeans',
"       \                   'background': 'dark',
"       \                   'airline-theme': 'jellybeans',
"       \                   'ruler': 1,
"       \                },
"       \ }
"

" Goyo
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

  silent! GitGutterDisable
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif

  silent! GitGutterEnable
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"

" Limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
"

" Syntax {{{

" syntastic
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:syntastic_c_checkers = ['check']
let g:syntastic_cpp_checkers = ['check']
let g:syntastic_javascript_checkers = ['js-beautify']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_yaml_checkers = ['pyyaml']

""" Accomodate Angular
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

nnoremap <silent> [Space]s
      \ :SyntasticToggleMode<CR>

" }}}

" vim-operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

""" Languages

" Clojure

" rainbowparentheses.vim
nnoremap <silent> [Space]rp
      \ :<C-u>RainbowParentheses!!<CR>
nnoremap <silent> [Space])
      \ :<C-u>RainbowParentheses!!<CR>

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ["{", "}"]]

" List of colors that you do not want. ANSI code or #RRGGBB
let g:rainbow#blacklist = [233, 234]

" vim-fireplace
let g:paredit_mode = 1

" Git

" fugitive
nnoremap <C-,>
      \ :<C-u>Gblame<CR>

" vim-gitgutter
let g:gitgutter_sign_column_always = 1
let g:gitgutter_max_signs = 500

silent! if emoji#available()
let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

" Java

" if neobundle#tap('vim-javacomplete2')
autocmd MyAutoCmd FileType java setlocal omnifunc=javacomplete#Complete

" call neobundle#untap()
" endif

" Javascript

" vim-angular
let g:angular_source_directory = 'app/assets/javascripts/admin'
let g:angular_test_directory = 'app/assets/javascripts/admin'
let g:angular_filename_convention = 'camelcased'

let g:used_javascript_libs = 'jquery,underscore,angularjs,angularui,angularuirouter,react,chai,requirejs'

" Lua

" vim-lua-ftplugin
let g:lua_define_completion_mappings = 0
let g:lua_check_syntax = 0
let g:lua_complete_omni = 1
let g:lua_complete_dynamic = 0

" Python

" jedi.vim
autocmd MyAutoCmd FileType python
      \ if has('python') || has('python3') |
      \   setlocal omnifunc=jedi#completions |
      \ else |
      \   setlocal omnifunc= |
      \ endif
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0

" Rust

" vim-racer
let g:racer_cmd = expand('~/.cache/neobundle/racer/target/release/racer')
let $RUST_SRC_PATH = expand('~/src/rust/src')
let g:racer_experimental_completer = 1
