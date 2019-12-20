:set guioptions-=m  "remove menu bar
:set guioptions+=M  "remove menu bar menu.vim
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
:set guioptions-=e  "remove gui tab
:set guioptions+=c  "use console

""" BEGIN vim-plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
""" END vim-plug autoinstall

call plug#begin('~/.vim/plugged')

" Toggle bindings
" [a and ]a - :n and :p
" yob - Toggle dark/light background (or [ob and ]ob)
" [op and ]op - Paste once (uses o or O)
" yon - Set number (or [on and ]on)
Plug 'tpope/vim-unimpaired'
" \q - Close buffer
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Allow FocusGained/FocusLost events to work in tmux,
" used by autoread (file has changed), gitgutter, fugitive, etc.
Plug 'tmux-plugins/vim-tmux-focus-events'

" Airline - Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" do not show the buffer when only one tab exists
let g:airline#extensions#tabline#show_buffers=0
" Turn off the top right file display
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0

" Nuake - Quake console terminal - Press F4.
" Turn off on some systems
Plug 'Lenovsky/nuake'
nnoremap <F4> :Nuake<CR>
inoremap <F4> <C-\><C-n>:Nuake<CR>
tnoremap <F4> <C-\><C-n>:Nuake<CR>
let g:nuake_position = 'top'
let g:nuake_size = 0.40
let g:nuake_per_tab = 1

" Keys that are safe to rebind in insert mode.
" Great comment here:
" https://old.reddit.com/r/vim/comments/4w0lib/do_you_use_insert_mode_keybindings/d63baic/

" UltiSnips - Type the beginning of a snippet, then C-J.  C-F in insert or normal
" mode shows possible snippets.
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mreishus/vim-mmr-snippets'
let g:UltiSnipsExpandTrigger="<c-j>" " the default key, tab, conflicts with YCM/TabNine
let g:UltiSnipsListSnippets="<c-f>" "See possible snippets while typing. Most ctrl binding keys are taken in insert mode
nnoremap <c-f> :Snippets<cr>

" Add some extra snippets
autocmd FileType javascript UltiSnipsAddFiletypes javascript-react
autocmd FileType javascript UltiSnipsAddFiletypes javascript-redux
autocmd FileType javascript UltiSnipsAddFiletypes javascript-es6-react
autocmd FileType javascript UltiSnipsAddFiletypes javascript-es6-react
autocmd FileType javascript UltiSnipsAddFiletypes javascript-react-hook
autocmd FileType typescript UltiSnipsAddFiletypes typescript-react-hook
autocmd FileType typescript.tsx UltiSnipsAddFiletypes typescript-react-hook
autocmd FileType typescriptreact UltiSnipsAddFiletypes typescript-react-hook

" Emmet - (insert-mode) C-K, then comma to expand a emmet abbreviation like:
" div.column>(span+div>ui>li*3)
" This plugin has other functions I haven't learned yet.
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key="<c-k>"
autocmd FileType html,css,javascript.jsx,javascript.jsx_pretty,jsx_pretty EmmetInstall

" Fzf - File Finder
" C-P to find files.  Many other commands like :Buffers, :Marks, etc.  Press
" F12.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"let g:fzf_layout = { 'window': '-tabnew' } " Helps on windows gvim? Not sure.
nnoremap <c-p> :FZF<cr>
nnoremap <silent> <Leader>b  :Buffers<CR>
let g:fzf_layout = { 'down': '~65%' }


" Tell FZF to use RG - so we can skip .gitignore files even if not using
" :GitFiles search
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" If you want gitignored files:
"let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'

" \rg - Search for word under cursor, or string currently selected
nnoremap <silent> <Leader>rg       :Rg <C-R><C-W><CR>
xnoremap <silent> <Leader>rg       y:Rg <C-R>"<CR>

" Menus - Part 1 (We define them after plug ends)
Plug 'skywind3000/quickmenu.vim'

" Timestamp - Set Created/Last Modified timestamps
Plug 'vim-scripts/timestamp.vim'

