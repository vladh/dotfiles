call pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp
if has('nvim')
  tnoremap <Esc> <c-\><c-n>
  runtime! plugin/python_setup.vim
endif
syntax on
set t_Co=256 " 256 colors
set background=dark
let g:solarized_termcolors=256
colorscheme molokai_vladh
set guifont=Monaco\ for\ Powerline:h14
set nocompatible
set number
set wrap
set hidden
set history=1000
set undolevels=1000
set scrolloff=5
set autoindent
set laststatus=2
set showmatch
set cursorline
set incsearch
set hlsearch
set cmdheight=1
set switchbuf=useopen
set numberwidth=5
set showtabline=1
set winwidth=90
set wildmode=longest,list
set wildmenu
let mapleader=","
set backspace=indent,eol,start
set autoread
filetype plugin on
set matchpairs+=<:>
set showcmd
set mouse=a
set noshowmode
set whichwrap=h,l,~,[,],<,>
set gdefault
set visualbell " no bell kthx <3
set noerrorbells
set ttyfast
set smarttab
set nrformats-=octal
set fileformats+=mac
let g:DisableAutoPHPFolding = 1
set pastetoggle=<leader>sp
cmap w!! w !sudo tee % >/dev/null
set title
set timeoutlen=1000 ttimeoutlen=0 " eliminate <esc> delay
set encoding=utf-8
set fileencoding=utf-8
" set breakindent

" don't continue comments, don't break lines
set textwidth=0
set wrapmargin=0
set formatoptions-=croqt
autocmd FileType * setlocal textwidth=0
autocmd FileType * setlocal wrapmargin=0
autocmd FileType * setlocal formatoptions-=croqt
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" directories
set nobackup
set noswapfile

if has('persistent-undo')
	set undodir=~/.vim/tmp/undo//
	if !isdirectory(expand(&undodir))
			call mkdir(expand(&undodir), "p")
	endif
endif

" folds
set foldmethod=indent
set foldnestmax=4
set foldlevelstart=50

" indenting
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
au FileType python setl et ts=2 sts=2 sw=2

" commands
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" various maps
nnoremap ; :nohlsearch<cr>
nnoremap <leader>c0 :set colorcolumn=100<cr>
nnoremap <leader>c8 :set colorcolumn=80<cr>
nnoremap <leader>cr :set colorcolumn=<cr>

" very magic
" nnoremap / /\v
" nnoremap ? ?\v

" split line on K
nnoremap K i<CR><Esc>

" column scroll-binding (continuous line number)
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" hide gvim scrollbars and tabbar
set guioptions-=r
set guioptions-=L
set guioptions-=T

if &term =~ '256color'
	" Disable Background Color Erase (BCE) so that color schemes
	" work properly when Vim is used inside tmux and GNU screen.
	" See also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

" split window
nmap <silent> swh :topleft vnew<CR>
nmap <silent> swl :botright vnew<CR>
nmap <silent> swk :topleft new<CR>
nmap <silent> swj :botright new<CR>
" split buffer
nmap <silent> sh :leftabove vnew<CR>
nmap <silent> sl :rightbelow vnew<CR>
nmap <silent> sk :leftabove new<CR>
nmap <silent> sj :rightbelow new<CR>
" move between buffers
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
" move between tabs
nmap <silent> <S-h> :tabprevious<CR>
nmap <silent> <S-l> :tabnext<CR>

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=235 guibg=#666666
au ColorScheme * highlight ExtraWhitespace guibg=#666666
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" rename current file
function! RenameFile()
		let old_name = expand('%')
		let new_name = input('New file name: ', expand('%'), 'file')
		if new_name != '' && new_name != old_name
				exec ':saveas ' . new_name
				exec ':silent !rm ' . old_name
				redraw!
		endif
endfunction

" airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

" bars
nmap <leader>m :TagbarToggle<CR>
nmap <leader>b :CtrlPBuffer<CR>

" ctrlp
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" indent guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222222 ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#666666 ctermbg=235

" ctags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" syntastic
" disable HTML checking altogether
let g:syntastic_html_checkers=['']

" default vim completion
set ofu=syntaxcomplete#Complete
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" ejs
au BufNewFile,BufRead *.ejs set filetype=html

if filereadable(glob("~/.vimrc_private"))
  source ~/.vimrc_private
endif
