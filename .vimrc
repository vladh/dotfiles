call pathogen#infect()
set runtimepath^=~/.vim/bundle/ctrlp
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

" commands
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" various maps
nnoremap ; :nohlsearch<cr>
nnoremap <leader>c0 :set colorcolumn=100<cr>
nnoremap <leader>c8 :set colorcolumn=80<cr>
nnoremap <leader>cr :set colorcolumn=<cr>

" tests
" function! MapCR()
"   nnoremap <cr> :!clear <CR>:call RunLastSpec()<cr>
" endfunction
" call MapCR()
nnoremap <leader>tc :!clear <CR>:call RunCurrentSpecFile()<CR>
nnoremap <leader>ta :!clear <CR>:call RunAllSpecs()<CR>

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
" let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

" bars
nmap <leader>m :TagbarToggle<CR>
nmap <leader>b :CtrlPBuffer<CR>

" fireplace
nmap <leader>p <Plug>FireplaceCountPrint
nmap <leader>r :Require<CR>
nmap <leader>o :Require<CR> <bar> <Plug>FireplaceCountPrint
vmap <leader>p :Eval<CR>

" ctrlp
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|.*\.class)$'

" ctrlp-funky
nnoremap <leader>l :CtrlPFunky<Cr>
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1

" indent guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222222 ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#666666 ctermbg=235

" vim-latex-live-preview
let g:livepreview_previewer = 'open -a Skim'

" ctags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" syntastic
" disable HTML checking altogether
let g:syntastic_html_checkers=['']

" highlight words
" thanks, sjl!

function! HiInterestingWord(n)
	normal! mz
	normal! "zyiw
	let mid = 86750 + a:n
	silent! call matchdelete(mid)
	let pat = '\V\<' . escape(@z, '\') . '\>'
	call matchadd("InterestingWord" . a:n, pat, 1, mid)
	normal! `z
endfunction

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

" default vim completion, good to have even if we're using a plugin
set ofu=syntaxcomplete#Complete
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" YouCompleteMe
" HACK: If we don't have the version of Vim required for YouCompleteMe,
" trick it into thinking that it's already loaded, so it doesn't actually
" load itself and give an error message.
if v:version < 703 || (v:version == 703 && !has('patch584'))
  let g:loaded_youcompleteme = 1
endif

" private
if filereadable(glob("~/.vimrc_private"))
  source ~/.vimrc_private
endif