" Ale - Automatic Linting/Fixing.
Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 'always'
"let g:ale_lint_delay = 250
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" let g:ale_set_highlights = 0
let g:ale_javascript_prettier_use_local_config = 1
let g:airline#extensions#ale#enabled = 1

"" ALE For markdown:
"" yarn global add prettier
"" gem install mdl
"" (make sure gem bin is in your path)

" remark-lint requires remark..
" neither of them have binaries,
" also they need a config file.  Only worth
" using in javascript projects?
  " \   'markdown': [
  " \       'remark-lint',
  " \   ],

let g:ale_linter_aliases = {'pandoc': ['markdown']}
let g:ale_linters = {
  \   'elixir': ['credo', 'mix'],
  \   'perl6': ['perl6'],
  \}
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'typescript': [
  \       'prettier', 'eslint'
  \   ],
  \   'typescriptreact': [
  \       'prettier', 'eslint'
  \   ],
  \   'javascript': [
  \       'prettier', 'eslint'
  \   ],
  \   'go': [
  \       'gofmt', 'goimports'
  \   ],
  \   'markdown': [
  \       'prettier',
  \   ],
  \   'pandoc': [
  \       'prettier',
  \   ],
  \   'elixir': [
  \       'mix_format',
  \   ],
  \   'haskell': [
  \       'brittany',
  \   ],
  \   'rust': [
  \       'rustfmt',
  \   ],
  \   'python': [
  \       'black',
  \   ],
  \   'ruby': ['prettier'],
  \}
let g:ale_ruby_rubocop_executable = 'bundle'

" run "gem install prettier"
augroup ale_ruby
  au!
  au FileType ruby let b:ale_javascript_prettier_executable = 'rbprettier'
  " " Or:
  " au FileType ruby let b:ale_javascript_prettier_options = '--parser ruby'
augroup END

""" File Tree - Nerd Tree (ctrl-n)
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<cr>
"Plug 'jistr/vim-nerdtree-tabs'    " Makes tree appear on all tabs - slow.
"map <C-n> :NERDTreeTabsToggle<cr>

"let g:NERDTreeHijackNetrw=0
let g:nerdtree_tabs_open_on_gui_startup=0

""" Enhance editor commands
 " Adds additional text objects.  cia = Change in argumentlist. Adds seeking.
Plug 'wellle/targets.vim'
" Git commands.
Plug 'tpope/vim-fugitive'
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>ge :Gedit<cr>
nnoremap <leader>gs :Gstatus<cr>

" Block comment (gc)
Plug 'tpope/vim-commentary'

" Surround alternative: sandwich
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-highlightedyank' " Highlight what's yanked
let g:highlightedyank_highlight_duration = 350
Plug 'machakann/vim-swap' " Swap function arguments with g< g>
" Text objects for function arguments
omap i, <Plug>(swap-textobject-i)
xmap i, <Plug>(swap-textobject-i)
omap a, <Plug>(swap-textobject-a)
xmap a, <Plug>(swap-textobject-a)

" Automatically guess tab/space settings when opening a file
Plug 'tpope/vim-sleuth'

" Signature - show marks in column, add some mark related bindings
"Plug 'kshenoy/vim-signature'

" Marks in gutter about added/removed lines
" Gitgutter alternative: Signify
Plug 'mhinz/vim-signify'
let g:signify_realtime = 1
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0

" Run tests from inside vim
Plug 'tpope/vim-dispatch'
Plug 'janko/vim-test'
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>TN :TestNearest -strategy=basic<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>TF :TestFile -strategy=basic<cr>
nnoremap <leader>ts :TestSuite<cr>
nnoremap <leader>tt :TestSuite -strategy=dispatch_background<cr>
nnoremap <leader>TT :TestSuite -strategy=basic<cr>
nnoremap <leader>tb :TestSuite -strategy=dispatch_background<cr>
nnoremap <leader>tl :TestLast<cr>
nnoremap <leader>tg :TestVisit<cr>

" Quickfix
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
nmap <leader>j :cnext<cr>
nmap <leader>k :cprevious<cr>

"let test#strategy = "dispatch_background"
let test#strategy = "dispatch"

