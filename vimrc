set encoding=utf-8
scriptencoding utf-8

"| Recursive | Non-recursive | Unmap    | Modes                            |
"|-----------|--------------------------|----------------------------------|
"| :map      | :noremap      | :unmap   | normal, visual, operator-pending |
"| :nmap     | :nnoremap     | :nunmap  | normal                           |
"| :xmap     | :xnoremap     | :xunmap  | visual                           |
"| :cmap     | :cnoremap     | :cunmap  | command-line                     |
"| :omap     | :onoremap     | :ounmap  | operator-pending                 |
"| :imap     | :inoremap     | :iunmap  | insert                           |
" !         make a switch from a key
" <CR>      Enter key
" <C-o>     allows in 'insert' mode insert a command
" <silent>  a mapping will not be echoed on the command line
" %         actual file, :he expand
" <leader>  default \

let g:MSWIN   = has('win16')  || has('win32')   || has('win64')     || has('win95')
let g:MSWIN64 = has('win64')
let g:UNIX    = has('unix')   || has('macunix') || has('win32unix')
let g:MACOS   = has('mac')
let g:PYTHON3 = has('python3')
let g:PYTHON  = has('python') || has('python3')
let g:OS      = substitute(system('uname'), '\n', '', '')
let g:VIMRC   = expand('<sfile>:p:h')

if has('multi_byte')
    let g:UNICODE = 0
    if $LC_ALL =~? '\vutf-?8' || $LANG =~? '\vutf-?8'
        let g:UNICODE = 1
        set fileencoding=utf-8
    endif
    if &termencoding ==# ''
        let &termencoding = &encoding
    endif
endif

if g:MACOS
    let g:python3_host_prog=substitute(system('which python3'), '\n', '', 'g')
endif

let g:vim_plug_path=expand('~/.vim/autoload/plug.vim')
if empty(glob(g:vim_plug_path))
    if !executable('curl')
        echoerr 'You have to install curl or first install vim-plug yourself!'
        execute 'q!'
    endif
    echo 'Installing Vim-Plug...'
    echo ''
    silent exec '!\curl -fLo ' . g:vim_plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let g:vim_plug_just_installed = 1
    augroup plug_install
        autocmd!
        autocmd VimEnter * PlugInstall
    augroup END
endif

" Run PlugInstall if there are missing plugins
augroup plug_install
    autocmd!
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \| PlugInstall --sync | wincmd p | quit! | source $MYVIMRC
                \| endif
augroup END

call plug#begin()
" Plugins definition
Plug 'https://github.com/junegunn/vim-plug' " 🌺 Minimalist Vim Plugin Manager
Plug 'https://github.com/tpope/vim-sensible' " Defaults everyone can agree on
Plug 'https://github.com/preservim/nerdtree' " A tree explorer plugin for vim
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight' " Extra syntax and highlight for nerdtree files
Plug 'https://github.com/scrooloose/nerdcommenter' " Vim plugin for intensely nerdy commenting powers
Plug 'https://github.com/jistr/vim-nerdtree-tabs' " NERDTree and tabs together in Vim, painlessly
Plug 'https://github.com/tpope/vim-commentary' " comment stuff out
Plug 'https://github.com/tpope/vim-scriptease' " A Vim plugin for Vim plugins
Plug 'https://github.com/NeonVim/helpful.vim' " 📓 Display vim version numbers in docs
" Plug 'https://github.com/ConradIrwin/vim-bracketed-paste' " Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
Plug 'https://github.com/godlygeek/tabular' " Vim script for text filtering and alignment
Plug 'https://github.com/pbrisbin/vim-restore-cursor' " Restore your cursor position when you (re)open vim
Plug 'https://github.com/andymass/vim-matchup' " even better % 👊 navigate and highlight matching words 👊 modern matchit and matchparen.
Plug 'https://github.com/tpope/vim-speeddating' " use CTRL-A/CTRL-X to increment dates, times, and more
Plug 'https://github.com/tpope/vim-repeat' " enable repeating supported plugin maps with .
Plug 'https://github.com/editorconfig/editorconfig-vim' " EditorConfig plugin for Vim
Plug 'https://github.com/AndrewRadev/splitjoin.vim' " Switch between single-line and multiline forms of code
Plug 'https://github.com/mbbill/undotree' " The undo history visualizer for VIM
Plug 'https://github.com/simnalamburt/vim-mundo' " 🎄 Vim undo tree visualizer
Plug 'https://github.com/mhinz/vim-startify' " 🔗 The fancy start screen for Vim.
Plug 'https://github.com/vimwiki/vimwiki' " Personal Wiki for Vim
Plug 'https://github.com/ntpeters/vim-better-whitespace' " Better whitespace highlighting for Vim
if v:version >= 740
    Plug 'https://github.com/WolfgangMehner/bash-support' " BASH IDE -- Write and run BASH-scripts using menus and hotkeys
endif
Plug 'https://github.com/WolfgangMehner/awk-support' " Edit AWK scripts in Vim/gVim. Insert code snippets, run, and check the code and look up help.
Plug 'https://github.com/WolfgangMehner/c-support' " Edit C/C++ programs in Vim/gVim. Insert code snippets, compile the code, run Make/CMake/... and look up help.
Plug 'https://github.com/WolfgangMehner/perl-support' " Edit Perl scripts in Vim/gVim. Insert code snippets, run, check, and profile the code and look up help.
Plug 'https://github.com/vim-scripts/betterga' " Yet another :ascii command
Plug 'https://github.com/tpope/vim-abolish' " abolish.vim: Work with several variants of a word at once
Plug 'https://github.com/mzlogin/vim-markdown-toc' " A vim 7.4+ plugin to generate table of contents for Markdown files
Plug 'https://github.com/Shougo/echodoc.vim' " Print documents in echo area.
Plug 'https://github.com/Shougo/vimshell.vim' " 🐚 Powerful shell implemented by vim.
Plug 'https://github.com/Shougo/deol.nvim' " Dark powered shell interface for NeoVim/Vim8
Plug 'https://github.com/mbbill/fencview' " Auto detect CJK and Unicode file encodings.
Plug 'https://github.com/lilydjwg/colorizer' " A Vim plugin to colorize all text in the form #rrggbb or #rgb
Plug 'https://github.com/xu-cheng/brew.vim' " 🍺 Vim Syntax for Homebrew formulae
Plug 'https://github.com/cespare/vim-toml' " Vim syntax for TOML
Plug 'https://github.com/vim-scripts/FavMenu.vim' " A new menu, like IE's Favourites, or Netscape's Bookmark
Plug 'https://github.com/vim-scripts/FavEx' " Favorite file and directory explorer
Plug 'https://github.com/dracorp/vim-pkgbuild' " easy work with ArchLinux PKGBUILD
if v:version >= 800 && (v:version == 800 && has('patch27') || v:version > 800)
    Plug 'https://github.com/liuchengxu/vista.vim' " 🌵 Viewer & Finder for LSP symbols and tag
