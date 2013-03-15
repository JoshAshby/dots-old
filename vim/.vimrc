syntax on
set number
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

Bundle 'gmarik/vundle'
Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'TeX-9'
Bundle 'fugitive.vim'
Bundle 'Auto-Pairs'
Bundle 'TabBar'
Bundle 'scrooloose/nerdtree'
Bundle 'flazz/vim-colorschemes'
Bundle 'desert-warm-256'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/syntastic'
Bundle 'AndrewRadev/linediff.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'airblade/vim-gitgutter'
Bundle 'plasticboy/vim-markdown'
Bundle 'chriskempson/base16-vim'
Bundle 'groenewege/vim-less'
Bundle 'skammer/vim-css-color'
" Bundle 'vim-scripts/Pydiction'
" Bundle 'mileszs/ack.vim'

set title
" set showtabline=0

filetype plugin on
filetype indent on

" set ofu=syntaxcomplete#Complete
" autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
"
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest

" set a line width and reformat text to fit
set textwidth=79
set fo-=t

" highlight if we go over 79 chars wide
augroup vimrc_autocmds
        autocmd BufEnter * highlight OverLength ctermbg=green guibg=#592929
        autocmd BufEnter * match OverLength /\%79v.*/
augroup END

autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" set up window positions
" let g:NERDTreeWinPos = "right"
let Tlist_Use_Right_Window   = 1

" fuzzyfinder
set wildmenu
set wildmode=list:longest,full
set nohidden

" set cursorline highlight
hi CursorLine term=none cterm=none ctermbg=1

" fast terminal
set ttyfast

" nerdtree stuff
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" let NERDTreeChDirMode=0
" let NERDTreeShowHidden=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" do not beep or flash at me
" vb is needed to stop beep
" t_vb sets visual bell action, we're nulling it out here)
set visualbell
set t_vb=

" enable mouse for (a)ll, (n)ormal, (v)isual, (i)nsert, or (c)ommand line
" mode -- seems to work in most terminals
set mouse=a

" let me delete stuff like crazy in insert mode
set backspace=indent,eol,start

" display commands as-typed + current position in file
set showcmd
set ruler

" add git status to statusline; otherwise emulate standard line with ruler
set statusline=[%{&fo}]%<%{fugitive#statusline()}\ %f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smarttab
set smartindent

set background=dark

" Use + register (X Window clipboard) as unnamed register
set clipboard=unnamedplus,autoselect

" turn off tab expansion for Makefiles
au FileType make setlocal noexpandtab

" use comma for the leader key
let mapleader = ","

" <keybindings>
" reformat a paragraph
nmap <leader>q gqip

" write all changed buffers
nmap <leader>w :wa<CR>

" forward and backward in tabs and buffers
noremap <f2> :bprev<CR>
noremap <leader><F2> :tabprev<CR>
noremap <f3> :bnext<CR>
noremap <leader><F3> :tabnext<CR>

imap <F5>:set invnumber<CR>
nmap <F6>:set nu!<CR>
noremap <f4> :bd<CR>
noremap <leader><f4> :tabclose<CR>

" toggle nerdtree and tlist
noremap <F7> :NERDTreeToggle<CR>
nnoremap <leader><F7> :TlistToggle<CR>

"toggle paragraph formating
map <F8> :set fo+=t<CR>
map <leader><F8> :set fo-=t<CR>

" remove/hide highlighting from searches
map <silent><F9> :set invhlsearch<CR>

" linediff activation
noremap <leader>d :Linediff<CR>

nmap s :set spell<CR>

" new tab:
nmap <leader>t :tabnew<CR>

" fuzzyfinder
nmap <leader>f :FufFile<CR>

" display tabs - ,s will toggle (redraws just in case)
nmap <silent> <leader>s :set nolist!<CR>:redr<CR>
set listchars=tab:⇾\ ,trail:·
set list

" remad ;to : since I tend to use : more often
nnoremap ; :
" nnoremap : ;

nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
nnoremap <space> za
map N Nzz
map n nzz

" </keybindings>

colorscheme symfony