"let test#strategy = "neovim"

Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>

""" Filetypes
Plug 'sheerun/vim-polyglot'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"" Golang - Disabled, letting coc extension coc-go handle this
"" https://octetz.com/posts/vim-as-go-ide
"Plug 'fatih/vim-go'
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
"let g:go_def_mapping_enabled = 0

"" <leader>mm to show minimap
"" unfortunately it errors?
"" Plug 'severin-lemaignan/vim-minimap'

""" Fade inactive buffers
""" Plug 'TaDaa/vimade'

"""  Color schemes
" Plug 'Rigellute/shades-of-purple.vim'
" Plug 'arzg/vim-corvine'
" Plug 'jaredgorski/SpaceCamp'

" https://old.reddit.com/r/vim/comments/6rf9z6/what_is_your_favorite_colorscheme/
" https://old.reddit.com/r/vim/comments/cffyoj/most_highquality_vim_color_schemes/
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'tomasr/molokai'
Plug 'sjl/badwolf'
Plug 'gregsexton/Muon'
Plug 'altercation/vim-colors-solarized'
Plug 'mreishus/vim-mnemosyne'
Plug 'mreishus/vim-astraios'
Plug 'ciaranm/inkpot'
let g:inkpot_black_background = 1
Plug 'challenger-deep-theme/vim'
Plug 'micke/vim-hybrid'
Plug 'ayu-theme/ayu-vim'
Plug 'romainl/Apprentice'
Plug 'tpope/vim-vividchalk'
Plug 'atelierbram/Base2Tone-vim'
Plug 'axvr/photon.vim'
Plug 'chriskempson/base16-vim'

" It wants me to manually run "make" in its directory.  Way too annoying.
" Plug 'RRethy/vim-hexokinase' " Show colors inline
" let g:Hexokinase_virtualText = '███'
" "let g:Hexokinase_ftAutoload = ['*'] " Enable for all filetypes
" let g:Hexokinase_ftAutoload = ['css', 'xml'] " Enable for css and xml

" Startify - Splash screen.
Plug 'mhinz/vim-startify'
nnoremap <leader>s :Startify<CR>
let g:ascii = [
    \ '        __',
    \ '.--.--.|__|.--.--.--.',
    \ '|  |  ||  ||        |',
    \ ' \___/ |__||__|__|__|',
    \ ''
    \]
let g:startify_custom_header =
        \ 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

" Session management
Plug 'tpope/vim-obsession'
if has('win32') || has('win64')
  nnoremap <leader>o :Obsess $HOME\vimfiles\session\
else
  nnoremap <leader>o :Obsess ~/.vim/session/
endif
nnoremap <leader>O :Obsess!

" Tabnine completion
"Plug 'zxqfl/tabnine-vim'

" Coc - Extensive completion engine

" Here are the extensions I have installed
" coc-tabnine
" coc-tailwindcss
" coc-highlight
" coc-snippets
" coc-go
" coc-json
" coc-tsserver
" coc-elixir

Plug 'neoclide/coc.nvim', {'branch': 'release'}
autocmd CursorHold * silent call CocActionAsync('highlight')
"autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
"autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

