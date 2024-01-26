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
let g:VIMRC   = expand('%:p:h')

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

" vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot
let g:polyglot_disabled = ['csv', 'jenkins', 'yaml']

if !has('compatible')
    let g:vim_plug_path=expand('~/.vim/autoload/plug.vim')
    if !filereadable(g:vim_plug_path)
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

    call plug#begin()
    " Plugins definition
    Plug 'https://github.com/junegunn/vim-plug'
    Plug 'https://github.com/tpope/vim-sensible' " Defaults everyone can agree on
    Plug 'https://github.com/preservim/nerdtree.git'
    Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight' " Extra syntax and highlight for nerdtree files
    Plug 'https://github.com/scrooloose/nerdcommenter'
    " Plug 'https://github.com/tpope/vim-commentary'
    Plug 'https://github.com/tpope/vim-scriptease'
    Plug 'https://github.com/ConradIrwin/vim-bracketed-paste'
    Plug 'https://github.com/godlygeek/tabular' " Vim script for text filtering and alignment
    Plug 'https://github.com/pbrisbin/vim-restore-cursor'
    Plug 'https://github.com/vim-scripts/better-whitespace'
    Plug 'https://github.com/andymass/vim-matchup'
    Plug 'https://github.com/tpope/vim-speeddating' " use CTRL-A/CTRL-X to increment dates, times, and more
    Plug 'https://github.com/tpope/vim-repeat' " enable repeating supported plugin maps with .
    Plug 'https://github.com/editorconfig/editorconfig-vim' " EditorConfig plugin for Vim
    Plug 'https://github.com/AndrewRadev/splitjoin.vim' " Switch between single-line and multiline forms of code
    Plug 'https://github.com/wgwoods/vim-scripts'
    Plug 'https://github.com/mbbill/undotree'
    Plug 'https://github.com/simnalamburt/vim-mundo' " 🎄 Vim undo tree visualizer
    Plug 'https://github.com/mhinz/vim-startify'
    Plug 'https://github.com/vimwiki/vimwiki' " Personal Wiki for Vim
    Plug 'https://github.com/ntpeters/vim-better-whitespace' " Better whitespace highlighting for Vim
    if v:version >= 740
        Plug 'https://github.com/WolfgangMehner/bash-support' " BASH IDE -- Write and run BASH-scripts using menus and hotkeys
    endif
    Plug 'https://github.com/WolfgangMehner/awk-support'
    Plug 'https://github.com/WolfgangMehner/c-support'
    Plug 'https://github.com/WolfgangMehner/perl-support'
    Plug 'https://github.com/vim-scripts/betterga' " Yet another :ascii command
    Plug 'https://github.com/tpope/vim-abolish' " abolish.vim: Work with several variants of a word at once
    Plug 'https://github.com/mzlogin/vim-markdown-toc' " A vim 7.4+ plugin to generate table of contents for Markdown files
    Plug 'https://github.com/Shougo/echodoc.vim'
    Plug 'https://github.com/Shougo/vimshell.vim'
    Plug 'https://github.com/Shougo/deol.nvim'
    Plug 'https://github.com/mbbill/fencview'
    Plug 'https://github.com/lilydjwg/colorizer' " A Vim plugin to colorize all text in the form #rrggbb or #rgb
    Plug 'https://github.com/xu-cheng/brew.vim' " 🍺 Vim Syntax for Homebrew formulae
    Plug 'https://github.com/vim-scripts/FavMenu.vim' " A new menu, like IE's Favourites, or Netscape's Bookmark
    Plug 'https://github.com/vim-scripts/FavEx' " Favorite file and directory explorer
    Plug 'https://github.com/dracorp/vim-pkgbuild' " easy work with ArchLinux PKGBUILD
    if v:version >= 800 && (v:version == 800 && has('patch27') || v:version > 800)
        Plug 'https://github.com/liuchengxu/vista.vim' " 🌵 Viewer & Finder for LSP symbols and tag
    endif
    Plug 'https://github.com/vim-scripts/DrawIt' " Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
    Plug 'https://github.com/itchyny/calendar.vim' " A calendar application for Vim
    Plug 'https://github.com/xolox/vim-misc' " Miscellaneous auto-load Vim scripts
    if executable('ctags')
        Plug 'https://github.com/vim-scripts/taglist.vim' " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
        Plug 'https://github.com/xolox/vim-easytags' " Automated tag file generation and syntax highlighting of tags in Vim
    endif
    Plug 'https://github.com/sheerun/vim-polyglot'
    Plug 'https://github.com/Shougo/vimproc.vim', {'do' : 'make'} " Interactive command execution in Vim
    Plug 'https://github.com/osyo-manga/vim-over' " :substitute preview
    " Plug 'https://github.com/itchyny/vim-cursorword' " Underlines the word under the cursor
    " YAML
    Plug 'https://github.com/pedrohdz/vim-yaml-folds'
    " CSV
    " Plug 'https://github.com/chrisbra/csv.vim'
    " Python
    Plug 'https://github.com/heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
    " Perl
    Plug 'https://github.com/wsdjeg/perldoc-vim'
    Plug 'https://github.com/c9s/perlomni.vim'
    Plug 'vim-perl/vim-perl' ", { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
    " View
    Plug 'https://github.com/vim-airline/vim-airline'
    Plug 'https://github.com/vim-airline/vim-airline-themes'
    Plug 'https://github.com/morhetz/gruvbox'
    Plug 'https://github.com/junegunn/goyo.vim'
    Plug 'https://github.com/junegunn/limelight.vim'
    " Checker
    Plug 'https://github.com/scrooloose/syntastic' " Syntax checking hacks for vim
    Plug 'https://github.com/itspriddle/vim-shellcheck'
    Plug 'https://github.com/z0mbix/vim-shfmt'
    " Tab complete
    if g:PYTHON && has('job') && has('timers') && has('lambda')
        Plug 'https://github.com/maralla/completor.vim'
        Plug 'https://github.com/maralla/completor-neosnippet'
    else
        if (v:version >= 703 && has('patch885') && has('lua')) && (v:version >= 802 && (v:version == 802 && has('patch1066')))
            Plug 'https://github.com/Shougo/neocomplete.vim'
            Plug 'https://github.com/Shougo/neosnippet-snippets'
            Plug 'https://github.com/Shougo/neosnippet.vim'
            Plug 'https://github.com/Shougo/vimshell.vim'
            Plug 'https://github.com/Shougo/neco-vim'
        else
            Plug 'https://github.com/ervandew/supertab'
        endif
    endif
    " Docker
    Plug 'https://github.com/wsdjeg/vim-dockerfile'
    " Groovy
    Plug 'https://github.com/wsdjeg/groovy.vim'
    Plug 'https://github.com/vim-scripts/groovy.vim'
    " JSON
    Plug 'https://github.com/gutenye/json5.vim'
    Plug 'https://github.com/elzr/vim-json'
    " Html
    Plug 'https://github.com/mattn/emmet-vim'
    if v:version <= 740
        Plug 'https://github.com/JulesWang/css.vim'
    endif
    Plug 'https://github.com/cakebaker/scss-syntax.vim'
    Plug 'https://github.com/ap/vim-css-color'
    Plug 'https://github.com/hail2u/vim-css3-syntax'
    Plug 'https://github.com/groenewege/vim-less'
    " Vim
    Plug 'https://github.com/todesking/vint-syntastic'
    Plug 'https://github.com/ynkdir/vim-vimlparser'
    Plug 'https://github.com/syngan/vim-vimlint'
    Plug 'https://github.com/Shougo/neco-vim'
    Plug 'https://github.com/tweekmonster/exception.vim'
    " XML
    Plug 'https://github.com/valloric/MatchTagAlways'
    Plug 'https://github.com/sukima/xmledit'
    " Git
    if executable('git')
        Plug 'https://github.com/tpope/vim-fugitive'        " A Git wrapper so awesome, it should be illegal
        Plug 'https://github.com/rhysd/committia.vim'       " A Vim plugin for more pleasant editing on commit messages
        if has('nvim') || has('patch-8.0.902')
            Plug 'https://github.com/mhinz/vim-signify' " ➕ Show a diff using Vim its sign column.
        else
            Plug 'https://github.com/mhinz/vim-signify', { 'tag': 'legacy' }
        endif
    endif
    if v:version >= 740
        Plug 'https://github.com/WolfgangMehner/git-support'
    endif
    Plug 'https://github.com/wavded/vim-stylus'
    Plug 'https://github.com/junegunn/gv.vim' " A git commit browser in Vim
    " Fuzzy/fzf
    Plug 'https://github.com/Shougo/neoyank.vim'
    if executable('fzf')
        Plug 'https://github.com/junegunn/fzf.vim'
        Plug 'https://github.com/justinhoward/fzf-neoyank'
    endif
    Plug 'https://github.com/Donaldttt/fuzzyy'

    " vim-devicons should be at the end
    Plug 'https://github.com/ryanoasis/vim-devicons'

    call plug#end()
    delc PlugUpgrade
