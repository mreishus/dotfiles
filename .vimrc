:set guioptions-=m  "remove menu bar
:set guioptions+=M  "remove menu bar menu.vim
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
:set guioptions-=e  "remove gui tab
:set guioptions+=c  "use console

let g:ascii = [
    \ '        __',
    \ '.--.--.|__|.--.--.--.',
    \ '|  |  ||  ||        |',
    \ ' \___/ |__||__|__|__|',
    \ ''
    \]
let g:startify_custom_header =
        \ 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'

""" BEGIN vim-plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
""" END vim-plug autoinstall

call plug#begin('~/.vim/plugged')

""" Airline - status bar

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" do not show the buffer when only one tab exists
let g:airline#extensions#tabline#show_buffers=0

""" File Searching

"Plug 'ctrlpvim/ctrlp.vim/' " Outdone by FZF
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'
"let g:ctrlp_custom_ignore = {
"\ 'dir': 'tmp',
"\ }
"let g:ctrlp_clear_cache_on_exit = 0 " persistant cache
"let g:ctrlp_max_height = 20
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'window': '-tabnew' } " Helps on windows gvim? Not sure.
nnoremap <c-p> :FZF<cr>

""" Searching

Plug 'jremmen/vim-ripgrep'

""" Syntax checking

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }
"set rtp+=~/.vim/pack/XXX/start/LanguageClient-neovim
let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

Plug 'w0rp/ale'
let g:ale_lint_on_save = 1

let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 250

" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0

" disable the Ale HTML linters
" Disable flow for javascript
"let g:ale_linters = {
"\   'html': [],
"\   'javascript': ['eslint'],
"\}
"let g:ale_set_highlights = 0

let g:ale_linters = {
  \   'elixir': ['credo', 'mix'],
  \}
let g:ale_fixers = {
  \   'javascript': [
  \       'prettier', 'eslint'
  \   ],
  \   'elixir': [
  \       'mix_format',
  \   ],
  \}
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:airline#extensions#ale#enabled = 1

""" File Tree - Nerd Tree (ctrl-n)

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
map <C-n> :NERDTreeTabsToggle<cr>
"let g:NERDTreeHijackNetrw=0
let g:nerdtree_tabs_open_on_gui_startup=0

""" Enhance editor commands

Plug 'wellle/targets.vim'
Plug 'tpope/vim-fugitive'
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>ge :Gedit<cr>
nnoremap <leader>gs :Gstatus<cr>
Plug 'tpope/vim-surround/' 
Plug 'tpope/vim-sleuth'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

""" Filetypes

Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-haml'
Plug 'wavded/vim-stylus'
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
" let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
" let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
" let g:javascript_conceal_noarg_arrow_function = "🞅"
" let g:javascript_conceal_underscore_arrow_function = "🞅"
" set conceallevel=1
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
Plug 'OrangeT/vim-csharp'

"""  Color schemes

Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'tomasr/molokai'
Plug 'sjl/badwolf'
Plug 'gregsexton/Muon'
Plug 'altercation/vim-colors-solarized'
Plug 'mreishus/vim-mnemosyne'
Plug 'mreishus/vim-astraios'

""" Session related

Plug 'mhinz/vim-startify'
nnoremap <leader>s :Startify<CR>
Plug 'tpope/vim-obsession'
if has('win32') || has('win64')
	nnoremap <leader>o :Obsess $HOME\vimfiles\session\
else
	nnoremap <leader>o :Obsess ~/.vim/session/
endif
nnoremap <leader>O :Obsess!

""" Snippets
"Disabled while working out deoplete setup
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" Tabnine completion
Plug 'zxqfl/tabnine-vim'

" Sonic-pi
Plug 'dermusikman/sonicpi.vim'

" Pandoc

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
let g:pandoc#modules#disabled = [ "spell", "folding" ]

""" Disabled Plugs


""" Disabled Plugs

"Plug 'maksimr/vim-jsbeautify'
"Plug 'puppetlabs/puppet-syntax-vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'mattn/webapi-vim'
"Plug 'mattn/gist-vim'
"Plug 'goldfeld/vim-seek'
"Plug 'joonty/vdebug'

"NerdCommenter - comment block commands
"Plug 'scrooloose/nerdcommenter'