"""""""""""""""""""""""""""" COC BEGIN """"""""""""""""""""""""""""""
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2 " Matt: I can't deal with this

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" ? I don't know what this does
nmap <leader>dc  <Plug>(coc-codelens-action)
" Same - AC might include this and more
nmap <leader>rc  <Plug>(coc-refactor)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"""""""""""""""""""""""""""" COC END """"""""""""""""""""""""""""""

" Sonic-pi
Plug 'dermusikman/sonicpi.vim'

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = [ "spell", "folding" ]
" Automatic linewrapping in pandoc:
" Sometimes, this needs to be turned off
" Trying to rely on prettier instead. hA is just too buggy.
" let g:pandoc#formatting#mode = "hA"
" default = "s"
"  h: use hard wraps
"  a: autoformat
"  A: smart autoformatting
"  s: use soft wraps

"Matchit - % bounces on html tags
Plug 'vim-scripts/matchit.zip'

" Zen mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <leader>z :SignifyToggle<CR>:Goyo<CR>
"nnoremap <leader>z :Goyo<CR>:call one#highlight('normal', 'cccccc', '000000', 'none')<CR>

" Sneak
"Plug 'justinmk/vim-sneak'
" Commented - this is conflicting with sandwich sometimes

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

" common typos
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
"set t_Co=256              " 256-colors
set background=dark       " we're using a dark bg

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/obj/*,*/node_modules/*

" tabs
nnoremap <C-t> :tabnew<cr>
nnoremap <C-y> :tabclose<cr>

" misc filetype

" When I'm working on markdown, I use these
" :let g:ycm_auto_trigger = 0

autocmd FileType pandoc set tw=78|set fo+=t
autocmd FileType sass setlocal noexpandtab shiftwidth=4 softtabstop=4 " Use tabs in sass (must be after filetype)
autocmd FileType ruby setlocal tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2 " Ruby uses spaces with indent width of 2
autocmd FileType crystal setlocal tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2 " crystal uses spaces with indent width of 2
autocmd FileType make setlocal noexpandtab " Makefile uses tabs
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
"nnoremap <leader>ve :tabe $MYVIMRC<CR>
nnoremap <leader>ve :tabe ~/.vimrc<CR>
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

" Open folds when opening file
"au BufRead * normal zR
autocmd BufWinEnter * silent! :%foldopen!

hi ALEWarning ctermbg=4

" This is for putty using termguicolors
" outside of tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Use 24-bit (true-color) mode in Vim/Neovim when ~~outside tmux~~.
" Check vim-one's README for more info here. I modified to work inside tmux,
" too.
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

set background=dark
let g:jellybeans_overrides = {
\    'Pmenu': { 'guibg': '000040' },
\    'SignColumn': { 'guibg': '000000' },
\    'background': { 'guibg': '000000', 'ctermbg': 'none', '256ctermbg': 'none' },
\    'Search': { 'guifg': '000000', 'guibg': 'd4ff32', 'ctermfg': '0', 'ctermbg': '102' },
\    'Type': { 'guifg': 'd787d7' },
\    'CocCodeLens': { 'guifg': '777777' },
\}
"call jellybeans#X("Type","ffb964","","","Yellow","")

let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "atlus"
    let g:jellybeans_use_term_italics = 1
    let g:palenight_terminal_italics=1
else
    let g:jellybeans_use_term_italics = 0
    let g:palenight_terminal_italics=0
endif

"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu

"colorscheme apprentice
"colorscheme vividchalk
"colorscheme hybrid

"colorscheme Base2Tone_EveningDark
" or any of the other schemes:
" colorscheme Base2Tone_MorningDark
" colorscheme Base2Tone_SeaDark
" colorscheme Base2Tone_SpaceDark
" colorscheme Base2Tone_EarthDark
" colorscheme Base2Tone_ForestDark
" colorscheme Base2Tone_DesertDark
" colorscheme Base2Tone_LakeDark
" colorscheme Base2Tone_MeadowDark

"colorscheme Base2Tone_DrawbridgeDark
"let g:airline_theme='Base2Tone_DrawbridgeDark'

" colorscheme Base2Tone_PoolDark
" colorscheme Base2Tone_HeathDark
" colorscheme Base2Tone_CaveDark

"colo Base2Tone_DrawbridgeDark
"let g:airline_theme='Base2Tone_DrawbridgeDark'

colo jellybeans

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

" Menus - part 2
source ~/.config/nvim/vimrc/menu.vim

" Alt J, Alt K, to move lines up down
" I like using these bindings for tmux though,
" What should I put them on?
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv

" <leader>sp - Show highlight groups under cursor
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" <leader>so - Show highlight group and translation
nmap <leader>so :call SynGroup()<CR>
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

map <leader>si :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <leader>x :Colors<CR>
" :highlight SignColumn guibg=#000000
nnoremap <leader>gg :highlight clear SignColumn<CR>
nnoremap <leader>gf :highlight Normal ctermbg=16 guibg=#000000<CR>
