"---------------------------------------------------------------------------
" Key-mappings:
"

" " Use <C-Space>.
" nmap <C-Space>  <C-@>
" cmap <C-Space>  <C-@>

if has('clipboard')
  xnoremap <silent> y "*y:let [@+,@"]=[@*,@*]<CR>
endif
"}}}

if has('gui_running')
  inoremap <ESC> <ESC>
endif

" Tab autocompletion with deoplete.
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" ,<Tab> for regular tab
inoremap <Leader><Tab> <Space><Space>

" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" Command-line mode keymappings:"{{{
" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>
" <C-y>: paste.
cnoremap <C-y>          <C-r>*
" <C-g>: Exit.
cnoremap <C-g>          <C-c>
"}}}

" [Space]: Other useful commands "{{{
" Smart space mapping.
nmap  <Space>   [Space]
xmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
xnoremap  [Space]   <Nop>

" Toggle relativenumber.
nnoremap <silent> [Space].
      \ :<C-u>call ToggleOption('relativenumber')<CR>
nnoremap <silent> [Space]m
      \ :<C-u>call ToggleOption('paste')<CR>:set mouse=<CR>
" Toggle highlight.
nnoremap <silent> [Space]/
      \ :<C-u>call ToggleOption('hlsearch')<CR>
" Toggle crosshairs.
nnoremap <silent> [Space]ch
      \ :<C-u>call ToggleOption('cursorcolumn')<CR>
" Set autoread.
nnoremap [Space]ar
      \ :<C-u>setlocal autoread<CR>
" Set spell check.
nnoremap [Space]sp
      \ :<C-u>call ToggleOption('spell')<CR>
nnoremap [Space]w
      \ :<C-u>call ToggleOption('wrap')<CR>
" Toggle Goyo mode (distraction-free)
nnoremap [Space]G
      \ :<C-u>Goyo<CR>

" Easily edit .vimrc and .gvimrc "{{{
nnoremap <silent> [Space]ev  :<C-u>edit $MYVIMRC<CR>
" Easily edit bundles.rc "{{{
nnoremap <silent> [Space]eb  :<C-u>edit ~/.dotfiles/vim/rc/bundles.rc.vim<CR>
      \ echo "source $MYVIMRC"<CR>
nnoremap <silent> [Space]fc :<C-u>edit ~/.config/fish/config.fish<CR>
" "}}}

" Apply autoformatting
nnoremap <silent> [Space]=
      \ :<C-u>Autoformat<CR>

" Toggle windows
nnoremap [Space]<Space> <C-^>

" Toggle options. "{{{
function! ToggleOption(option_name) abort
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction  "}}}
" Toggle variables. "{{{
function! ToggleVariable(variable_name) abort
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
  echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction  "}}}
"}}}

" s: Windows and buffers(High priority) "{{{
" The prefix key.
nnoremap [Window]   <Nop>
nmap     s [Window]
nnoremap <silent> [Window]p  :<C-u>call <SID>split_nicely()<CR>
nnoremap <silent> [Window]v  :<C-u>vsplit<CR>
nnoremap <silent> [Window]c  :<C-u>call <SID>smart_close()<CR>
nnoremap <silent> [Window]-  :<C-u>call <SID>smart_close()<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]q  :<C-u>call <SID>smart_close()<CR>

function! s:smart_close() abort
  if winnr('$') != 1
    close
  endif
endfunction

function! s:NextWindow() abort
  if winnr('$') == 1
    silent! normal! ``z.
  else
    wincmd w
  endif
endfunction

function! s:NextWindowOrTab() abort
  if tabpagenr('$') == 1 && winnr('$') == 1
    call s:split_nicely()
  elseif winnr() < winnr("$")
    wincmd w
  else
    tabnext
    1wincmd w
  endif
endfunction

function! s:PreviousWindowOrTab() abort
  if winnr() > 1
    wincmd W
  else
    tabprevious
    execute winnr("$") . "wincmd w"
  endif
endfunction

" Split nicely."{{{
function! s:split_nicely() abort
  " Split nicely.
  if winwidth(0) > 2 * &winwidth
    vsplit
  else
    split
  endif
  wincmd p
endfunction
"}}}

" Jump mark can restore column."{{{
nnoremap \  `
" Useless command.
nnoremap M  m
"}}}

" Smart <C-f>, <C-b>.
noremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ . "\<C-d>" . (line('w$') >= line('$') ? "L" : "H")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ . "\<C-u>" . (line('w0') <= 1 ? "H" : "L")

" Disable ZZ.
nnoremap ZZ  <Nop>

" Auto escape / and ? in search command.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

" Smart home and smart end."{{{
nnoremap <silent> gh  :<C-u>call SmartHome('n')<CR>
xnoremap <silent> gh  <ESC>:<C-u>call SmartHome('v')<CR>
" Smart home function"{{{
function! SmartHome(mode) abort
  let curcol = col('.')

  if &wrap
    normal! g^
  else
    normal! ^
  endif
  if col('.') == curcol
    if &wrap
      normal! g0
    else
      normal! 0
    endif
  endif

  if a:mode == "v"
    normal! msgv`s
  endif

  return ""
endfunction"}}}
"}}}

" " Select rectangle.
" xnoremap r <C-v>
"
" " Paste next line.
" nnoremap <silent> gp o<ESC>p^
" nnoremap <silent> gP O<ESC>P^
" xnoremap <silent> gp o<ESC>p^
" xnoremap <silent> gP O<ESC>P^
"
" " Redraw.
" nnoremap <silent> <C-l>    :<C-u>redraw!<CR>

" Folding."{{{
" If press h on head, fold close.
"nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" If press l on fold, fold open.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press h on head, range fold close.
"xnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" If press l on fold, range fold open.
xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
noremap [Space]j zj
noremap [Space]k zk
noremap zz za
"}}}

" Substitute.
xnoremap s :s//g<Left><Left>

" Move to top/center/bottom.
noremap <expr> zz (winline() == (winheight(0)+1)/ 2) ?
      \ 'zt' : (winline() == 1)? 'zb' : 'zz'

" Capitalize.
nnoremap gu gUiw`]

" Clear highlight.
nnoremap <ESC><ESC> :nohlsearch<CR>:match<CR>
"}}}

" Improved increment.
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment)   :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement)   :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
function! s:add_numbers(num) abort
  let prev_line = getline('.')[: col('.')-1]
  let next_line = getline('.')[col('.') :]
  let prev_num = matchstr(prev_line, '\d\+$')
  if prev_num != ''
    let next_num = matchstr(next_line, '^\d\+')
    let new_line = prev_line[: -len(prev_num)-1] .
          \ printf('%0'.len(prev_num . next_num).'d',
          \    max([0, prev_num . next_num + a:num])) . next_line[len(next_num):]
  else
    let new_line = prev_line . substitute(next_line, '\d\+',
          \ "\\=printf('%0'.len(submatch(0)).'d',
          \         max([0, submatch(0) + a:num]))", '')
  endif

  if getline('.') !=# new_line
    call setline('.', new_line)
  endif
endfunction

" " Search.
" nnoremap ;n  ;
" nnoremap ;m  ,
"
" " Replace word under cursor (which should be a GitHub username)
" " with some user info ("Full Name <email@address>").
" " If info cout not be found, "Not found" is inserted.
" function! <SID>InsertGitHubUserInfo() abort
"     let user = expand('<cWORD>')
"     " final slice is to remove ending newline
"     let info = system('github_user_info ' . user . ' 2> /dev/null')[:-2]
"     if v:shell_error
"         let info = 'Not found'
"     endif
"     execute "normal! diWa" . info . "\<esc>"
" endfunction
"
" nnoremap <silent> <leader>gu :call <SID>InsertGitHubUserInfo()<cr>
"
" nnoremap <silent> #    <C-^>
"