endif
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
set nonumber
set norelativenumber
set nolist
set wrap
set endofline                                   " Add empty newlines at the end of files
set browsedir=current " which directory to use for the file browser
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
" nnoremap * g*``
" nnoremap # g#``
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
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Up> <C-o>gk
inoremap <Up> <C-o>gk

"## Plugins configuration {{{

"" Plugin: vim-signify {{{
" default updatetime 4000ms is not good for async update
set updatetime=100
"" }}}

"" Plugin: vim-shfmt {{{
" :Shfmt
" gq for paragraph
" gqip
augroup  shfmt
    autocmd!
    autocmd  FileType sh let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
augroup END
"" }}}

"" Plugin: bash-support {{{
if g:UNIX
    " see ~/.config/vim/local.vim
    let g:BASH_LocalTemplateFile    = VIMRC . '/templates/bash-support/templates/Templates'
    if g:MACOS
        let g:BASH_Executable       = '/usr/local/bin/bash'
    else
        let g:BASH_Executable       = '/usr/bin/bash'
    endif
endif

"" }}}
"" Plugin: vim-better-whitespace {{{
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
"" }}}

if g:PYTHON && has('job') && has('timers') && has('lambda')
    "" Plugin: Completor {{{
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

    " Use tab to trigger auto completion.  Default suggests completions as you type.
    let g:completor_auto_trigger = 0
    inoremap <expr> <Tab> Tab_Or_Complete()

    let g:completor_complete_options = 'menuone,noselect,preview'

    noremap <silent> <leader>d :call completor#do('definition')<CR>
    noremap <silent> <leader>c :call completor#do('doc')<CR>
    noremap <silent> <leader>f :call completor#do('format')<CR>
    noremap <silent> <leader>s :call completor#do('hover')<CR>
    "" }}}
else
    if (v:version >= 703 && has('patch885') && has('lua')) && (v:version >= 802 && (v:version == 802 && has('patch1066')))
        "" Plugin: neocomplete {{{
        " Use neocomplete.
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 2

        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
            " For no inserting <CR> key.
            return pumvisible() ? "\<C-y>" : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        " Close popup by <Space>.
        inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

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
    else
        " supertab
    endif
endif

"" Plugin: NERD Commenter {{{
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
"" }}}

"" Plugin: NERD Tree {{{
nnoremap <F3> :NERDTreeToggle<CR>
"" }}}

"" Plugin: vim-airline {{{
let g:airline_powerline_fonts = 1
"" }}}

"" Plugin: taglist.vim {{{
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
"" }}}

"" Plugin: Vista {{{
if v:version >= 800 && (v:version == 800 && has('patch27') || v:version > 800)
    noremap  <silent> <S-F12>       :Vista!!<CR>
    inoremap <silent> <S-F12>  <C-C>:Vista!!<CR>
endif
"" }}}

"" Plugin: vint-syntastic {{{
let g:syntastic_vim_checkers = ['vint']
"" }}}

" }}}

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