endif
Plug 'https://github.com/majutsushi/tagbar' " Vim plugin that displays tags in a window, ordered by scope
Plug 'https://github.com/vim-scripts/DrawIt' " Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
Plug 'https://github.com/itchyny/calendar.vim' " A calendar application for Vim
Plug 'https://github.com/xolox/vim-misc' " Miscellaneous auto-load Vim scripts
if executable('ctags')
    Plug 'https://github.com/vim-scripts/taglist.vim' " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
    Plug 'https://github.com/xolox/vim-easytags' " Automated tag file generation and syntax highlighting of tags in Vim
endif
if v:version >= 800
    " vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot
    let g:polyglot_disabled = ['csv', 'jenkins', 'yaml']
    Plug 'https://github.com/sheerun/vim-polyglot'                    " A solid language pack for Vim
endif
Plug 'https://github.com/Shougo/vimproc.vim', {'do' : 'make'} " Interactive command execution in Vim
Plug 'https://github.com/osyo-manga/vim-over' " :substitute preview
" Plug 'https://github.com/itchyny/vim-cursorword' " Underlines the word under the cursor
" YAML
Plug 'https://github.com/pedrohdz/vim-yaml-folds' " YAML, RAML, EYAML & SaltStack SLS folding for Vim
" CSV
" Plug 'https://github.com/chrisbra/csv.vim' " A Filetype plugin for csv files
" Python
Plug 'https://github.com/heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' } " Generate Python docstring to your Python source code.
" Perl
Plug 'https://github.com/wsdjeg/perldoc-vim' " Perldoc plugin for vim
Plug 'https://github.com/c9s/perlomni.vim' " perl omnicompletion for vim (including base class function compleltions .. etc)
Plug 'https://github.com/vim-perl/vim-perl' " Support for Perl 5 in Vim
" View
Plug 'https://github.com/vim-airline/vim-airline' " lean & mean status/tabline for vim that's light as air
Plug 'https://github.com/vim-airline/vim-airline-themes' " A collection of themes for vim-airline
Plug 'https://github.com/morhetz/gruvbox' " Retro groove color scheme for Vim
Plug 'https://github.com/junegunn/goyo.vim' " 🌷 Distraction-free writing in Vim
Plug 'https://github.com/junegunn/limelight.vim' " 🔦 All the world's indeed a stage and we are merely players
" Checker
if (v:version >= 800 && has('timers'))
    Plug 'https://github.com/dense-analysis/ale' " Check syntax in Vim/Neovim asynchronously and fix files, with Language Server Protocol (LSP) support
else
    Plug 'https://github.com/vim-syntastic/syntastic' " Syntax checking hacks for vim
endif
Plug 'https://github.com/itspriddle/vim-shellcheck' " Vim wrapper for ShellCheck, a static analysis tool for shell scripts.
Plug 'https://github.com/z0mbix/vim-shfmt' " Vim plugin for shfmt (https://github.com/mvdan/sh)
" Tab complete
if (( v:version >= 801 && (v:version == 801 && has('patch1719') || v:version > 801) ) || ( has('nvim') && has('nvim') >= 4000 ))
            \ && executable('node')
    let g:tab_complete = 'coc'
    Plug 'https://github.com/neoclide/coc-neco' " viml completion source for coc.nvim
    Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'} " Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers
    Plug 'https://github.com/neoclide/coc-snippets' " Snippets solution for coc.nvim
" Completor
elseif g:PYTHON && has('job') && has('timers') && has('lambda')
    let g:tab_complete = 'completor'
    Plug 'https://github.com/maralla/completor.vim' " Async completion framework made ease
    Plug 'https://github.com/maralla/completor-neosnippet' " Neosnippet completion support for completor.vim
    Plug 'https://github.com/kyouryuukunn/completor-necosyntax' " ???
    Plug 'https://github.com/kyouryuukunn/completor-necovim' " ???
elseif (v:version >= 703 && has('patch885') && has('lua')) && (v:version >= 802 && (v:version == 802 && has('patch1066')))
    let g:tab_complete = 'neocomplete'
    Plug 'https://github.com/Shougo/neocomplete.vim' " Next generation completion framework after neocomplcache
else
    let g:tab_complete = 'supertab'
    Plug 'https://github.com/ervandew/supertab' " Perform all your vim insert mode completions with Tab
endif
if !empty(g:tab_complete)
    Plug 'https://github.com/tenfyzhong/CompleteParameter.vim' " Complete parameter after select the completion. Integration with YouCompleteMe(ycm), deoplete, neocomplete
