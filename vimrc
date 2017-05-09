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
" Plugin 'jeetsukumaran/vim-buffergator'
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

Plugin 'ervandew/supertab'
" Plugin 'AndrewRadev/linediff.vim'
" Plugin 'xolox/vim-misc'
" Plugin 'xolox/vim-session'

" Colors!
" Plugin 'godlygeek/csapprox'
Plugin 'chriskempson/base16-vim'
Plugin 'Junza/Spink'
Plugin 'w0ng/vim-hybrid'

" Language additions
" Plugin 'chrisbra/Colorizer'
" Plugin 'skammer/vim-css-color'
" Plugin 'plasticboy/vim-markdown'
" Plugin 'othree/yajs.vim'
" Plugin 'vim-ruby/vim-ruby'

" Quick fuzzy searching for files
Plugin 'ctrlpvim/ctrlp.vim'

" Allow me to have .vimrc in directories
Plugin 'mantiz/vim-plugin-dirsettings'

call vundle#end()
filetype plugin indent on

" Make sure things look pretty and use a nice colorscheme for the gui
set t_Co=256
set background=dark
"colorscheme spink
"colorscheme base16-default-dark
colorscheme hybrid

call dirsettings#Install()

" enable cwd .vimrc files
set exrc

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

" display commands as-typed + current position in file
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
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
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
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
      let mark = '⭠'
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

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
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

"let g:session_autosave = 'no'

set number
set title
set showtabline=1
set noshowmode
set nofoldenable

" set a line width and don't automatically reformat text to fit (toggle with ,<F8>
set textwidth=79
set fo-=t

set grepprg=egrep\ -nH\ $*

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

set wildmenu
set wildmode=list:longest,full
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

set completeopt=menu,preview,longest

let g:SuperTabCrMapping = 0
let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = '<c-x><c-u>'
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" NERDTree enhancements/fixes
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

" nerdcommenter things
let g:NERDCustomDelimiters = {
\ 'ruby': { 'left': '# ', 'right': '', 'leftAlt': '# ', 'rightAlt': '' }
\ }

let NERD_ruby_alt_style=1

" buffergator stuff
" let g:buffergator_suppress_keymaps=1

" ctrlp ignore settings
if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif

set wildignore+=*/node_modules/*,*/doc/*,*/coverage/*,*/public/*,*/dist/*,*/tmp/*,*/.git/*

" This line blew up at me when I symlinked this file. no clue why
set listchars=tab:¿\ ,trail:·,nbsp:¬,extends:»,precedes:«
set list

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

" forward and backward in tabs and buffers
noremap <silent> <f2> :bprev<CR>
noremap <silent> <leader><F2> :tabprev<CR>
noremap <silent> <f3> :bnext<CR>
noremap <silent> <leader><F3> :tabnext<CR>

nmap <silent> <F4> :bprevious<CR>bdelete \#<CR>
noremap <silent> <leader><f4> :tabclose<CR>

" toggle nerdtree and Tagbar
noremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <leader><F7> :TagbarToggle<CR>

"toggle paragraph formating
map <silent> <F8> :set fo+=t<CR>
map <silent> <leader><F8> :set fo-=t<CR>

" remove/hide highlighting from searches
map <silent> <F9> :set invhlsearch<CR>

" Buffergator stuff
"noremap <silent> <F10> :BuffergatorToggle<CR>
"noremap <silent> <leader><F10> :BuffergatorTabsToggle<CR>

" Gundo stuff
noremap <silent> <F10> :GundoToggle<CR>

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
nmap <silent> <leader>yf :let @*=expand("%")<CR>
nmap <silent> <leader>ys :let @*=expand("%:p")<CR>
