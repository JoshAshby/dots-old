set shell=/bin/sh

"This all needs cleaned up...
set nocompatible               " be iMproved
filetype off                   " required!
set encoding=utf-8
scriptencoding utf-8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage itself
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'

" Git related bundles
Plugin 'fugitive.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/vcscommand.vim'

" Utils
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'majutsushi/tagbar'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'sjl/gundo.vim'

if has('gui_running')
  " Plugin 'vim-airline/vim-airline'
  Plugin 'itchyny/lightline.vim'
endif

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'

" Plugin 'Raimondi/delimitMate'
" Plugin 'docunext/closetag.vim.git'

Plugin 'vim-scripts/Align'
Plugin 'Yggdroot/indentLine'

Plugin 'ervandew/supertab'
" Plugin 'AndrewRadev/linediff.vim'
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-session'
Plugin 'mileszs/ack.vim'
Plugin 'sk1418/QFGrep'
Plugin 'Shougo/neocomplete.vim'

" Colors!
" Plugin 'godlygeek/csapprox'
" Plugin 'chriskempson/base16-vim'
" Plugin 'Junza/Spink'
" Plugin 'w0ng/vim-hybrid'
Plugin 'joshdick/onedark.vim'

" Language additions
" Plugin 'chrisbra/Colorizer'
" Plugin 'skammer/vim-css-color'
" Plugin 'plasticboy/vim-markdown'
" Plugin 'othree/yajs.vim'
" Plugin 'vim-ruby/vim-ruby'
Plugin 'dag/vim-fish'
Plugin 'ap/vim-css-color'

" Quick fuzzy searching for files
Plugin 'ctrlpvim/ctrlp.vim'

" Allow me to have .vimrc in directories
Plugin 'mantiz/vim-plugin-dirsettings'

call vundle#end()
filetype plugin indent on


" Terminal and GUI setup {{{
" Make sure things look pretty and use a nice colorscheme for the gui
" We need to set this here and not in the TermSetup() because otherwise it
" messes with the colorscheme for lightline
set t_Co=256
set background=dark
"colorscheme spink
"colorscheme base16-default-dark
colorscheme onedark

" enable cwd .vimrc files
call dirsettings#Install()
set exrc

" Use undo files for everything, so that undo is persisted across sessions
set undofile

function! TermSetup()
  " Make sure to escape the spaces in the name properly
  set guifont=Fira\ Code
  set guioptions=e
endfunction

function! GuiSetup()
  " Disable hover tooltips
  " This still doesn't work with ruby code >:|
  set noballooneval
  let g:netrw_nobeval=1

  " Make things look pretty with ligature fonts :3
  set macligatures

  " Show nerdtree on window open
  NERDTree
endfunction

augroup vimrc_autocmds
  autocmd!

  " Auto reload the vimrc when saving it
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

  " highlight if we go over 120 chars wide
  autocmd BufEnter * highlight OverLength ctermbg=green guibg=#592929
  autocmd BufEnter * match OverLength /\%120v.*/

  " Set some additional filetypes...
  autocmd BufRead,BufNewFile *.jbuilder,*.thor,*.rabl set filetype=ruby
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript
  autocmd BufRead,BufNewFile *.lookml set filetype=yaml

  " Strip whitespace when working in these filetypes
  autocmd FileType c,cpp,java,php,python,coffee,javascript,css,less,ruby,yaml autocmd BufWritePre <buffer> :%s/\s\+$//e

  " Enable html tag closing on typical html style file types
  autocmd FileType html,djangohtml,jinjahtml,eruby,mako let b:closetag_html_style=1

  " turn off tab expansion for Makefiles
  autocmd FileType make setlocal noexpandtab

  " Autocomplete setup for various files
  autocmd FileType * setlocal omnifunc=syntaxcomplete#Complete
  "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

  " Setup supertab
  autocmd FileType *
      \ if &omnifunc != '' |
      \     call SuperTabChain(&omnifunc, '<c-p>') |
      \ endif

  "autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
augroup END

augroup vim_start
  autocmd!

  autocmd VimEnter * call TermSetup()
  autocmd GUIEnter * call GuiSetup()