endif
Plug 'https://github.com/Raimondi/delimitMate' " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
" Snippets
Plug 'https://github.com/Shougo/neosnippet.vim' " neo-snippet plugin
Plug 'https://github.com/Shougo/neosnippet-snippets' " The standard snippets repository for neosnippet
Plug 'https://github.com/honza/vim-snippets' " vim-snipmate default snippets (Previously snipmate-snippets)
" Docker
Plug 'https://github.com/wsdjeg/vim-dockerfile' " Vim syntax file & snippets for Docker's Dockerfile
" Groovy
Plug 'https://github.com/vim-scripts/groovy.vim' " syntax file for the groovy programming language
" JSON
Plug 'https://github.com/gutenye/json5.vim' " Syntax highlighting for JSON5 in Vim
Plug 'https://github.com/elzr/vim-json' " A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
" Html
Plug 'https://github.com/mattn/emmet-vim' " emmet for vim: http://emmet.io/
if v:version <= 740
    Plug 'https://github.com/JulesWang/css.vim' " deprecated
endif
Plug 'https://github.com/vim-language-dept/css-syntax.vim' " CSS syntax highlighting that ships with Vim
Plug 'https://github.com/cakebaker/scss-syntax.vim' " Vim syntax file for scss (Sassy CSS)
Plug 'https://github.com/ap/vim-css-color' " Preview colours in source code while editing
Plug 'https://github.com/hail2u/vim-css3-syntax' " CSS3 syntax (and syntax defined in some foreign specifications) support for Vim's built-in syntax/css.vim
Plug 'https://github.com/groenewege/vim-less' " vim syntax for LESS (dynamic CSS)
" Vim
Plug 'https://github.com/todesking/vint-syntastic' " ???
Plug 'https://github.com/ynkdir/vim-vimlparser' " Vim script parser
Plug 'https://github.com/syngan/vim-vimlint' " lint for vim script
Plug 'https://github.com/Shougo/neco-vim' "The Vim Script completion source for neocomplete/deoplete/ddc
Plug 'https://github.com/tweekmonster/exception.vim' " Vim plugin for tracing exceptions thrown by VimL scripts.
" XML
Plug 'https://github.com/valloric/MatchTagAlways' " A Vim plugin that always highlights the enclosing html/xml tags
Plug 'https://github.com/sukima/xmledit' " A filetype plugin for VIM to help edit XML files
" Git
if executable('git')
    Plug 'https://github.com/tpope/vim-fugitive'        " A Git wrapper so awesome, it should be illegal
    Plug 'https://github.com/rhysd/committia.vim'       " A Vim plugin for more pleasant editing on commit messages
    " if has('nvim') || has('patch-8.0.902')
    "     Plug 'https://github.com/mhinz/vim-signify' " ➕ Show a diff using Vim its sign column.
    " else
    "     Plug 'https://github.com/mhinz/vim-signify', { 'tag': 'legacy' }
    " endif
endif
if v:version >= 740
    " Plug 'https://github.com/WolfgangMehner/git-support' " Inspect the state of a repository and execute Git commands without leaving Vim.
endif
Plug 'https://github.com/wavded/vim-stylus' " Syntax Highlighting for Stylus
Plug 'https://github.com/junegunn/gv.vim' " A git commit browser in Vim
" Fuzzy/fzf
Plug 'https://github.com/Shougo/neoyank.vim' " Saves yank history includes unite.vim/denite.nvim history/yank source.
if executable('fzf')
    Plug 'https://github.com/junegunn/fzf.vim' " fzf ❤️ vim
    Plug 'https://github.com/justinhoward/fzf-neoyank' " Allows browsing and putting any register history saved with neoyank
endif
Plug 'https://github.com/Donaldttt/fuzzyy' " A fuzzy finder for vim
Plug 'https://github.com/luochen1990/rainbow' " Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration.
Plug 'https://github.com/MattesGroeger/vim-bookmarks' " Vim bookmark plugin
let g:table_mode_map_prefix = ',t'
Plug 'https://github.com/dhruvasagar/vim-table-mode' " VIM Table Mode for instant table creation.
Plug 'https://github.com/tpope/vim-surround' " Delete/change/add parentheses/quotes/XML-tags/much more with ease
if (v:version > 704)
    Plug 'https://github.com/preservim/vim-indent-guides' " A Vim plugin for visually displaying indent levels in code
endif
if has('signs')
    Plug 'https://github.com/kshenoy/vim-signature' " Plugin to toggle, display and navigate marks
endif
"Plug 'https://github.com/psliwka/vim-smoothie' " Smooth scrolling for Vim done right🥤

" vim-devicons should be at the end
Plug 'https://github.com/ryanoasis/vim-devicons' " Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more

call plug#end()
delc PlugUpgrade

    " Vim configuration
silent! colorscheme gruvbox
set background=dark

if has('persistent_undo')
    let g:target_path = expand('~/.vim/undo')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(g:target_path)
        call mkdir(g:target_path, 'p', 0700)
    endif
    let &undodir=g:target_path
    set undofile
    nnoremap <F5> :UndotreeToggle<CR>
endif

if has('signs') && v:version >= 800
    set signcolumn=auto                         " show signcolumns
endif

" Enable 256 color terminal
" set t_Co=256

" indention & tabs
set autoindent                                  " always set autoindenting on
set smartindent                                 " smart autoindenting when starting a new line
set copyindent                                  " copy the previous indentation on autoindenting
" 1 tab == 4 spaces
set tabstop=4                                   " a tab is four spaces
set softtabstop=4                               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4                                " number of spaces to use for autoindenting
set smarttab                                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set expandtab                                   " expand tabs by default (overloadable per file type later)
set shiftround                                  " use multiple of shiftwidth when indenting with '<' and '>
set isfname-==                                  " open file under cursor for entry: VARIABLE=path
set isfname+={,}                                " open file under cursor with env variable
set iskeyword-=$
set iskeyword+=-,#
set undolevels=1000                             " use many muchos levels of undo
set cursorline
set listchars=tab:>-,eol:$,trail:-,nbsp:%
set showmode                                    " always show what mode we're currently editing in
set showmatch                                   " jump to matching parenthesis/bracket
set matchpairs+=<:>                             " Add HTML brackets to pair matching
set smartcase                                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set ignorecase
set hlsearch
set nojoinspaces                                " do not insert 2 spaces after .?! when join lines <J>
set splitbelow                                  " command :sp put a new window below the active
set splitright                                  " command :vs put a new windows on right side of active
set equalalways                                 " Resize windows on split or close
set tildeop                                     " Tylde(~) behaves like operator
set cmdheight=2                                 " use a status bar that is 2 rows high
set wildmenu                                    " make tab completion for files/buffers act like bash
set wildmode=list:longest,list:full             " show a list when pressing tab and complete
set modeline
set complete+=k                                 " scan the files given with the 'dictionary' option
set whichwrap=b,s,<,>,[,],h,l                   " which keys move the cursor to previous/next line when the cursor is on the first/last character
set noswapfile                                  " do not write annoying intermediate swap files
set nobackup                                    " do not keep backup files, it's 70's style cluttering
set number
set relativenumber
set nolist
set wrap
set endofline                                   " Add empty newlines at the end of files
set browsedir=current " which directory to use for the file browser
set clipboard=unnamed
augroup change_dir "{{{
    autocmd!
    autocmd BufEnter * :lchdir %:p:h                 " The current directory is the directory of the file in the current window.
