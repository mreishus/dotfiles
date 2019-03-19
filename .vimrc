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

Plug 'tmux-plugins/vim-tmux-focus-events'

" Airline - Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" do not show the buffer when only one tab exists
let g:airline#extensions#tabline#show_buffers=0

" Fzf - File Finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"let g:fzf_layout = { 'window': '-tabnew' } " Helps on windows gvim? Not sure.
nnoremap <c-p> :FZF<cr>

Plug 'jremmen/vim-ripgrep'

"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': './install.sh'
"    \ }
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
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 'always'
"let g:ale_lint_delay = 250

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" let g:ale_set_highlights = 0

let g:ale_javascript_prettier_use_local_config = 1
let g:airline#extensions#ale#enabled = 1

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
  \   'haskell': [
  \       'hfmt',
  \   ],
  \   'rust': [
  \       'rustfmt',
  \   ],
  \}
let g:ale_ruby_rubocop_executable = 'bundle'

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
Plug 'janko/vim-test'

""" Filetypes
Plug 'sheerun/vim-polyglot'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

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
Plug 'rakr/vim-one'

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

" Tabnine completion
Plug 'zxqfl/tabnine-vim'

" Sonic-pi
Plug 'dermusikman/sonicpi.vim'

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
let g:pandoc#modules#disabled = [ "spell", "folding" ]

"Matchit - % bounces on html tags
Plug 'vim-scripts/matchit.zip'

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
set encoding=utf-8

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
  nmap _Y :!echo ""> $HOME/_vi_tmp<CR><CR>:w! $HOME/_vi_tmp<CR>
  vmap _Y :w! $HOME/_vi_tmp<CR>
  nmap _P :r $HOME/_vi_tmp<CR>
else
  nmap _Y :!echo ""> ~/.vi_tmp<CR><CR>:w! ~/.vi_tmp<CR>
  vmap _Y :w! ~/.vi_tmp<CR>
  nmap _P :r ~/.vi_tmp<CR>
endif

" color, syntax highlighting
filetype plugin indent on " enable ft+plugin detect
syntax on                 " syntax highlighting
set t_Co=256              " 256-colors
set background=dark       " we're using a dark bg

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
  set guifont=Iosevka\ Term\ 12
endif

" Guifont Fantasque Sans Mono:h12
set noincsearch

set backupcopy=yes "For webpack
set tabpagemax=100

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

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

colorscheme one
call one#highlight('normal', 'cccccc', '000000', 'none')"


" ? - shows preview
" enter - opens file
" t - opens in new tab(?)
" https://github.com/junegunn/fzf.vim
" https://github.com/gvaughn/dotfiles/blob/master/config/nvim/init.vim
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
command! -bang -nargs=* Fzgrep
  \ call fzf#vim#grep(
  \  'rg --column --line-number --no-heading --color "always" '.shellescape(<q-args>), 1,
  \  <bang>0 ? fzf#vim#with_preview('up:60%')
  \          : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)
" search project for word under cursor
nnoremap <silent> <leader>* :Fzgrep <C-R><C-W><CR>
