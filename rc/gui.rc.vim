"---------------------------------------------------------------------------
" GUI:
"

"---------------------------------------------------------------------------
" Fonts: "{{{
setglobal ambiwidth=double

if has('win32') || has('win64')
  " For Windows.

  setglobal guifont=Anonymous\ Pro:h14
  "setglobal guifont=Courier\ New:h11
  "setglobal guifont=MS\ Gothic:h11
  "setglobal guifont=VL\ Gothic:h11
  "setglobal guifont=Consolas:h12
  "setglobal guifont=Bitstream\ Vera\ Sans\ Mono:h11
  "setglobal guifont=Inconsolata:h12
  "setglobal guifont=Terminal:h10:cSHIFTJIS

elseif has('mac')
  " For Mac.
  set macligatures
  set guifont=Fira\ Code:h12  setglobal guifont=Anonymous\ Pro:h14
else
  " For Linux.
  setglobal guifontwide=VL\ Gothic\ 13
  setglobal guifont=Courier\ 10\ Pitch\ 13.5
endif"}}}

"---------------------------------------------------------------------------
" Window:"{{{
"
if has('win32') || has('win64')
  " Width of window.
  setglobal columns=230
  " Height of window.
  setglobal lines=55

  " Set transparency.
  "autocmd GuiEnter * set transparency=221
  " Toggle font setting.
  command! TransparencyToggle let &transparency =
        \ (&transparency != 255 && &transparency != 0)? 255 : 221
  nnoremap TT     :<C-u>TransparencyToggle<CR>
else
  " Width of window.
  setglobal columns=170
  " Height of window.
  setglobal lines=40
endif

" Don't override colorscheme.
if !exists('g:colors_name')
  execute 'colorscheme' globpath(&runtimepath,
        \ 'colors/candy.vim') != '' ? 'molokai' : 'desert'
endif
"}}}

"---------------------------------------------------------------------------
" Mouse:"{{{
"
setglobal mouse=
setglobal mousemodel=

" Don't focus the window when the mouse pointer is moved.
setglobal nomousefocus
" Hide mouse pointer on insert mode.
setglobal mousehide
"}}}

"---------------------------------------------------------------------------
" Menu:"{{{
"

" Hide toolbar and menus.
setglobal guioptions-=Tt
setglobal guioptions-=m
" Scrollbar is always off.
setglobal guioptions-=rL
" Not guitablabel.
setglobal guioptions-=e

" Confirm without window.
setglobal guioptions+=c
"}}}

"---------------------------------------------------------------------------
" Views:"{{{
"
" Don't highlight search result.
setglobal nohlsearch

" Don't flick cursor.
setglobal guicursor&
setglobal guicursor+=a:blinkon0
"}}}

" vim: foldmethod=marker
