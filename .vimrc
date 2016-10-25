:set guioptions-=m  "remove menu bar
:set guioptions+=M  "remove menu bar menu.vim
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
:set guioptions-=e  "remove gui tab
:set guioptions+=c  "use console

filetype off
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'
    """" User Bundles Begin """"

    " Syntastic - compiler checking for errors on the fly
    "Bundle 'Syntastic' "<-- Old
    Bundle 'https://github.com/scrooloose/syntastic'
    " Fugitive - GIT integration
    Bundle 'https://github.com/tpope/vim-fugitive'
    " Surround - change surrounding characters, tags
    Bundle 'https://github.com/tpope/vim-surround/'
    " HAML - Support for haml/sass/scss
    Bundle 'https://github.com/tpope/vim-haml'
    " CTRL-P - Fuzzy file searching
    Bundle 'https://github.com/ctrlpvim/ctrlp.vim/'

    " Airline - status bar
    Bundle 'bling/vim-airline'
    " NerdCommenter - comment block commands
    Bundle 'https://github.com/scrooloose/nerdcommenter'
    " TagBar - ctags support
    Bundle 'https://github.com/majutsushi/tagbar'
    " Ack
    Bundle 'https://github.com/mileszs/ack.vim'
    " Matchit - % bounces on html tags
    Bundle 'vim-scripts/matchit.zip'
    " Gundo - Visual undo tree
    Bundle 'http://github.com/sjl/gundo.vim.git'
    " Dispatch - Run Tests in background
    Bundle 'https://github.com/tpope/vim-dispatch'
    " SimpleNote Sync
    Bundle 'https://github.com/mrtazz/simplenote.vim'
    " Autodetect spaces vs tabs
    Bundle 'https://github.com/tpope/vim-sleuth'
    " Git diffs in gutter
    Bundle 'https://github.com/airblade/vim-gitgutter'

    "Bundle 'https://github.com/joonty/vdebug'

    Bundle 'https://github.com/mattn/webapi-vim'
    Bundle 'https://github.com/mattn/gist-vim'
    Bundle 'https://github.com/goldfeld/vim-seek'

    " Color schemes
    Bundle 'https://github.com/nanotech/jellybeans.vim'
    Bundle 'https://github.com/w0ng/vim-hybrid'
    Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
    Bundle 'https://github.com/tomasr/molokai'
    Bundle 'https://github.com/sjl/badwolf'
    Bundle 'https://github.com/gregsexton/Muon'
    Bundle 'https://github.com/altercation/vim-colors-solarized'

    Bundle 'puppetlabs/puppet-syntax-vim'

    "Bundle 'Valloric/YouCompleteMe'

    Bundle 'pangloss/vim-javascript'
    Bundle 'mxw/vim-jsx'

    """ Disabled Bundles

    " Autoclose - Automatically close brackets - not worth it imo
    " Bundle 'https://github.com/Townk/vim-autoclose/'

    " Evervim - evernote integration - doesn't seem to work.
    " Bundle 'https://github.com/kakkyz81/evervim'

    " Supertab - Changes the way ^n/^p works, no me gusta
    " Bundle 'https://github.com/ervandew/supertab'

    " clang_complete - only for c/c++, no use for now.
    " Bundle 'https://github.com/Rip-Rip/clang_complete'
    " sudo apt-get install libclang1 libclang-dev

    " Vim pad - Note taking - I like the idea but it's buggy atm.
    " Bundle 'https://github.com/fmoralesc/vim-pad'

    " User Bundles End
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

"basics
set nocompatible   " don't be compatible with vi
set vb t_vb=       " visual bell off
set encoding=utf-8 " utf8

"files
set backup                     " make backups
set backupdir=~/.backup//,/tmp//   " backups go here

"search
set hlsearch    " highlight search results
set ignorecase  " case insenstive search
set smartcase   " .. unless there's a capital

"tabs/indent
set autoindent     " auto/smart indent
set smartindent    " ^^^
set bs=2           " smart backspace
set tabstop=4      " indent is 4 chars wide
set shiftwidth=4   " << >> use 4
set shiftround     " << >> find the nearest 'tabstop'
set smarttab       " pressing tab also rounds to nearest (?unsure if i should keep this?)
set noexpandtab    """ put tabs in files.
"""set expandtab   """ don't put tabs in files, convert to spaces.
"""set softtabstop=4  " also use this when using spaces.

" interface
set laststatus=2 " always show status line
set ruler        " show character position
set title        " set window title
set number       " line numbers
set wildmenu                  " better completion
set wildmode=list:longest     " show lots of stuff
set nolist                    " hidden characters off by default
set listchars=eol:¬,extends:»,tab:»\ ,trail:›
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
nmap    _Y      :!echo ""> ~/.vi_tmp<CR><CR>:w! ~/.vi_tmp<CR>
vmap    _Y      :w! ~/.vi_tmp<CR>
nmap    _P      :r ~/.vi_tmp<CR>

" color, syntax highlighting
au BufRead,BufNewFile *.ctp setfiletype phtml " ctp, must be before filetype plugin. not 100%, % doesn't work on tags..
filetype plugin indent on                   " enable ft+plugin detect
syntax on                                   " syntax highlighting
set t_Co=256                                " 256-colors
set background=dark                         " we're using a dark bg

let g:solarized_termcolors=256
"let g:jellybeans_use_lowcolor_black = 1
colors jellybeans                           " select colorscheme
"colors hybrid
"colors Tomorrow-Night
"colors Tomorrow-Night-Eighties
"colors Tomorrow-Night-Blue
"colors Tomorrow-Night-Bright

"highlight Normal ctermbg=NONE               " use terminal background
"highlight nonText ctermbg=NONE              " use terminal background
highlight Search ctermfg=0 ctermbg=102      " i don't like jellybeans default search higlighting colors

au BufRead,BufNewFile *.txt set ft=sh       " opens .txt w/highlight

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

" ctrlp config - persistant cache
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_height = 20

"todo: usetagbar to figure out the current view to open
"function! Asdf()
    "let l:foo = tagbar#currenttag('%s', '')
"endfunction

" fugitive config
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>ge :Gedit<cr>
nnoremap <leader>gs :Gstatus<cr>

" tabs
nnoremap <C-t> :tabnew<cr>
nnoremap <C-y> :tabclose<cr>

" vimpad
let g:pad_dir = "~/notes/"
let g:pad_format = "text"
let g:pad_window_height = 12
let g:pad_search_backend = "ack"

" misc filetype
autocmd FileType sass setlocal noexpandtab shiftwidth=4 softtabstop=4 " Use tabs in sass (must be after filetype)
autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2 " Ruby uses spaces with indent width of 2
autocmd FileType * setlocal formatoptions-=ro " Disable auto comments (must be after filetype)

" clear search highlighting
noremap <silent><leader><space> :nohls<CR>

" f keys
set pastetoggle=<F1>                                    " f1 toggles paste
nnoremap <F2> :AutoCloseToggle<cr>                      " f2 toggles autoclose
nnoremap <F5> :set nonumber!<cr>:set foldcolumn=0<cr>   " f5 toggles line numbers
nnoremap <F6> :set list!<cr>                            " f6 toggles list
nnoremap <F8> :TagbarToggle<cr>                         " f8 toggles tagbar
nnoremap <F9> :GundoToggle<cr>                          " f9 toggles Gundo

let g:ctrlp_custom_ignore = {
\ 'dir': 'tmp',
\ }

" \W strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Simplenote password goes in here (s3kr3t, not managed by git)
if filereadable($HOME."/.vim-simplenoterc")
    exec ":source ". $HOME . "/.vim-simplenoterc"
endif

nnoremap <leader>l :Simplenote -l<CR>
nnoremap <leader>n :Simplenote -n<CR>

nnoremap <leader>4 :set tabstop=4<CR>:set shiftwidth=4<CR>

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'

let g:airline#extensions#tabline#enabled = 1

let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:syntastic_javascript_checkers = ['eslint']

" npm install -g eslint
" npm install -g babel-eslint
" npm install -g eslint-plugin-react
