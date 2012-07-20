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
    Bundle 'Syntastic'
    " Autoclose - Automatically close brackets
    Bundle 'https://github.com/Townk/vim-autoclose/'
    " Fugitive - GIT integration
    Bundle 'https://github.com/tpope/vim-fugitive'
    " Surround - change surrounding characters, tags
    Bundle 'https://github.com/tpope/vim-surround/'
    " HAML - Support for haml/sass/scss
    Bundle 'https://github.com/tpope/vim-haml'
    " Jellybeans - Color scheme
    Bundle 'https://github.com/nanotech/jellybeans.vim'
    " CTRL-P - Fuzzy file searching
    Bundle 'https://github.com/kien/ctrlp.vim/'
    " Ultisnips - text snippets
    Bundle 'https://github.com/SirVer/ultisnips'
    " Powerline - badass status bar
    Bundle 'https://github.com/Lokaltog/vim-powerline/'
    " NerdCommenter - comment block commands
    Bundle 'https://github.com/scrooloose/nerdcommenter'
    " TagBar - ctags support
    Bundle 'https://github.com/majutsushi/tagbar'
	" Ack
	Bundle 'https://github.com/mileszs/ack.vim'
	" Matchit - % bounces on html tags
	Bundle 'https://github.com/tsaleh/vim-matchit'
	" Cake.vim - Hop between model/view/controller
	Bundle 'https://github.com/violetyk/cake.vim'
	" Gundo - Visual undo tree
	Bundle 'http://github.com/sjl/gundo.vim.git'
	" Vim pad - Note taking
	Bundle 'https://github.com/fmoralesc/vim-pad'
	" Evervim - evernote integration - doesn't seem to work.
	" Bundle 'https://github.com/kakkyz81/evervim'

    " clang_complete - only for c/c++, no use for now.
    " Bundle 'https://github.com/Rip-Rip/clang_complete'
    " sudo apt-get install libclang1 libclang-dev

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
set backupdir=~/.backup,/tmp   " backups go here

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
set listchars=tab:>-,trail:*  " show tabs as -->, trailing whitespace as * with list=on
nnoremap <F5> :set nonumber!<cr>:set foldcolumn=0<cr>  " f5 toggles line numbers
nnoremap <F6> :set list!<cr>  " f6 toggles list
set pastetoggle=<F1>          " f1 toggles paste
set showmatch                 " show matching brackets
set showcmd                   " show when typing leader, etc.
set ttyfast                   " fast connection
set scrolloff=3               " keep 3 lines on the screen when scrolling
autocmd FileType * setlocal formatoptions-=ro " I hate auto comments

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
filetype plugin indent on                   " enable ft+plugin detect
syntax on                                   " syntax highlighting
set t_Co=256                                " 256-colors
set background=dark                         " we're using a dark bg
colors jellybeans                           " select colorscheme
highlight Normal ctermbg=NONE               " use terminal background
highlight nonText ctermbg=NONE              " use terminal background
au BufRead,BufNewFile *.txt set ft=sh       " opens .txt w/highlight
highlight Search ctermfg=0 ctermbg=122      " i don't like jellybeans default search higlighting colors

" ultisnips config
set runtimepath+=~/.vim/bundle/ultisnips      " include filepath
let g:UltiSnipsUsePythonVersion = 2           " force to use python2, not 3
let g:UltiSnipsListSnippets="<c-j>"           " list snippets with control-j, the default control-tab doesn't work in putty
let g:UltiSnipsExpandTrigger="<tab>"          " tab expands
let g:UltiSnipsJumpForwardTrigger="<tab>"     " use tab to go to next part of the snipper
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"  " use shift-tab to go back

" use powerline symbols - requires patched font - see
" https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
let g:Powerline_symbols = 'fancy'

" tagbars config
nmap <F8> :TagbarToggle<CR>  " f8 to turn on/off
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

" cake config
let g:cakephp_enable_auto_mode = 1     " auto detect cake project
nnoremap <leader>1 :Cmodeltab<cr>      " open model in new tab
nnoremap <leader>2 :Ccontrollertab<cr> " open controller in new tab
nnoremap <leader>3 :Cviewtab<space>
" ^^^open view in new tab - you must type function name :(

"todo: usetagbar to figure out the current view to open
"function! Asdf()
	"let l:foo = tagbar#currenttag('%s', '')
"endfunction

" fugitive config
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>ge :Gedit<cr>

"  todo - figure out how to include custom ultisnips in .vimrc instead of .vim/
"  pr( Debugger::trace() );

" gundo
nnoremap <F9> :GundoToggle<CR>

" vimpad
let g:pad_dir = "~/notes/"
let g:pad_format = "text"
let g:pad_window_height = 12
let g:pad_search_backend = "ack"
