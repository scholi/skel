let g:pymode_python = 'python3'
set tabstop=2
set showbreak=>>>
set linebreak
nnoremap <CR> <C-]>
set laststatus=2
set showtabline=2
set noshowmode
set guifont=Droid_Sans_Mono_Slashed_for_Pow:h10
set backspace=2
set backspace=indent,eol,start
syntax on
set nu
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set mouse=a
set encoding=utf8
set langmenu=en_US.UTF8
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set tabline=%!tabber#TabLine()
set guioptions-=e
set guioptions-=m
set guioptions-=r
set guioptions-=T
setlocal spell spelllang=en_us
" shift+arrow selection
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

augroup XMLC:\Program Files\MiKTeX 2.9\miktex\bin\x64
	autocmd!
	autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END
filetype indent plugin on
au FileType python set et
set ts=4 et sw=4 sts=4
autocmd FileType tex setl updatetime=1
autocmd FileType tex set foldmethod=expr
autocmd FileType tex set foldexpr=vimtex#fold#level(v:lnum)
autocmd FileType tex normal zR
call plug#begin('~/vimfiles/plugged')
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for':'tex' }
Plug 'erichdongubler/vim-sublime-monokai'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'fweep/vim-tabber'
Plug 'flazz/vim-colorschemes'
Plug 'powerline/powerline'
Plug 'powerline/fonts'
Plug 'vim-voom/VOoM'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/taglist.vim'
call plug#end()
colorscheme molokai_dark
"let g:vimtex_view_method = 'SumatraPDF'
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
winpos 0 0
set lines=71
set columns=122
nnoremap <silent> <F8> :TlistToggle<CR>