"TagBar - ctags support
"Plug 'majutsushi/tagbar'
" tagbars config
let g:tagbar_autofocus = 1   " auto focus after opening tagbar
let g:tagbar_autoclose = 1   " auto close after choosing a tag

"todo: usetagbar to figure out the current view to open
"function! sdfg()
    "let l:foo = tagbar#currenttag('%s', '')
"endfunction

"Matchit - % bounces on html tags
"Plug 'vim-scripts/matchit.zip'

"Gundo - Visual undo tree
"Plug 'http://github.com/sjl/gundo.vim.git'

"Dispatch - Run Tests in background
"Plug 'tpope/vim-dispatch'

"SimpleNote Sync
"Plug 'mrtazz/simplenote.vim'
" Simplenote password goes in here (s3kr3t, not managed by git)
"if filereadable($HOME."/.vim-simplenoterc")
"    exec ":source ". $HOME . "/.vim-simplenoterc"
"endif
"nnoremap <leader>l :Simplenote -l<CR>
"nnoremap <leader>n :Simplenote -n<CR>


"Autoclose - Automatically close brackets - not worth it imo
"Plug 'Townk/vim-autoclose/'

"Evervim - evernote integration - doesn't seem to work.
"Plug 'kakkyz81/evervim'

"Supertab - Changes the way ^n/^p works, no me gusta
"Plug 'ervandew/supertab'

"clang_complete - only for c/c++, no use for now.
"Plug 'Rip-Rip/clang_complete'
"sudo apt-get install libclang1 libclang-dev

"Vim pad - Note taking - I like the idea but it's buggy atm.
"Plug 'fmoralesc/vim-pad'
" vimpad
"let g:pad_dir = "~/notes/"
"let g:pad_format = "text"
"let g:pad_window_height = 12
"let g:pad_search_backend = "ack"

" Zen mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <leader>z :Goyo<CR>

" Sneak
Plug 'justinmk/vim-sneak'

call plug#end()

"basics
set nocompatible   " don't be compatible with vi
set vb t_vb=       " visual bell off
if has("autocmd") && has("gui")
    au GUIEnter * set t_vb=
endif
set encoding=utf-8 " utf8

"files
set backup                     " make backups
if has('win32') || has('win64')
    set backupdir=$HOME/vimbackup// " backups go here
else
    set backupdir=~/.backup//,/tmp//   " backups go here
endif

"search
set hlsearch    " highlight search results
set ignorecase  " case insenstive search
set smartcase   " .. unless there's a capital

"tabs/indent
set autoindent     " auto/smart indent
set bs=2           " smart backspace
set tabstop=4      " indent is 4 chars wide
set shiftwidth=4   " << >> use 4
set shiftround     " << >> find the nearest 'tabstop'
set smarttab       " pressing tab also rounds to nearest (?unsure if i should keep this?)
"" These are commented out because I'm using vim-sleuth.
"set noexpandtab    " put tabs in files.
set expandtab      " don't put tabs in files, convert to spaces.
set softtabstop=4  " also use this when using spaces.

" interface
set laststatus=2 " always show status line
set ruler        " show character position
set title        " set window title
set number       " line numbers
set wildmenu                  " better completion
set wildmode=list:longest     " show lots of stuff
set nolist                    " hidden characters off by default
"set listchars=eol:¬,extends:»,tab:»\ ,trail:›
set showmatch                 " show matching brackets
set showcmd                   " show when typing leader, etc.
set ttyfast                   " fast connection
set scrolloff=3               " keep 3 lines on the screen when scrolling

" make search results appear in the middle of the screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" i can't type
map :W :w
map :Q :q

" allow cross-session copy paste with _Y _P
if has('win32') || has('win64')
    nmap    _Y      :!echo ""> $HOME/_vi_tmp<CR><CR>:w! $HOME/_vi_tmp<CR>
    vmap    _Y      :w! $HOME/_vi_tmp<CR>
    nmap    _P      :r $HOME/_vi_tmp<CR>
else
    nmap    _Y      :!echo ""> ~/.vi_tmp<CR><CR>:w! ~/.vi_tmp<CR>
    vmap    _Y      :w! ~/.vi_tmp<CR>
    nmap    _P      :r ~/.vi_tmp<CR>
endif

