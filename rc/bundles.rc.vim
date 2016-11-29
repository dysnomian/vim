if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" General
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'editorconfig/editorconfig-vim'

" TESTING A PYTHON PLUGIN
" NOTE: remove whenever
" Plug 'nvim-example-python-plugin'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'
Plug 'tpope/vim-dispatch'

" Navigation
Plug 'ctrlpvim/ctrlp.vim' |
      \ Plug 'lambdalisue/vim-gista-ctrlp', { 'on': 'CtrlPGista' }
Plug 'tyru/open-browser.vim'
Plug 'rhysd/accelerated-jk'
Plug 'bkad/CamelCaseMotion'
Plug 'Konfekt/FastFold'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/vim-easy-align'
Plug 'cyphactor/vim-open-alternate'
Plug 'craigemery/vim-autotag'

""" Side panel utilities
Plug 'majutsushi/tagbar'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } |
      \ Plug 'Xuyuanp/nerdtree-git-plugin'

" Syntax
Plug 'scrooloose/syntastic'
Plug 'scrooloose/syntastic' |
      \ Plug 'myint/syntastic-extras',
      \      { 'for': ['c', 'cpp', 'gnumake', 'json', 'yaml'] }

" Presentation
Plug 'reedes/vim-thematic'

Plug 'tomasr/molokai'
Plug 'reedes/vim-colors-pencil'
Plug 'sjl/badwolf'
Plug 'nanotech/jellybeans.vim'
Plug 'sheerun/vim-wombat-scheme'
Plug 'altercation/vim-colors-solarized'
Plug 'dysnomian/fairyfloss.vim'
Plug 'dysnomian/vim-colors-puellamagi'

Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'dysnomian/vim-airline-themes'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'junegunn/vim-emoji'
Plug 'airblade/vim-gitgutter'
Plug 'reedes/vim-thematic'
" Plug 'edkolev/tmuxline.vim'
Plug 'chrisbra/Colorizer'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" GUI
if !has('terminal')
  Plug 'thinca/vim-guicolorscheme'
  Plug 'godlygeek/csapprox'
endif

" Formatting
Plug 'junegunn/vim-easy-align'
Plug 'tyru/caw.vim'
Plug 'tpope/vim-surround'
Plug 'lambdalisue/vim-findent'
Plug 'Chiel92/vim-autoformat'
Plug 'sheerun/vim-polyglot'

" Tab completion
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } |
"       \ Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Shell
Plug 'dysnomian/neoterm'
Plug 'neomake/neomake'

" Git
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-fugitive'
Plug 'thinca/vim-ft-diff_fold'

" Language-Specific

""" C++
Plug 'osyo-manga/vim-marching', { 'for': ['c', 'cpp'] }
Plug 'vim-jp/cpp-vim', { 'for': 'cpp' }

""" Clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }
Plug 'rkneufeld/vim-boot', { 'for': 'clojure' }
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }


""" Coffeescript
Plug 'kchmck/vim-coffee-script'

""" CSS/Sass
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'less'] }

""" Elixir
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }

""" Erlang
Plug 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-compiler', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-tags', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-omnicomplete', { 'for': 'erlang' }

""" Elm
Plug 'ElmCast/elm-vim', { 'for': 'elm' }

""" Emily
Plug 'dysnomian/vim-emily', { 'for': 'emily' }

""" Fish
Plug 'dag/vim-fish', { 'for': 'fish' }

""" Java
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }

""" Javascript
Plug 'mxw/vim-jsx', { 'for': 'javascript'}
Plug 'jiangmiao/simple-javascript-indenter',
      \ { 'do': 'npm install -g karma-cli', 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'maksimr/vim-karma', { 'for': 'javascript' }
Plug 'burnettk/vim-angular', { 'for': 'javascript' }

""" JSON
Plug 'elzr/vim-json', { 'for': 'json' }

""" Go
Plug 'fatih/vim-go', { 'for': 'go' } | Plug 'nsf/gocode'

""" Haskell
Plug 'itchyny/vim-haskell-indent', { 'for': 'vim' }

""" Lua
Plug 'xolox/vim-misc', { 'for': 'lua' }
Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }

""" Markdown
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-markdown',       { 'for': ['markdown', 'mkd'] }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tyru/open-browser.vim' |
      \ Plug 'kannokanno/previm', { 'for': ['markdown', 'mkd'] }

""" Org Mode
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'

""" PHP
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }

""" Python
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

""" Ren'Py
Plug 'chaimleib/vim-renpy'

""" Ruby
Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }

""" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'rhysd/rust-doc.vim', { 'for': 'rust' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

""" Tmux
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

""" Scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

""" Slim
Plug 'slim-template/vim-slim'

""" Swift
Plug 'kballard/vim-swift', { 'for': 'swift' }

""" Vimscript
Plug 'scrooloose/syntastic' | Plug 'dbakker/vim-lint', { 'for': 'vim' }

call plug#end()
