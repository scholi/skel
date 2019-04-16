set encoding=utf-8
scriptencoding utf-8

let g:pymode_python = 'python3'
noremap :py :py3

set showbreak=↪
set listchars=tab:→_,eol:↵,nbsp:␣
"let &listchars="tab:\u2192_,eol:\u21b5,nbsp:\u2423"
nmap <F3> :set list!<CR>

set linebreak
nnoremap <C-CR> <C-]>
set laststatus=2
set showtabline=2
set noshowmode
"set guifont=Droid_Sans_Mono_Slashed_for_Pow:h10
set guifont=DejaVu_Sans_Mono_for_Powerline:h10
set backspace=2
set backspace=indent,eol,start
let g:pony_manage_filename="manage.py"
syntax on
set nu
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set mouse=a
set langmenu=en_US.UTF8
let $LANG = 'en_US'
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim
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
filetype indent plugin on
set ts=4 sw=4 sts=0
nnoremap <Space> a_<esc>r

call plug#begin('~/vimfiles/plugged')
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for':'tex' }
Plug 'flazz/vim-colorschemes' " Color schemes
Plug 'powerline/powerline' " status and tab line
Plug 'powerline/fonts' " Special font for powerline
Plug 'fweep/vim-tabber'
Plug 'vim-voom/VOoM'
Plug 'airblade/vim-gitgutter' " Git diff in margin
Plug 'tpope/vim-fugitive' " Git cmd
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/toggle_comment'
Plug 'scrooloose/nerdtree' " Explorer
Plug 'davidhalter/jedi-vim' " For python
"Plug 'kien/ctrlp.vim'
Plug 'wmvanvliet/vim-ipython' " IPython integration
Plug 'kh3phr3n/python-syntax' " better syntax highlight for python
Plug 'scholi/vim-pony'
"Plug 'scrooloose/syntastic'
call plug#end()
colorscheme molokai_dark
"
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeQuitOnOpen=1

let TlistClose_On_Select = 1

" LaTeX Settings
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" Powerline settings
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename .' "'. f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction

function! LeftHalfWindow()
	winpos 0 0
	set lines=999
	set columns=999
	let &columns=&columns/2
endfunction

function! ToggleFullHalfScreen()
    winpos 0 0
    let last_columns=&columns
    set lines=999
    set columns=999
    if &columns==last_columns
       let &columns=&columns/2
    endif
endfunction

nmap <F4> :call ToggleFullHalfScreen()<CR>

augroup latexgroup
    au!
    au FileType tex set foldmethod=expr
    au FileType tex set foldexpr=vimtex#fold#level(v:lnum)
    au FileType tex normal zR
    au FileType tex let g:vimtex_latexmk_continuous=0
	au BufEnter *.tex call LeftHalfWindow()
	au BufEnter *.tex nnoremap <silent> <F8> :Voom latex<CR>
	au BufLeave *.tex nnoremap <silent> <F8> :TlistOpen<CR>
augroup END

augroup pythongroup
    au!
    au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
augroup END

au BufWritePost *.py,*.tex,*.c,*.h,*.cpp call UpdateTags()

let g:jedi#popup_on_dot=0
let g:jedi#show_call_signatures=0

nnoremap <silent> <F8> :TlistOpen<CR>
nmap <C-h> <Plug>GitGutterNextHunk
nmap <C-l> <Plug>GitGutterPrevHunk
"TODO
hi Todo guifg=black guibg=yellow ctermbg=yellow
hi BadWhitespace guibg=red ctermbg=red
hi ExtraWhitespace guibg=lightgreen ctermbg=lightgreen
syn match BadWhitespace /\s\+$/ containedin=ALL
syn match ExtraWhitespace / \+\ze\t/ containedin=ALL
map <C-m> :NERDTreeToggle<CR>
map <F2> :tabe ~/.vimrc<CR>
set fo-=t
