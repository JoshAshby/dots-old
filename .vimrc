"This all needs cleaned up...
set nocompatible               " be iMproved
filetype off                   " required!
set encoding=utf-8

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Manage itself
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'

" File related bundles
Plugin 'FuzzyFinder'
"Plugin 'mileszs/ack.vim'
"
" Git related bundles
Plugin 'fugitive.vim'
Plugin 'airblade/vim-gitgutter'

" Utils
Plugin 'scrooloose/nerdtree'
Plugin 'jeetsukumaran/vim-buffergator'

Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
"Plugin 'mkitt/tabline.vim'

"Plugin 'Shougo/neocomplete.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'

Plugin 'zirrostig/vim-schlepp'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'Raimondi/delimitMate'
Plugin 'docunext/closetag.vim.git'

Plugin 'vim-scripts/Align'

 "Plugin 'techlivezheng/vim-plugin-tagbar-phpctags'
" Plugin 'Auto-Pairs'
" Plugin 'vim-scripts/UltiSnips'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'honza/vim-snippets'
" Plugin 'vim-scripts/TaskList.vim'
Plugin 'ervandew/supertab'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'tpope/vim-surround'
" Plugin 'AndrewRadev/linediff.vim'

" Colors!
Plugin 'godlygeek/csapprox'
Plugin 'chriskempson/base16-vim'
Plugin 'flazz/vim-colorschemes'
" Plugin 'altercation/vim-colors-solarized'

" Language additions
Plugin 'groenewege/vim-less'
Plugin 'skammer/vim-css-color'
Plugin 'kchmck/vim-coffee-script'
Plugin 'plasticboy/vim-markdown'
Plugin 'Glench/Vim-Jinja2-Syntax'

"Plugin 'FredKSchott/CoVim'
Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

" enable cwd .vimrc files
set exrc

set undofile

" Make sure things look pretty and use a nice colorscheme for the gui
set t_Co=256
set background=dark
let g:airline_powerline_fonts=1
color base16-tomorrow

syntax on

if has('gui_running')
  set guifont=Liberation\ Mono\ for\ Powerline "make sure to escape the spaces in the name properly
  color base16-default
  set guioptions=e
endif

set number
set title
set showtabline=0
set nofoldenable

set laststatus=2

" set a line width and don't automatically reformat text to fit (toggle with ,<F8>
set textwidth=79
set fo-=t

set grepprg=egrep\ -nH\ $*

" highlight if we go over 79 chars wide
augroup vimrc_autocmds
        autocmd BufEnter * highlight OverLength ctermbg=green guibg=#592929
        autocmd BufEnter * match OverLength /\%79v.*/
augroup END

" Strip whitespace when working in these filetypes
autocmd FileType c,cpp,java,php,python,coffee,javascript,css,less,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

" Enable html tag closing on typical html style file types
autocmd FileType html,djangohtml,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd BufRead,BufNewFile *.jbuilder set filetype=Ruby

set wildmenu
set wildmode=list:longest,full
set nohidden

" set cursorline highlight
hi CursorLine term=none cterm=none ctermbg=1

" fast terminal
set ttyfast

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

" display commands as-typed + current position in file
set showcmd
set ruler

" add git status to statusline; otherwise emulate standard line with ruler
" set statusline=[%{&fo}]%<%{fugitive#statusline()}\ %f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" set laststatus=2

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

" turn off tab expansion for Makefiles
au FileType make setlocal noexpandtab

" Setup supertab to use omni complete and such
set omnifunc=syntaxcomplete#Complete

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&normalfunc', '&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>", "&normalfunc:<c-x><c-n>"]
"let g:SuperTabDefaultCompletionType = "<c-x><c-n>"

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest

" nerdtree stuff
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" let NERDTreeChDirMode=0
" let NERDTreeShowHidden=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" buffergator stuff
let g:buffergator_suppress_keymaps=1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

python import sys; sys.path.append('/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python')

" airline stuff
let g:airline#extensions#hunks#enabled=0

let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#tagbar#flags='s'

let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#tabline#show_buffers=1

let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message=''

let g:airline#extensions#syntastic#enabled=1

" ====================== Keybindings...
" =====================================
" use comma for the leader key
let mapleader = ","

" reformat a paragraph
nmap <leader>q gqip

" write all changed buffers
nmap <silent> <leader>w :wa<CR>

" forward and backward in tabs and buffers
noremap <silent> <f2> :bprev<CR>
noremap <silent> <leader><F2> :tabprev<CR>
noremap <silent> <f3> :bnext<CR>
noremap <silent> <leader><F3> :tabnext<CR>

nmap <silent> <F4> :bprevious<CR>bdelete \#<CR>
noremap <silent> <leader><f4> :tabclose<CR>

" Buffergator stuff
noremap <silent> <F10> :BuffergatorToggle<CR>
noremap <silent> <leader><F10> :BuffergatorTabsToggle<CR>

" toggle nerdtree and Tagbar
noremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <leader><F7> :TagbarToggle<CR>

"toggle paragraph formating
map <silent> <F8> :set fo+=t<CR>
map <silent> <leader><F8> :set fo-=t<CR>

" remove/hide highlighting from searches
map <silent> <F9> :set invhlsearch<CR>

nmap <silent> s :set spell<CR>
nnoremap <silent> <leader>s :set nospell<CR>

" new tab:
nmap <silent> <leader>y :tabnew<CR>

" fuzzyfinder
nmap <leader>f :FufFile<CR>

" display tabs - ,s will toggle (redraws just in case)
nmap <silent> <leader>t :set nolist!<CR>:redr<CR>
" This line blew up at me when I symlinked this file. no clue why
set listchars=tab:¿\ ,trail:·
set list

" remap ;to : since I tend to use : more often
nnoremap ; :

" Better space unfolding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
"nnoremap <space> za
"
map N Nzz
map n nzz

" Ctrl+backspace will delete the current work
inoremap <C-BS> <C-O>b<C-O>dw
noremap <C-BS> bdw

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
