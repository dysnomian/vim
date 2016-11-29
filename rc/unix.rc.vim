"---------------------------------------------------------------------------
" For UNIX:
"

" Use sh instead of fish because Vim plays poorly with non-POSIX shells.
set shell=/bin/bash

" Set path.
let $PATH = expand('~/bin').':/usr/local/bin/:'.$PATH

if has('gui_running')
  finish
endif

let g:iterm_theme = $ITERM_PROFILE

"---------------------------------------------------------------------------
" For CUI:
"

" Enable 256 color terminal.
setglobal t_Co=256

if &term =~# 'xterm' && !has('nvim')
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function! XTermPasteBegin(ret) abort
    setlocal paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin('0i')
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin('')
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>

  " Optimize vertical split.
  " Note: Newest terminal is needed.
  " let &t_ti .= "\e[?6;69h"
  " let &t_te .= "\e7\e[?6;69l\e8"
  " let &t_CV = "\e[%i%p1%d;%p2%ds"
  " let &t_CS = "y"

  " Change cursor shape.
  let &t_SI = "\<Esc>]12;lightgreen\x7"
  let &t_EI = "\<Esc>]12;white\x7"
endif

" Using the mouse on a terminal.
if has('mouse') && !has('nvim')
  setglobal mouse=a
  if has('mouse_sgr') || v:version > 703 ||
        \ v:version == 703 && has('patch632')
    setglobal ttymouse=sgr
  else
    setglobal ttymouse=xterm2
  endif

  " Paste.
  nnoremap <RightMouse> "+p
  xnoremap <RightMouse> "+p
  inoremap <RightMouse> <C-r><C-o>+
  cnoremap <RightMouse> <C-r>+
endif

" Colorscheme
if has('gui')
  if !exists('g:colors_name')
    execute 'colorscheme' globpath(&runtimepath,
          \ 'colors/' + 'fairyfloss') != '' ? 'fairyfloss' : 'desert'
  endif
elseif has('nvim') && $NVIM_TUI_ENABLE_TRUE_COLOR != ''
  " Use true color feature
  execute 'colorscheme fairyfloss'
  " Use italics for comments.
  set t_ZH=^[[3m
  set t_ZR=^[[23m
  highlight Comment cterm=italic
else
  " Use guicolorscheme.vim
  autocmd MyAutoCmd VimEnter,BufAdd *
        \ if !exists('g:colors_name') | GuiColorScheme fairyfloss

  " Disable error messages.
  let g:CSApprox_verbose_level = 0
endif

