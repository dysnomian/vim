"---------------------------------------------------------------------------
" Edit:
"

" Smart insert tab setting.
setglobal smarttab
" Exchange tab to spaces.
setglobal expandtab
" Substitute <Tab> with blanks.
setglobal tabstop=2
" Spaces instead <Tab>.
setglobal softtabstop=2
" Autoindent width.
setglobal shiftwidth=2
" Round indent by shiftwidth.
setglobal shiftround

" Enable modeline.
setglobal modeline

" Highlight cursor line in active window only
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd WinLeave * setlocal nocursorcolumn
augroup END

" Use clipboard register.
if has('unnamedplus')
  setglobal clipboard& clipboard+=unnamedplus
else
  setglobal clipboard& clipboard+=unnamed
endif

" Enable backspace delete indent and newline.
setglobal backspace=indent,eol,start

" Highlight parenthesis.
setglobal showmatch
" Highlight when CursorMoved.
setglobal cpoptions-=m
setglobal matchtime=1
" Highlight <>.
setglobal matchpairs+=<:>

" Display another buffer when current buffer isn't saved.
setglobal hidden

" Ignore case on insert completion.
setglobal infercase

" Enable folding.
setglobal foldenable
" set foldmethod=expr
setglobal foldmethod=marker
" Show folding level.
setglobal foldcolumn=1
setglobal fillchars=vert:\|
setglobal commentstring=%s

" Use grep.
setglobal grepprg=grep\ -inH

" Exclude = from isfilename.
setglobal isfname-==

" Keymapping timeout.
setglobal timeout timeoutlen=3000 ttimeoutlen=100

" CursorHold time.
setglobal updatetime=1000

" Set swap directory.
setglobal directory-=.

if v:version >= 703
  " Set undofile.
  setglobal undofile
  let &g:undodir=&directory
endif

if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  " Vim's bug.
  setglobal notagbsearch
endif

" Enable virtualedit in visual block mode.
setglobal virtualedit=block

" Set keyword help.
setglobal keywordprg=:help

" Check timestamp more for 'autoread'.
autocmd MyAutoCmd WinEnter * checktime

" Disable paste.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | setlocal nopaste mouse=a | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Update diff.
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

" Make directory automatically.
" --------------------------------------
" http://vim-users.jp/2011/02/hack202/

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