augroup END

set number
set title
set showtabline=1
set noshowmode
set nofoldenable
set hidden

" set a line width and don't automatically reformat text to fit (toggle with ,<F8>
set textwidth=79
set fo-=t

" Turn syntax highlighting on
syntax on

" fast terminal
set ttyfast
set synmaxcol=128
syntax sync minlines=256
set lazyredraw

" Use an older regex engine, which is supposedly faster for Ruby syntaxt
" highlighting
set re=2
" Don't do expensive regex for ruby
let ruby_no_expensive=1

" automagically adds /g on a regex. /g to disable
set gdefault
set nohidden

set foldmethod=manual
set noballooneval
let g:netrw_nobeval=1

" do not beep or flash at me
" vb is needed to stop beep
" t_vb sets visual bell action, we're nulling it out here)
set visualbell
set t_vb=
set noeb vb t_vb=
set vb t_vb=

" enable mouse for (a)ll, (n)ormal, (v)isual, (i)nsert, or (c)ommand line
" mode -- seems to work in most terminals
set mouse=a

" let me delete stuff like crazy in insert mode
set backspace=indent,eol,start

" keep lots of command-line history
set history=3500

" check spelling
set nospell
set spl=en

" search
set hlsearch
set showmatch
set incsearch
set nu
set incsearch
set ignorecase
set smartcase

" display tab characters as 4 spaces, indent 4 spaces,
" always use spaces instead of tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smarttab
set smartindent

" Use + register (X Window clipboard) as unnamed register
"set clipboard=unnamed,autoselect

"let g:session_autosave = 'no'

" This line blew up at me when I symlinked this file. no clue why
set listchars=tab:¿\ ,trail:·,nbsp:¬,extends:»,precedes:«
set list
" }}}

" Auto change directories in a smart way {{{
" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction

" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

autocmd BufRead *
  \ call FollowSymlink() |
  \ call SetProjectRoot()
" }}}