augroup END "}}}

set formatoptions+=1                            " long lines are not broken in insert mode
set formatoptions-=t                            " noautowrap text using textwidth
set formatoptions-=c                            " autowrap comments using textwidth
set formatoptions+=o                            " automatically insert the current comment leader after hitting 'o' in Normal mode
set formatoptions+=r                            " as above but after <Enter> in Insert mode

set diffopt+=iwhite     " ignore white spaces
set diffopt+=context:3  " context for diff
if has('patch-8.1.0360')
    set diffopt+=indent-heuristic
    set diffopt+=algorithm:patience
endif

if has('folding')
    set foldenable                              " enable folding
    set foldcolumn=0                            " add a fold column
    set foldmethod=marker
    " set foldmethod=expr
    set foldexpr=MyFoldExpr(v:lnum)
    function! MyFoldExpr(lnum) abort
        " Sprawdź, czy linia jest pusta
        if empty(getline(a:lnum))
            return '='
        endif

        " Domyślnie stosuj foldexpr oparty na wcięciach
        return indent(a:lnum) / shiftwidth(a:lnum)
    endfunction

    " Mappings to easily toggle fold levels
    nnoremap z0 :set foldlevel=0<cr>
    nnoremap z1 :set foldlevel=1<cr>
    nnoremap z2 :set foldlevel=2<cr>
    nnoremap z3 :set foldlevel=3<cr>
    nnoremap z4 :set foldlevel=4<cr>
    nnoremap z5 :set foldlevel=5<cr>
    " Don't open folds when search into them
    " set foldopen-=search
    " Don't open folds when undo stuff
    set foldopen-=undo
    set foldlevelstart=20
endif

if g:MSWIN64 && has('gui_running') "{{{
    augroup WIN
        autocmd!
        autocmd GUIEnter * simalt ~x
    augroup END
elseif has('gui_running')
    " Maximize GVim on start
    set lines=999 columns=999
endif "}}}

if has('gui_running') "{{{
    set guioptions+=t                           " include tearoff menu items
    set guioptions-=T                           " exclude Toolbar
    if g:MSWIN
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    elseif g:MACOS
        set guifont=AgaveNF-Regular:h15
    elseif g:UNIX
        set guifont=JetBrains\ Mono\ 12
    endif
endif "}}}

" highlight line under cursor, horizontal cursor
nnoremap <Leader>l :setlocal cursorline!<CR>
nnoremap <Leader>L :setlocal cursorcolumn!<CR>

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Sort paragraphs
vnoremap <leader>s !sort -f<CR>gv
nnoremap <leader>s vip!sort -f<CR><Esc>

" Turn off hlsearch
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap <Leader>H :set hlsearch!<CR>

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l

" refresh syntax highlight
noremap <silent> <F10> <Esc>:syntax sync fromstart<CR>
inoremap <silent> <F10> <C-o>:syntax sync fromstart<CR>

" open file under cursors in a new window (a vertical split)
map <c-w>F :vertical wincmd f<CR>

" C-U in insert/normal mode, to uppercase the word under cursor
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe
" C-L in insert/normal mode, to lowercase the word under cursor
inoremap <c-l> <esc>viwuea
nnoremap <c-l> viwue

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

" search for visually highlighted text, with spec chars
vmap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" change search mapping and don't jump
nnoremap * g*``
nnoremap # g#``
" nnoremap g* *``
" nnoremap g# #``

" Moving cursor to other windows:
" shift down   : change window focus to lower one (cyclic)
" shift up     : change window focus to upper one (cyclic)
" shift left   : change window focus to one on left
" shift right  : change window focus to one on right
nnoremap <s-down>   <c-w>w
nnoremap <s-up>     <c-w>W
nnoremap <s-left>   <c-w>h
nnoremap <s-right>  <c-w>l

" Navigate on a wrapped line as the normal
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" nnoremap <Down> gj
" nnoremap <Up> gk
" vnoremap <Down> gj
" vnoremap <Up> gk
" inoremap <Up> <C-o>gk
" inoremap <Up> <C-o>gk
let g:pluginIsEnabledDirectory = VIMRC . '/plugged'
let g:pluginIsEnabledVerbose = 0


