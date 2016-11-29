"---------------------------------------------------------------------------
" FileType:
"

" Enable smart indent.
setglobal autoindent smartindent

  au BufRead,BufNewFile *.pxi setfiletype clojure
  au BufRead,BufNewFile *.boot setfiletype clojure
  au BufRead,BufNewFile boot.properties setfiletype clojure

augroup MyAutoCmd
  autocmd FileType,Syntax,BufEnter,BufWinEnter * call s:my_on_filetype()

  autocmd FileType gitcommit,qfreplace setlocal nofoldenable

  autocmd FileType ref nnoremap <buffer> <TAB> <C-w>w

  autocmd FileType python setlocal foldmethod=indent


  augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
  augroup END


  autocmd Filetype clojure :Thematic clojure

  autocmd FileType fish
        \ " Set up :make to use fish for syntax checking.
        \ compiler fish
        \ " Set this to have long lines wrap inside comments.
        \ setlocal textwidth=79
        \ " Enable folding of block structures in fish.
        \ setlocal foldmethod=expr

  " Update filetype.
  autocmd BufWritePost *
        \ if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

  " Improved include pattern.
  autocmd FileType html
        \ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
        \ setlocal path+=./;/

  autocmd FileType go highlight default link goErr WarningMsg |
        \ match goErr /\<err\>/


  autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

augroup END

augroup vimrc-highlight
  autocmd!
  autocmd Syntax * if 5000 < line('$') | syntax sync minlines=100 | endif
augroup END

" Python
let g:python_highlight_all = 1

" Vim
let g:vimsyntax_noerror = 1
"let g:vim_indent_cont = 0

" Bash
let g:is_bash = 1

" Clojure
let g:clojure_syntax_keywords = {
      \ 'clojureMacro': ["defproject", "defcustom"],
      \ 'clojureFunc': ["string/join", "string/replace"]
      \ }

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1

" JavaScript
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Markdown
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft', 'textwidth': 80})
        \ | setl fdo+=search
        \ | :Thematic markdown
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
        \   call pencil#init({'wrap': 'hard', 'textwidth': 72})
        \ | :Thematic markdown
  autocmd Filetype mail         call pencil#init({'wrap': 'hard', 'textwidth': 60})
  autocmd Filetype html,xml     call pencil#init({'wrap': 'soft'})
augroup END

let g:pencil#autoformat_config = {
      \   'markdown': {
      \     'black': [
      \       'htmlH[0-9]',
      \       'markdown(Code|H[0-9]|Url|IdDeclaration|Link|Rule|Highlight[A-Za-z0-9]+)',
      \       'markdown(FencedCodeBlock|InlineCode)',
      \       'mkd(Code|Rule|Delimiter|Link|ListItem|IndentCode)',
      \       'mmdTable[A-Za-z0-9]*'
      \     ],
      \     'white': [
      \      'markdown(Code|Link)'
      \     ]
      \   }
      \ }

let g:markdown_fenced_languages = []
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
let g:pencil#autoformat = 1      " 0=manual, 1=auto (def)
let g:pencil#textwidth = 74
let g:airline_section_x = '%{PencilMode()}'

" Go
if $GOROOT != ''
  setglobal runtimepath+=$GOROOT/misc/vim
endif

" Tex
let g:tex_flavor = 'latex'

" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = [
      \  'coffee',
      \  'css',
      \  'erb=eruby',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'sass',
      \  'xml',
      \  'vim',
      \]

" Syntax highlight for user commands.
augroup syntax-highlight-extends
  autocmd!
  autocmd Syntax vim
        \ call s:set_syntax_of_user_defined_commands()
augroup END

function! s:set_syntax_of_user_defined_commands() "{{{
  redir => _
  silent! command
  redir END

  let command_names = join(map(split(_, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if command_names == '' | return | endif

  execute 'syntax keyword vimCommand ' . command_names
endfunction"}}}

function! s:my_on_filetype() abort "{{{
  " Disable automatically insert comment.
  setl formatoptions-=ro | setl formatoptions+=mMBl

  " Disable auto wrap.
  if &l:textwidth != 70 && &filetype !=# 'help'
    setlocal textwidth=0
  endif

  " Use FoldCCtext().
  if &filetype !=# 'help'
    setlocal foldtext=FoldCCtext()
  endif

  if !&l:modifiable
    setlocal nofoldenable
    setlocal foldcolumn=0
    silent! IndentLinesDisable

    if v:version >= 703
      setlocal colorcolumn=
    endif
  endif
endfunction "}}}