" Lightline {{{
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], [ 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \   'separator': { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '○' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''
      let branch = fugitive#head()
      return branch !=# '' ? mark.' '.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

command! LightlineReload call LightlineReload()

  " Syntastic Lightline {{{
  function! s:syntastic()
    SyntasticCheck
    call lightline#update()
  endfunction
  " }}}
" }}}


" Autocomplete {{{
"set wildmenu
"set wildmode=list:longest,full
"set completeopt=menu,preview,longest

"let g:SuperTabCrMapping = 0
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = '<c-x><c-u>'
"let g:SuperTabContextDefaultCompletionType = "<c-n>"

  " neocomplete {{{
  let g:acp_enableAtStartup = 0
  
  let g:neocomplete#data_directory = '~/.vim/tmp/neocomplete'
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1

  " Require 2 characters to start
  let g:neocomplete#auto_completion_start_length = 2

  " 
  "let g:neocomplete#enable_auto_select = 1

  " increase limit for tag cache files
  let g:neocomplete#sources#tags#cache_limit_size = 16777216 " 16MB

  " fuzzy completion breaks dot-repeat more noticeably
  " https://github.com/Shougo/neocomplete.vim/issues/332
  let g:neocomplete#enable_fuzzy_completion = 0

  " always use completions from all buffers
  if !exists('g:neocomplete#same_filetypes')
    let g:neocomplete#same_filetypes = {}
  endif
  let g:neocomplete#same_filetypes._ = '_'

  " enable omni-completion for Ruby
  "call neocomplete#util#set_default_dictionary(
        "\'g:neocomplete#sources#omni#input_patterns', 'ruby',
        "\'[^. *\t]\.\h\w*\|\h\w*::\w*')
        "
  " from neocomplete.txt:
  " Plugin key-mappings.
  inoremap <expr> <C-g> neocomplete#undo_completion()
  inoremap <expr> <C-l> neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

  function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction

  " <TAB>: completion.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " Close popup by <Space>.
  inoremap <expr><Space> (pumvisible() ? "\<C-y>" : "") . "\<Space>"
  " }}}
" }}}


" NERDTree {{{
"   Nerdtree defaults for window splitting are backwards from vim defaults.
let NERDTreeMapOpenVSplit='i'
let NERDTreeMapOpenSplit='s'

let NERDTreeShowBookmarks=1

let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

let NERDTreeMouseMode=2
let NERDTreeShowHidden=1

let NERDTreeKeepTreeInNewTab=1
let NERDTreeTabsOpenOnGuiStartup=1

let NERDTreeWinSize=35
" }}}

" NERDcommenter {{{
let g:NERDCustomDelimiters = {
\ 'ruby': { 'left': '# ', 'right': '', 'leftAlt': '# ', 'rightAlt': '' }
\ }

" Default to the alt style comments for ruby
let NERD_ruby_alt_style=1
" }}}


" Buffergator {{{
" Use the right side of the screen
let g:buffergator_viewport_split_policy='R'
" And let me use my own keymaps
let g:buffergator_suppress_keymaps=1
" }}}


" ctrlp {{{
if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif
" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

set wildignore+=*/node_modules/*,*/doc/*,*/coverage/*,*/public/*,*/dist/*,*/tmp/*,*/.git/*
" }}}


" Tagbar {{{
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
" }}}

" Searching {{{
set grepprg=egrep\ -nH\ $*
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}


" Gundo {{{
if has('python3')
  let g:gundo_prefer_python3 = 1
endif
" }}}


" Keymappings {{{
"my little pinky isa bit slow coming off that shift key sometimes.
command! W w
command! Q q
command! Wq wq

" ====================== Keybindings...
" =====================================
" use comma for the leader key
let mapleader = ","

" reformat a paragraph
nmap <leader>q gqip

" toggle nerdtree and Tagbar
noremap <silent> <F7> :NERDTreeToggle<CR>

" Buffergator stuff
noremap <silent> <F8> :BuffergatorTabsToggle<CR>
noremap <silent> <leader><F8> :BuffergatorToggle<CR>

" Gundo stuff
noremap <silent> <F9> :GundoToggle<CR>

" Tagbar stuff
nnoremap <silent> <F10> :TagbarToggle<CR>

" remove/hide highlighting from searches
map <silent> <F11> :set invhlsearch<CR>

"toggle paragraph formating
map <silent> <F12> :set fo+=t<CR>
map <silent> <leader><F12> :set fo-=t<CR>

nmap <silent> s :set spell<CR>
nnoremap <silent> <leader>s :set nospell<CR>

" display tabs - ,t will toggle (redraws just in case)
nmap <silent> <leader>t :set nolist!<CR>:redr<CR>

" Better space unfolding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
nnoremap <silent> zj o<Esc>,<F10>
nnoremap <silent> zk O<Esc>
"nnoremap <space> za

" Better navigation on search results
map N Nzz
map n nzz

" dont deselect on indent
vnoremap < <gv
vnoremap > >gv

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Allow us to just use the normal movement keys with ctrl to move about the
" window panes
map <C-J> <C-W>j
map <C-K> <C-W>k
map <c-h> <c-w>h
map <c-l> <c-w>l

" Disable F1 help and change it to esc
map <F1> <Esc>
imap <F1> <Esc>

" Highlight things
nnoremap <silent> <leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
nnoremap <silent> <leader>k :execute 'match Search /\%'.virtcol('.').'v/'<CR>
nnoremap <silent> <leader>j :call clearmatches()<CR>

" Highlight cursor line and columns
nnoremap <silent> <leader>c :set cursorline! cursorcolumn!<CR>
nnoremap <silent> <leader>z :set cursorline!<CR>
nnoremap <silent> <leader>x :set cursorcolumn!<CR>

" VCS things
nnoremap <silent> <leader>b :VCSBlame<CR>
nnoremap <silent> <leader>d :VCSDiff<CR>

" Copy full and short file paths to the clipboard
nmap <silent> <leader>yf :let @*=expand("%:p")<CR>
nmap <silent> <leader>ys :let @*=expand("%")<CR>

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" close, delete and move to the next buffer
nmap <leader>bq :bp <BAR> bd #<cr>
" }}}