""" Plugins configuration {{{

"" Plugin: committia.vim
if plugin#isEnabled('committia.vim')
    " let g:committia_min_window_width = 30
endif
"" Plugin: ale
if plugin#isEnabled('ale')
    " extended logging
    let g:ale_history_log_output = 1
    let g:ale_history_enabled = 1
    " virtual text appearing at ends of lines
    let g:ale_virtualtext_cursor = 'current'
    let g:ale_open_list = 0
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
    " Write this in your vimrc file
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_insert_leave = 0
    " You can disable this option too
    " if you don't want linters to run on opening a file
    let g:ale_lint_on_enter = 0
    " Set this variable to 1 to fix files when you save them.
    let g:ale_fix_on_save = 0
    " <C-x><C-o>
    set omnifunc=ale#completion#OmniFunc
endif

"" Plugin: vim-indent-guides
if plugin#isEnabled('vim-indent-guides')
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
endif

"" Plugin: gruvbox
if plugin#isEnabled('gruvbox')
    let g:gruvbox_italic = 1
    let g:gruvbox_italicize_comments = 1
    let g:gruvbox_italicize_strings = 1
endif

"" Plugin: vim-commentary {{{
if plugin#isEnabled('vim-commentary')
    augroup vim_commentary
        au!
        autocmd FileType apache setlocal commentstring=#\ %s
        autocmd FileType dosini setlocal commentstring=#\ %s
    augroup END
endif
"" }}}

"" Plugin: vim-table-mode {{{
if plugin#isEnabled('vim-table-mode')
    function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
    endfunction

    inoreabbrev <expr> <bar><bar>
            \ <SID>isAtStartOfLine('\|\|') ?
            \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
    inoreabbrev <expr> __
            \ <SID>isAtStartOfLine('__') ?
            \ '<c-o>:silent! TableModeDisable<cr>' : '__'
endif
"" }}}

"" Plugin: rainbow
if plugin#isEnabled('rainbow')
    let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
endif

"" Plugin: helpful.vim
if plugin#isEnabled('helpful.vim')
    " let b:helpful=1
endif

"" Plugin: vim-signify {{{
if plugin#isEnabled('vim-signify')
    " default updatetime 4000ms is not good for async update
    set updatetime=100
endif
"" }}}

"" Plugin: vim-shfmt {{{
if plugin#isEnabled('vim-shfmt')
" :Shfmt
" gq for paragraph
" gqip
    augroup  shfmt
        autocmd!
        autocmd  FileType sh let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
    augroup END
endif
"" }}}

"" Plugin: bash-support {{{
if plugin#isEnabled('bash-support')
    if g:UNIX
        " see ~/.config/vim/local.vim
        let g:BASH_LocalTemplateFile    = VIMRC . '/templates/bash-support/templates/Templates'
        if g:MACOS
            let g:BASH_Executable       = '/usr/local/bin/bash'
        else
            let g:BASH_Executable       = '/usr/bin/bash'
        endif
    endif
endif

"" }}}
"" Plugin: vim-better-whitespace {{{
if plugin#isEnabled('vim-better-whitespace')
    let g:better_whitespace_enabled=1
    let g:strip_whitespace_on_save=1
endif
"" }}}

"" Plugin: Completor {{{
if plugin#isEnabled('completor.vim')
    " Use TAB to complete when typing words, else inserts TABs as usual.  Uses
    " dictionary, source files, and completor to find matching words to complete.

    " Note: usual completion is on <C-n> but more trouble to press all the time.
    " Never type the same word twice and maybe learn a new spellings!
    " Use the Linux dictionary when spelling is in doubt.
    function! Tab_Or_Complete() abort
        " If completor is already open the `tab` cycles through suggested completions.
        if pumvisible()
            return "\<C-N>"
        " If completor is not open and we are in the middle of typing a word then
        " `tab` opens completor menu.
        elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~# '^[[:keyword:][:ident:]]'
            return "\<C-R>=completor#do('complete')\<CR>"
        else
            " If we aren't typing a word and we press `tab` simply do the normal `tab`
            " action.
            return "\<Tab>"
        endif
    endfunction

    " Use `tab` key to select completions.  Default is arrow keys.
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
    " Close popup by <Space>.
    inoremap <expr> <Space> pumvisible() ? "\<C-y>" : "\<Space>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

    " Use tab to trigger auto completion.  Default suggests completions as you type.
    let g:completor_auto_trigger = 0
    inoremap <expr> <Tab> Tab_Or_Complete()

    let g:completor_complete_options = 'menuone,noselect,preview'
endif
"" }}}

"" Plugin: coc.nvim {{{
if plugin#isEnabled('coc.nvim')
    let g:coc_global_extensions = [
                \ 'coc-omni',
                \ 'coc-ultisnips',
                \ 'coc-snippets',
                \ 'coc-json',
                \ 'coc-sh',
                \ 'coc-vimlsp',
                \ 'coc-yaml',
                \ 'coc-highlight',
                \ 'coc-git'
                \]
    " Use tab for trigger completion with characters ahead and navigate
    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config
    inoremap <silent> <expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
    inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " You have to remap <cr> to make it confirm completion.
    inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

    function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " use <c-space> for trigger completion
    if has('nvim')
        inoremap <silent> <expr> <c-space> coc#refresh()
    else
        inoremap <silent> <expr> <c-@> coc#refresh()
    endif

    " GoTo code navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    " Use K to show documentation in preview window
    nnoremap <silent> K :call ShowDocumentation()<CR>

    function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " Remap keys for applying refactor code actions
    nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
    xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
    nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

    " Run the Code Lens action on the current line
    nmap <leader>cl  <Plug>(coc-codelens-action)

    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)<cr>

    " coc-vimlsp
    let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

    " Remap <C-f> and <C-b> to scroll float windows/popups
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        nnoremap <silent><nowait><expr> <S-Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<S-Down>"
        nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        nnoremap <silent><nowait><expr> <S-Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<S-Up>"

        inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <S-Down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
        inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
        inoremap <silent><nowait><expr> <S-Up> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

        vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        vnoremap <silent><nowait><expr> <S-Down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<S-Down>"
        vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        vnoremap <silent><nowait><expr> <S-Up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<S-Up>"
        endif
    endif
"" }}}

"" Plugin: neocomplete {{{
if plugin#isEnabled('neocomplete.vim')
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 2

    " Plugin key-mappings.
    inoremap <expr> <C-g>     neocomplete#undo_completion()
    inoremap <expr> <C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        " For no inserting <CR> key.
        return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
    " Close popup by <Space>.
    inoremap <expr> <Space> pumvisible() ? "\<C-y>" : "\<Space>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr> <C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr> <BS> neocomplete#smart_close_popup()."\<C-h>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Enable omni completion.
    augroup omni_completion_neocomplete
        autocmd!
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END
    "" }}}
endif

"" Plugin: supertab
if plugin#isEnabled('supertab')
    let g:SuperTabDefaultCompletionType = 'context'
    let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
    let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
    let g:SuperTabContextDiscoverDiscovery =
            \ ['&completefunc:<c-p>', '&omnifunc:<c-x><c-o>']
    augroup omni_completion_supertab
        autocmd FileType *
            \ if &omnifunc != '' |
            \   call SuperTabChain(&omnifunc, "<c-p>") |
            \ endif
    augroup END
    " inoremap <expr> <Up> <Plug>SuperTabForward
    " inoremap <expr> <Down> <Plug>SuperTabBackward
endif

"" Plugin: CompleteParameter.vim {{{
if plugin#isEnabled('CompleteParameter.vim')
    inoremap <silent> <expr> ( complete_parameter#pre_complete("()")
    smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
    imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
    smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
    imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
endif
"" }}}

"" Plugin: NERD Commenter {{{
if plugin#isEnabled('nerdcommenter')
    " Create default mappings
    let g:NERDCreateDefaultMappings = 1
    " Comment the whole lines in visual mode
    let g:NERDCommentWholeLinesInVMode=1
    " Add space after the left delimiter and before the right delimiter
    let g:NERDSpaceDelims=1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs=1
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines=1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace=1
    " Add your own custom formats or override the defaults
    if !exists('NERDCustomDelimiters')
        let g:NERDCustomDelimiters = {}
    endif
    let g:NERDCustomDelimiters.brew = { 'left': '#', 'leftAlt': '#', 'right': '' }
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    " let g:NERDAltDelims_java = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not
    " let g:NERDToggleCheckAllLines = 1
endif
"" }}}

"" Plugin: NERDTree {{{
if plugin#isEnabled('nerdtree')
    " open NERDTree with F3
    " nnoremap <silent> <F3> :call ToggleTree()<CR>
    " nnoremap <silent> <S-F3> :call SyncTree()<CR>
    nnoremap <F3> :NERDTreeToggle<CR>
endif
"" }}}

"" Plugin: vim-nerdtree-tabs {{{
if plugin#isEnabled('vim-nerdtree-tabs')
    map <F3> <plug>NERDTreeTabsToggle<CR>
    let g:nerdtree_tabs_open_on_console_startup = 2
    let g:nerdtree_tabs_focus_on_files = 1
    let g:nerdtree_tabs_autofind = 1
    let g:nerdtree_tabs_focus_on_files = 1
endif
"" }}}

"" Plugin: vim-airline {{{
if plugin#isEnabled('vim-airline')
    let g:airline_powerline_fonts = 1
    let g:airline_skip_empty_sections = 1
endif
"" }}}

"" Plugin: taglist.vim {{{
if plugin#isEnabled('taglist.vim')
    noremap <silent> <S-F11> :TlistToggle<CR>
    inoremap <silent> <S-F11> <C-C>:TlistToggle<CR>
    let tlist_perl_settings = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD;k:comments'
    let tlist_sh_settings   = 'sh;f:functions;v:variables;c:constants'
    let Tlist_Enable_Fold_Column=0
    let Tlist_Exit_OnlyWindow=1             " quit when TagList is the last open window
    let Tlist_GainFocus_On_ToggleOpen=1     " put focus on the TagList window when it opens
    " let Tlist_Process_File_Always=1       " process files in the background, even when the TagList window isn't open
    " let Tlist_Show_One_File=1             " only show tags from the current buffer, not all open buffers
    let Tlist_WinWidth=40                   " set the width
    let Tlist_Inc_Winwidth=1                " increase window by 1 when growing
    " shorten the time it takes to highlight the current tag (default is 4 secs)
    " note that this setting influences Vim's behaviour when saving swap files,
    " but we have already turned off swap files (earlier)
    " set updatetime=1000
    " show function/method prototypes in the list
    let Tlist_Display_Prototype=1
    " don't show scope info
    let Tlist_Display_Tag_Scope=1
    " show TagList window on the left
    let Tlist_Use_Left_Window=1
endif
"" }}}

"" Plugin: tagbar {{{
if plugin#isEnabled('tagbar')
    noremap  <silent> <F12>       :TagbarToggle<CR>
    inoremap <silent> <F12>  <C-C>:TagbarToggle<CR>
    let g:tagbar_left             = 1
    let g:tagbar_sort             = 0
    let g:tagbar_show_linenumbers = 0
    let g:tagbar_autofocus        = 1
    "let g:tagbar_width           = 30
    "let g:tagbar_vertical        = 30
    let g:tagbar_compact = 1
    let g:tagbar_type_ansible = {
        \ 'ctagstype' : 'ansible',
        \ 'kinds' : [
        \ 't:tasks',
        \ 'h:hosts'
        \ ],
        \ 'sort' : 0
        \ }
    let g:tagbar_type_terraform = {
        \ 'ctagstype' : 'terraform',
        \ 'kinds' : [
        \ 'r:resources',
        \ 'm:modules',
        \ 'o:outputs',
        \ 'v:variables',
        \ 'f:tfvars'
        \ ],
        \ 'sort' : 0
        \ }
    let g:tagbar_type_make = {
        \ 'kinds':[
        \ 'm:macros',
        \ 't:targets'
        \ ]
        \}
    " fix your ~/.ctags https://gist.github.com/dracorp/5d7308b894c1c9f301bc9cb8d2f262db
    let g:tagbar_type_sh = {
        \ 'kinds':[
        \ 'f:functions',
        \ 'c:constants',
        \ 'v:variables'
        \ ]
        \}
    let g:tagbar_type_markdown = {
        \ 'ctagstype'    : 'markdown',
        \ 'kinds'        : [
            \ 'c:chapter:0:1',
            \ 's:section:0:1',
            \ 'S:subsection:0:1',
            \ 't:subsubsection:0:1',
            \ 'T:l4subsection:0:1',
            \ 'u:l5subsection:0:1',
        \ ],
        \ 'sro'            : '""',
        \ 'kind2scope'    : {
            \ 'c' : 'chapter',
            \ 's' : 'section',
            \ 'S' : 'subsection',
            \ 't' : 'subsubsection',
            \ 'T' : 'l4subsection',
        \ },
        \ 'scope2kind'    : {
            \ 'chapter' : 'c',
            \ 'section' : 's',
            \ 'subsection' : 'S',
            \ 'subsubsection' : 't',
            \ 'l4subsection' : 'T',
        \ },
    \ }
    let g:tagbar_type_css = {
        \ 'ctagstype' : 'Css',
            \ 'kinds'     : [
                \ 'c:classes',
                \ 's:selectors',
                \ 'i:identities'
            \ ]
        \ }
    let g:tagbar_type_go = {
        \ 'ctagstype': 'go',
        \ 'kinds' : [
            \'p:package',
            \'f:function',
            \'v:variables',
            \'t:type',
            \'c:const'
        \]
    \}
    let g:tagbar_type_groovy = {
        \ 'ctagstype' : 'groovy',
        \ 'kinds'     : [
            \ 'p:package:1',
            \ 'c:classes',
            \ 'i:interfaces',
            \ 't:traits',
            \ 'e:enums',
            \ 'm:methods',
            \ 'f:fields:1'
        \ ]
    \ }
    let g:tagbar_type_json = {
        \ 'ctagstype' : 'json',
        \ 'kinds' : [
        \ 'o:objects',
        \ 'a:arrays',
        \ 'n:numbers',
        \ 's:strings',
        \ 'b:booleans',
        \ 'z:nulls'
        \ ],
    \ 'sro' : '.',
        \ 'scope2kind': {
        \ 'object': 'o',
        \ 'array': 'a',
        \ 'number': 'n',
        \ 'string': 's',
        \ 'boolean': 'b',
        \ 'null': 'z'
        \ },
        \ 'kind2scope': {
        \ 'o': 'object',
        \ 'a': 'array',
        \ 'n': 'number',
        \ 's': 'string',
        \ 'b': 'boolean',
        \ 'z': 'null'
        \ },
        \ 'sort' : 0
    \ }
    let g:tagbar_type_perl = {
        \ 'ctagstype' : 'perl',
        \ 'kinds'     : [
            \ 'p:package:0:0',
            \ 'w:roles:0:0',
            \ 'e:extends:0:0',
            \ 'u:uses:0:0',
            \ 'r:requires:0:0',
            \ 'o:ours:0:0',
            \ 'a:properties:0:0',
            \ 'b:aliases:0:0',
            \ 'h:helpers:0:0',
            \ 's:subroutines:0:0',
            \ 'd:POD:1:0'
        \ ]
    \ }
endif
"" }}}

"" Plugin: Vista {{{
if plugin#isEnabled('vista.vim')
    noremap  <silent> <S-F12>       :Vista!!<CR>
    inoremap <silent> <S-F12>  <C-C>:Vista!!<CR>
endif
"" }}}

"" Plugin: vint-syntastic {{{
if plugin#isEnabled('syntastic')
    let g:syntastic_vim_checkers = ['vint']
endif
"" }}}

""" }}}

"## Functions {{{

" Exclamation mark(!) means that function replace previous

let g:quickfix_is_open = 0
function! s:QuickfixToggle() abort
    " Toggle the quickfix window
    " From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . 'wincmd w'
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

let g:last_fold_column_width = 4 " Pick a sane default for the foldcolumn
function! FoldColumnToggle() abort
    " Toggle the foldcolumn
    " From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
    if &foldcolumn
        let g:last_fold_column_width = &foldcolumn
        setlocal foldcolumn=0
    else
        let &l:foldcolumn = g:last_fold_column_width
    endif
endfunction
nnoremap <leader>f :call FoldColumnToggle()<cr>

function! CheckReadonly() abort
    " Do not allow on any modifications read only files
    if v:version >= 600
        if &readonly
            setlocal nomodifiable
        endif
    endif
endfunction
nnoremap <leader>r :call CheckReadonly()<cr>

function! ChangeFileencoding() abort
    let encodings = ['cp1250','utf-8','iso8859-2','iso8859-1','iso8859-15']
    let prompt_encs = []
    let index = 0
    while index < len(encodings)
        call add(prompt_encs, index.'. '.encodings[index])
        let index = index + 1
    endwhile
    let choice = inputlist(prompt_encs)
    if choice >= 0 && choice < len(encodings)
        execute 'e ++enc='.encodings[choice].' %:p'
    endif
