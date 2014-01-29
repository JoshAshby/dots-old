"This all needs cleaned up...
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=$DOTS/powerline/powerline/bindings/vim

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'L9'
" File related bundles
Bundle 'FuzzyFinder'
Bundle 'scrooloose/nerdtree'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'mileszs/ack.vim'
" Git related bundles
Bundle 'fugitive.vim'
Bundle 'airblade/vim-gitgutter'
" Utils
Bundle 'Auto-Pairs'
Bundle 'majutsushi/tagbar'
Bundle 'techlivezheng/vim-plugin-tagbar-phpctags'

Bundle 'vim-scripts/UltiSnips'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle 'honza/vim-snippets'

Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'ervandew/supertab'
Bundle 'davidhalter/jedi-vim'
Bundle 'tpope/vim-surround'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/syntastic'
Bundle 'docunext/closetag.vim.git'

Bundle 'AndrewRadev/linediff.vim'

Bundle 'chriskempson/base16-vim'

Bundle 'groenewege/vim-less'
Bundle 'skammer/vim-css-color'
Bundle 'kchmck/vim-coffee-script'
Bundle 'plasticboy/vim-markdown'
Bundle 'Glench/Vim-Jinja2-Syntax'

set exrc "enable cwd .vimrc files
syntax on
set grepprg=egrep\ -nH\ $*
filetype plugin indent on

set number
set title
set showtabline=0
"set nofoldenable
"
au BufReadPre * setlocal foldmethod=indent
au BufWinEnter * normal zR

autocmd FileType python setlocal completeopt-=preview

" Setup supertab to use omni complete and such
set omnifunc=syntaxcomplete#Complete
au FileType python set omnifunc=pythoncomplete#Complete

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&normalfunc', '&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>", "&normalfunc:<c-x><c-n>"]
"let g:SuperTabDefaultCompletionType = "<c-x><c-n>"

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menu,preview,longest

" set a line width and reformat text to fit
set textwidth=79
set fo+=t

" highlight if we go over 79 chars wide
augroup vimrc_autocmds
        autocmd BufEnter * highlight OverLength ctermbg=green guibg=#592929
        autocmd BufEnter * match OverLength /\%79v.*/
augroup END

" Strip whitespace when working in these filetypes
autocmd FileType c,cpp,java,php,python,coffee,js,css,less autocmd BufWritePre <buffer> :%s/\s\+$//e

" Enable html tag closing on typical html style file types
autocmd FileType html,djangohtml,jinjahtml,eruby,mako let b:closetag_html_style=1

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

" buffergator stuff
let g:buffergator_suppress_keymaps=1

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
"set statusline=[%{&fo}]%<%{fugitive#statusline()}\ %f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2

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
set clipboard=unnamedplus,autoselect

" turn off tab expansion for Makefiles
au FileType make setlocal noexpandtab


" ====================== Keybindings...
" =====================================
" use comma for the leader key
let mapleader = ","

" reformat a paragraph
nmap <leader>q gqip

" write all changed buffers
nmap <leader>w :wa<CR>

" forward and backward in tabs and buffers
noremap <f2> :bprev<CR>
noremap <leader><F2> :tabprev<CR>
noremap <f3> :bnext<CR>
noremap <leader><F3> :tabnext<CR>

nmap <F4> :bprevious<CR>bdelete \#<CR>
noremap <leader><f4> :tabclose<CR>

imap <F5>:set invnumber<CR>
nmap <leader><F5>:set nu!<CR>

" Buffergator stuff
noremap <F6> :BuffergatorToggle<CR>
noremap <leader><F6> :BuffergatorTabsToggle<CR>

" toggle nerdtree and Tagbar
noremap <F7> :NERDTreeToggle<CR>
nnoremap <leader><F7> :TagbarToggle<CR>

"toggle paragraph formating
map <F8> :set fo+=t<CR>
map <leader><F8> :set fo-=t<CR>

" remove/hide highlighting from searches
map <silent><F9> :set invhlsearch<CR>

" linediff activation
noremap <leader>d :Linediff<CR>

nmap s :set spell<CR>
nnoremap <leader>s :set nospell<CR>

" new tab:
nmap <leader>y :tabnew<CR>

" fuzzyfinder
nmap <leader>f :FufFile<CR>

" display tabs - ,s will toggle (redraws just in case)
nmap <silent> <leader>s :set nolist!<CR>:redr<CR>
" This line blew up at me when I symlinked this file. no clue why
set listchars=tab:¿\ ,trail:·
set list

" remad ;to : since I tend to use : more often
nnoremap ; :
" nnoremap : ;

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

" set wmh=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <c-h> <c-w>h<c-w><Bar>
map <c-l> <c-w>l<c-w><Bar>
" set winminheight=0
" set winheight=999


" ===================== TagBar stuff...
" =====================================
let g:tagbar_type_coffee = {
    \ 'ctagstype' : 'coffee',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'm:methods',
        \ 'f:functions',
        \ 'v:variables',
        \ 'f:fields',
    \ ]
\ }

" Posix regular expressions for matching interesting items. Since this will
" be passed as an environment variable, no whitespace can exist in the options
" so [:space:] is used instead of normal whitespaces.
" Adapted from: https://gist.github.com/2901844
let s:ctags_opts = '
  \ --langdef=coffee
  \ --langmap=coffee:.coffee
  \ --regex-coffee=/(^|=[[:space:]])*class[[:space:]]([A-Za-z]+\.)*([A-Za-z]+)([[:space:]]extends[[:space:]][A-Za-z.]+)?$/\3/c,class/
  \ --regex-coffee=/^[[:space:]]*(module\.)?(exports\.)?@?([A-Za-z.]+):.*[-=]>.*$/\3/m,method/
  \ --regex-coffee=/^[[:space:]]*(module\.)?(exports\.)?([A-Za-z.]+)[[:space:]]+=.*[-=]>.*$/\3/f,function/
  \ --regex-coffee=/^[[:space:]]*([A-Za-z.]+)[[:space:]]+=[^->\n]*$/\1/v,variable/
  \ --regex-coffee=/^[[:space:]]*@([A-Za-z.]+)[[:space:]]+=[^->\n]*$/\1/f,field/
  \ --regex-coffee=/^[[:space:]]*@([A-Za-z.]+):[^->\n]*$/\1/f,staticField/
  \ --regex-coffee=/^[[:space:]]*([A-Za-z.]+):[^->\n]*$/\1/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@([A-Za-z.]+)/\2/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){0}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){1}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){2}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){3}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){4}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){5}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){6}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){7}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){8}/\3/f,field/
  \ --regex-coffee=/(constructor:[[:space:]]\()@[A-Za-z.]+(,[[:space:]]@([A-Za-z.]+)){9}/\3/f,field/'

let $CTAGS = substitute(s:ctags_opts, '\v\([nst]\)', '\\', 'g')

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }
