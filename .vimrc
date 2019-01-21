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

filetype off

""" BEGIN Vundle autoinstall
let isVundleInstalled=1

if has('win32') || has('win64')
    let vundle_readme=expand('$HOME/vimfiles/bundle/vundle/README.md')
else
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
endif

if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    if has('win32') || has('win64')
        silent !mkdir -p $HOME/vimfiles/bundle
        silent !git clone https://github.com/gmarik/vundle $HOME/vimfiles/bundle/vundle
    else
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    endif
    let isVundleInstalled=0
endif

if has('win32') || has('win64')
    set rtp+=$HOME/vimfiles/bundle/vundle/
    call vundle#rc('$HOME/vimfiles/bundle')
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
endif
Bundle 'gmarik/vundle'
""" END Vundle autoinstall (also see bottom of file)

""""""""""""""""""

""" Airline - status bar

Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" do not show the buffer when only one tab exists
let g:airline#extensions#tabline#show_buffers=0

""" File Searching

"Bundle 'https://github.com/ctrlpvim/ctrlp.vim/' " Outdone by FZF
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'
"let g:ctrlp_custom_ignore = {
"\ 'dir': 'tmp',
"\ }
"let g:ctrlp_clear_cache_on_exit = 0 " persistant cache
"let g:ctrlp_max_height = 20
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'
let g:fzf_layout = { 'window': '-tabnew' } " Helps on windows gvim? Not sure.
nnoremap <c-p> :FZF<cr>

""" Searching

Bundle 'jremmen/vim-ripgrep'

""" Syntax checking

"Bundle 'https://github.com/vim-syntastic/syntastic' " Trying ALE
"let g:syntastic_javascript_checkers = ['eslint']

"Bundle 'https://github.com/neomake/neomake'         " Trying ALE
"let g:neomake_javascript_enabled_makers = ['eslint']
"augroup my_neomake_signs
"    au!
"    autocmd ColorScheme *
"        \ hi NeomakeErrorSign ctermfg=white |
"        \ hi NeomakeWarningSign ctermfg=yellow
"augroup END
"let g:neomake_error_sign = {'text': 'x', 'texthl': 'ErrorMsg'}
"let g:neomake_warning_sign = {
"    \   'text': 'W',
"    \   'texthl': 'NeomakeWarningSign',
"    \ }
"let g:neomake_message_sign = {
"    \   'text': '➤',
"    \   'texthl': 'NeomakeMessageSign',
"    \ }
"let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}

"autocmd! BufWritePost,BufEnter * Neomake

Bundle 'w0rp/ale'
let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 'always'
" let g:ale_lint_delay = 250
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" disable the Ale HTML linters
" Disable flow for javascript
"let g:ale_linters = {
"\   'html': [],
"\   'javascript': ['eslint'],
"\}
"let g:ale_set_highlights = 0
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = [
\ 'prettier', 'eslint'
\]
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:airline#extensions#ale#enabled = 1

""" File Tree - Nerd Tree (ctrl-n)

Bundle 'https://github.com/scrooloose/nerdtree'
Bundle 'https://github.com/jistr/vim-nerdtree-tabs'
map <C-n> :NERDTreeTabsToggle<cr>
"let g:NERDTreeHijackNetrw=0
let g:nerdtree_tabs_open_on_gui_startup=0

""" Enhance editor commands

Bundle 'wellle/targets.vim'
Bundle 'https://github.com/tpope/vim-fugitive'
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>ge :Gedit<cr>
nnoremap <leader>gs :Gstatus<cr>
Bundle 'https://github.com/tpope/vim-surround/' 
Bundle 'https://github.com/tpope/vim-sleuth'
Bundle 'https://github.com/airblade/vim-gitgutter'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

""" Filetypes

Bundle 'elixir-editors/vim-elixir'
Bundle 'https://github.com/tpope/vim-haml'
Bundle 'https://github.com/wavded/vim-stylus'
Bundle 'https://github.com/pangloss/vim-javascript'
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
Bundle 'https://github.com/mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
Bundle 'https://github.com/OrangeT/vim-csharp'

"""  Color schemes

Bundle 'https://github.com/nanotech/jellybeans.vim'
Bundle 'https://github.com/w0ng/vim-hybrid'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'https://github.com/tomasr/molokai'
Bundle 'https://github.com/sjl/badwolf'
Bundle 'https://github.com/gregsexton/Muon'
Bundle 'https://github.com/altercation/vim-colors-solarized'
Bundle 'https://github.com/mreishus/vim-mnemosyne'
Bundle 'https://github.com/mreishus/vim-astraios'

""" Session related

Bundle 'https://github.com/mhinz/vim-startify'
nnoremap <leader>s :Startify<CR>
Bundle 'https://github.com/tpope/vim-obsession'
if has('win32') || has('win64')
	nnoremap <leader>o :Obsess $HOME\vimfiles\session\
else
	nnoremap <leader>o :Obsess ~/.vim/session/
endif
nnoremap <leader>O :Obsess!

""" Snippets
"Disabled while working out deoplete setup
"Bundle 'https://github.com/SirVer/ultisnips'
"Bundle 'https://github.com/honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

""" Flowtype (does this work better than ale's?)
" Right now, I disabled its syncronous checking, and I'm only using it for
" ^X ^O, which seems to be working better than Deoplete's
" As well as \ft = :FlowType
let g:flow#flowpath="C:\\dev\\redacted\\redacted\\node_modules\\flow-bin\\flow-win64-v0.59.0\\flow.exe"
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

let g:flow#enable = 0
let g:flow#timeout = 10
let g:flow#showquickfix = 0
Bundle 'flowtype/vim-flow'
nnoremap <leader>ft :FlowType<CR>

""" Autocomplete
" This takes quite a bit of setup, and I'm not yet sure how to 
" trigger the popup menu quickly
"Bundle 'Shougo/deoplete.nvim'
"Bundle 'roxma/nvim-yarp'
"Bundle 'roxma/vim-hug-neovim-rpc'
" On windows, get python3
" 0. Install chocolately.
" 1. If you installed vim on your own, uninstall it and run "choco install vim".
" 2. choco install python3 --version 3.5.4
" 3. choco pin add -n=python3 --version 3.5.4
" 4. Add C:\python35 to path and run refreshenv in powershell
" 5. Copy C:\Python35\python.exe to C:\Python35\python3.exe 
" 6. C:\Python35\Scripts\pip.exe install neovim
" Wasn't that easy?

"let g:deoplete#complete_method="omnifunc"
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1

" Try this completion.. 
Bundle 'zxqfl/tabnine-vim'

" Press C-Y to accept a completion.

" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction

" Pressing tab invokes manual deoplete
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Both of these seem less useful than flow-type's ^X^O? 
Bundle 'wokalski/autocomplete-flow'
"let g:deoplete#sources#flow#flow_bin="C:\\dev\\OAP\\OmniActivation\\node_modules\\flow-bin\\flow-win64-v0.59.0\\flow.exe"
"Bundle 'steelsojka/deoplete-flow'

" Pandoc

Bundle 'vim-pandoc/vim-pandoc'
Bundle 'vim-pandoc/vim-pandoc-syntax' 
let g:pandoc#modules#disabled = [ "spell" ]

Bundle 'junegunn/goyo.vim'
nnoremap <leader>gg :Goyo<cr>

""" Disabled Bundles


""" Disabled Bundles

"Bundle 'https://github.com/maksimr/vim-jsbeautify'
"Bundle 'puppetlabs/puppet-syntax-vim'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'https://github.com/mattn/webapi-vim'
"Bundle 'https://github.com/mattn/gist-vim'
"Bundle 'https://github.com/goldfeld/vim-seek'
"Bundle 'https://github.com/joonty/vdebug'

"NerdCommenter - comment block commands
"Bundle 'https://github.com/scrooloose/nerdcommenter'

"TagBar - ctags support
"Bundle 'https://github.com/majutsushi/tagbar'
" tagbars config
let g:tagbar_autofocus = 1   " auto focus after opening tagbar
let g:tagbar_autoclose = 1   " auto close after choosing a tag

" turn off variables for php
let g:tagbar_type_php = {
    \ 'kinds' : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions:0:0',
        \ 'f:functions',
        \ 'j:javascript functions',
    \ ],
\ }
"todo: usetagbar to figure out the current view to open
"function! sdfg()
    "let l:foo = tagbar#currenttag('%s', '')
"endfunction

"Matchit - % bounces on html tags
"Bundle 'vim-scripts/matchit.zip'

"Gundo - Visual undo tree
"Bundle 'http://github.com/sjl/gundo.vim.git'

"Dispatch - Run Tests in background
"Bundle 'https://github.com/tpope/vim-dispatch'

"SimpleNote Sync
"Bundle 'https://github.com/mrtazz/simplenote.vim'
" Simplenote password goes in here (s3kr3t, not managed by git)
"if filereadable($HOME."/.vim-simplenoterc")
"    exec ":source ". $HOME . "/.vim-simplenoterc"
"endif
"nnoremap <leader>l :Simplenote -l<CR>
"nnoremap <leader>n :Simplenote -n<CR>


"Autoclose - Automatically close brackets - not worth it imo
"Bundle 'https://github.com/Townk/vim-autoclose/'

"Evervim - evernote integration - doesn't seem to work.
"Bundle 'https://github.com/kakkyz81/evervim'

"Supertab - Changes the way ^n/^p works, no me gusta
"Bundle 'https://github.com/ervandew/supertab'

"clang_complete - only for c/c++, no use for now.
"Bundle 'https://github.com/Rip-Rip/clang_complete'
"sudo apt-get install libclang1 libclang-dev

"Vim pad - Note taking - I like the idea but it's buggy atm.
"Bundle 'https://github.com/fmoralesc/vim-pad'
" vimpad
"let g:pad_dir = "~/notes/"
"let g:pad_format = "text"
"let g:pad_window_height = 12
"let g:pad_search_backend = "ack"

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
"set expandtab      " don't put tabs in files, convert to spaces.
"set softtabstop=4  " also use this when using spaces.

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
nnoremap <leader>z :w <bar> %bd <bar> e#<CR>

if has("gui_running")
    "set guifont=Fantasque_Sans_Mono:h12:cANSI
    "set guifont=Fantasque_Sans_Mono:h12:cANSI
    set guifont=Iosevka_Term:h12:cANSI:qDRAFT
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

""" BEGIN Vundle autoinstall
if isVundleInstalled == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
""" END Vundle autoinstall

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