endf
" noremap  <silent> <F8>              :call ChangeFileencoding()<CR>

function! DisplayManpage() abort
    " Display man page for the file. The functions uses manpageview plugin.
    let filename = expand('%')
    let short_filename = expand('%:r')
    let filetype = &filetype
    " call manpageview#ManPageView(0,0,filename)
    call man#get_page('horizontal',filename)
    if v:errmsg ==? 'no manpage exists'
        " call manpageview#ManPageView(0,0,short_filename)
        call man#get_page('horizontal',short_filename)
        if v:errmsg ==? 'no manpage exists'
            call man#get_page('horizontal',filetype)
            " call manpageview#ManPageView(0,0,filetype)
        endif
    endif
endf
" noremap  <silent> <F1> :call DisplayManpage()<CR>

function! CopyAll() abort
    " mark whole
    exec 'normal ggVG'
    " copy whole
    exec 'normal +y'
endf

function! MyFoldText() abort
    " http://vim.wikia.com/wiki/Customize_text_for_closed_folds
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
            let line = getline( linenum )
            let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
            if comment_content !=# ''
                break
            endif
            let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
    else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace ==# '{'
            let line = getline(v:foldend)
            let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
            if endbrace ==# '}'
                let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
            endif
        endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = ' ' . n . ' lines'
    let sub = sub . '                                                                                                                  '
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
endfunction
set foldtext=MyFoldText()

