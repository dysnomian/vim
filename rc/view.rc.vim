"---------------------------------------------------------------------------
" View:
"

" Anywhere SID.
function! s:SID_PREFIX() abort
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Show line number.
set number
set numberwidth=5

" Leave space before and after first line
set scrolloff=10  " Leave space before and after selected line

" Show <TAB> and <CR>
setglobal list
if IsWindows()
  setglobal listchars=tab:>-,trail:-,extends:>,precedes:<
else
  setglobal listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
endif

" Turn down a long line appointed in 'breakat'
setglobal linebreak
setglobal showbreak=\
setglobal breakat=\ \	;:,!?
" Wrap conditions.
setglobal whichwrap+=h,l,<,>,[,],b,s,~
if exists('+breakindent')
  setglobal breakindent
  setglobal wrap
else
  setglobal nowrap
endif

" Do not display greetings message at the time of Vim start.
setglobal shortmess=aTI

" Don't create backup.
setglobal nowritebackup
setglobal nobackup
setglobal noswapfile
setglobal backupdir-=.

" Disable bell.
setglobal t_vb=
setglobal noeb
setglobal novisualbell

" Display candidate supplement.
setglobal nowildmenu
setglobal wildmode=list:longest,full
" Increase history amount.
setglobal history=1000
" Display all the information of the tag by the supplement of the Insert mode.
setglobal showfulltag
" Can supplement a tag in a command-line.
setglobal wildoptions=tagfile

" Disable menu
let g:did_install_default_menus = 1

" Set color column at 80 chars
set colorcolumn=80
call matchadd('ColorColumn', '\%81v', 100)

" Splitting a window will put the new window below the current one.
setglobal splitbelow
" Splitting a window will put the new window right the current one.
setglobal splitright

" Set minimal width for current window.
setglobal winwidth=30
" Set minimal height for current window.
" set winheight=20
setglobal winheight=1
" Set maximum command line window.
setglobal cmdwinheight=5
" No equal window size.
setglobal noequalalways

" Adjust window size of preview and help.
setglobal previewheight=8
setglobal helpheight=12

setglobal ttyfast

" When a line is long, do not omit it in @.
setglobal display=lastline