" color, syntax highlighting
au BufRead,BufNewFile *.ctp setfiletype phtml " ctp, must be before filetype plugin. not 100%, % doesn't work on tags..
filetype plugin indent on                   " enable ft+plugin detect
syntax on                                   " syntax highlighting
set t_Co=256                                " 256-colors
set background=dark                         " we're using a dark bg

"" Need to test/consolidate these conemu sections

" I think this is the w/o chcp 65001 section
if !empty($CONEMUBUILD)
	set term=pcansi
	set t_Co=256
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
	set bs=indent,eol,start
endif

" ConEmu
" for this section, you must run "chcp 65001" before running vim
if !empty($CONEMUBUILD)
    " echom "Running in conemu"
    set termencoding=utf8
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
    " termcap codes for cursor shape changes on entry and exit to
    " /from insert mode
    " doesn't work
    "let &t_ti="\e[1 q"
    "let &t_SI="\e[5 q"
    "let &t_EI="\e[1 q"
    "let &t_te="\e[0 q"
endif

let g:solarized_termcolors=256
"let g:jellybeans_use_lowcolor_black = 1
"colors jellybeans                           " select colorscheme
"colors hybrid
"colors Tomorrow-Night
"colors Tomorrow-Night-Eighties
"colors Tomorrow-Night-Blue
"colors Tomorrow-Night-Bright
"colors mnemosyne
colors astraios

"highlight Normal ctermbg=NONE               " use terminal background
"highlight nonText ctermbg=NONE              " use terminal background
"highlight Search ctermfg=0 ctermbg=102      " i don't like jellybeans default search higlighting colors

au BufRead,BufNewFile *.txt set ft=sh       " opens .txt w/highlight

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/obj/*,*/node_modules/*

" tabs
nnoremap <C-t> :tabnew<cr>
nnoremap <C-y> :tabclose<cr>

" misc filetype
autocmd FileType sass setlocal noexpandtab shiftwidth=4 softtabstop=4 " Use tabs in sass (must be after filetype)
autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2 " Ruby uses spaces with indent width of 2
autocmd FileType * setlocal formatoptions-=ro " Disable auto comments (must be after filetype)

" clear search highlighting
noremap <silent><leader><space> :nohls<CR>

" f keys
set pastetoggle=<F1>                                    " f1 toggles paste
"nnoremap <F2> :AutoCloseToggle<cr>                      " f2 toggles autoclose
nnoremap <F5> :set nonumber!<cr>:set foldcolumn=0<cr>   " f5 toggles line numbers
nnoremap <F6> :set list!<cr>                            " f6 toggles list
"nnoremap <F8> :TagbarToggle<cr>                         " f8 toggles tagbar
"nnoremap <F9> :GundoToggle<cr>                          " f9 toggles Gundo

" \W strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>4 :set tabstop=4<CR>:set shiftwidth=4<CR>
nnoremap <leader>ve :tabe $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>
" \z close all other tabs
" nnoremap <leader>z :w <bar> %bd <bar> e#<CR>

if has("gui_running")
    "set guifont=Fantasque_Sans_Mono:h12:cANSI
    "set guifont=Fantasque_Sans_Mono:h12:cANSI
    "set guifont=Iosevka_Term:h12:cANSI:qDRAFT
    set guifont=Iosevka\ Term\ 14
    "set renderoptions=type:directx " vim isn't compiled with it
    "set guiFont=Fira_Code:h11:cANSI:qDRAFT
endif

" Guifont Fantasque Sans Mono:h12
set noincsearch

set backupcopy=yes "For webpack
set tabpagemax=100

" My work laptop needs this to make vimdiff work?
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = ''
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  silent execute '!"'.$VIMRUNTIME.'\diff" -a ' . opt . v:fname_in . ' ' . v:fname_new . ' > ' . v:fname_out
"endfunction

"" For my mac only
set rtp+=/usr/local/opt/fzf

" Tweak
highlight ALEWarning ctermbg=DarkMagenta
highlight ALEError  ctermbg=DarkMagenta
"highlight SpellBad  ctermbg=DarkMagenta ctermfg=249
highlight SpellBad  ctermbg=1 ctermfg=0

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Open folds when opening file
"au BufRead * normal zR
autocmd BufWinEnter * silent! :%foldopen!

hi ALEWarning ctermbg=4

" When I'm working on markdown, I use these
" :set tw=72 fo=cqt wm=0
" :let g:ycm_auto_trigger = 0