function! s:set_all(option, val, ...) abort
    " How to apply a setting in all open tabs and windows?
    " https://vi.stackexchange.com/questions/12061/how-to-apply-a-setting-in-all-open-tabs-and-windows
    let val = eval(a:val)

    for t in range(1, tabpagenr('$'))
        for w in range(1, tabpagewinnr(t, '$'))
        if gettabwinvar(t, w, '&buftype') !=# ''
            continue
        endif
        call settabwinvar(t, w, '&'.a:option, val)
        endfor
    endfor
endfunction
command! -complete=option -nargs=+ SetAll call s:set_all(<f-args>)

function! DoFormatXML() range abort
    " Save the file type
    let l:origft = &filetype

    " Clean the file type
    set filetype=

    " Add fake initial tag (so we can process multiple top-level elements)
    exe ':let l:beforeFirstLine=' . a:firstline . '-1'
    if l:beforeFirstLine < 0
        let l:beforeFirstLine=0
    endif
    exe a:lastline . "put ='</PrettyXML>'"
    exe l:beforeFirstLine . "put ='<PrettyXML>'"
    exe ':let l:newLastLine=' . a:lastline . '+2'
    if l:newLastLine > line('$')
        let l:newLastLine=line('$')
    endif

    " Remove XML header
    exe ':' . a:firstline . ',' . a:lastline . 's/<\?xml\\_.*\?>\\_s*//e'

    " Recalculate last line of the edited code
    let l:newLastLine=search('</PrettyXML>')

    " Execute external formatter
    exe ':silent ' . a:firstline . ',' . l:newLastLine . '!xmllint --noblanks --format --recover -'

    " Recalculate first and last lines of the edited code
    let l:newFirstLine=search('<PrettyXML>')
    let l:newLastLine=search('</PrettyXML>')

    " Get inner range
    let l:innerFirstLine=l:newFirstLine+1
    let l:innerLastLine=l:newLastLine-1

    " Remove extra unnecessary indentation
    exe ':silent ' . l:innerFirstLine . ',' . l:innerLastLine 's/^  //e'

    " Remove fake tag
    exe l:newLastLine . 'd'
    exe l:newFirstLine . 'd'

    " Put the cursor at the first line of the edited code
    exe ':' . l:newFirstLine

    " Restore the file type
    exe 'set filetype=' . l:origft
endfunction
command! -range=% FormatXML <line1>,<line2>call DoFormatXML()
" nmap <silent> <leader>x :%FormatXML<CR>
" vmap <silent> <leader>x :FormatXML<CR>

function! RemoveDiacritics(...) abort
    if a:0 == 0
        let s:locale='pl'
    else
        let s:locale=a:1
    endif
    if s:locale ==? 'pl'
        let l = 1
        for line in getline(1,'$')
            call setline(l, substitute(line, '[ąĄćĆęĘłŁńŃóÓśŚźŹżŻ]', "\={'ą':'a','Ą':'A','ć':'c','Ć':'C','ę':'e','Ę':'E','ł':'l','Ł':'L','ń':'n','Ń':'N','ó':'o','Ó':'O','ś':'s','Ś':'S','ź':'z','Ź':'Z','ż':'z','Ż':'Z'}[submatch(0)]", 'g'))
            let l = l + 1
        endfor
    endif
endfunction
command! -nargs=0 RemoveDiacritics call RemoveDiacritics()

function! ToggleFoldMethod() abort
    if (&foldmethod ==? 'indent')
        setlocal foldmethod=manual
        echo 'Foldmethod: manual'
    elseif (&foldmethod ==? 'manual')
        setlocal foldmethod=syntax
        echo 'Foldmethod: syntax'
    elseif (&foldmethod ==? 'syntax')
        setlocal foldmethod=marker
        echo 'Foldmethod: marker'
    elseif (&foldmethod ==? 'marker')
        setlocal foldmethod=expr
        echo 'Foldmethod: expr'
    elseif (&foldmethod ==? 'expr')
        setlocal foldmethod=diff
        echo 'Foldmethod: diff'
    else
        setlocal foldmethod=indent
        echo 'Foldmethod: indent'
    endif
endfunction
nnoremap <silent> <Leader>F   :call ToggleFoldMethod()<CR>

" Toggle signcolumn. Works only on vim>=8.0 or NeoVim
if has('signs') && v:version >= 800
    function! ToggleSignColumn() abort
        if !exists('b:signcolumn_on') || b:signcolumn_on
            set signcolumn=no
            let b:signcolumn_on=0
        else
            set signcolumn=auto
            let b:signcolumn_on=1
        endif
    endfunction
    nnoremap <Leader>S :call ToggleSignColumn()<CR>
endif

function! ToggleNumberColumn() abort
    if !exists('b:numbercolumn_on') || b:numbercolumn_on
        set nonumber
        set norelativenumber
        let b:numbercolumn_on=0
    else
        set number
        set relativenumber
        let b:numbercolumn_on=1
    endif
endfunction
" Toggle line numbers
nnoremap <Leader>n :call ToggleNumberColumn()<CR>


" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files() abort
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

function! s:align() abort
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" Hex Editor
let g:hexmode=0
function! HexEditToggle() abort
    if g:hexmode
        let g:hexmode=0
        %!xxd -r
    else
        let g:hexmode=1
        %!xxd
    endif
endfunction
nnoremap <silent> <F9> :call HexEditToggle()<CR>

" }}}

"### Additional Configs {{{
" let plugin_configurations=[
" \ 'functions.vim',
" \ ]
" for configuration in plugin_configurations
"     let config_path = join([VIMRC, configuration], '/')
"     if filereadable(config_path)
"         execute 'source ' . config_path
"     endif
" endfor
if filereadable(expand('~/.config/vim/local.vim'))
    source ~/.config/vim/local.vim
endif
"" }}}
