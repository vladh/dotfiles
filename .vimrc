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
set pastetoggle=<leader>pp
cmap w!! w !sudo tee % >/dev/null
set title
set timeoutlen=1000 ttimeoutlen=0 " eliminate <esc> delay

" don't continue comments, don't break lines
set textwidth=0
set wrapmargin=0
set formatoptions-=croqt
autocmd FileType * setlocal textwidth=0
autocmd FileType * setlocal wrapmargin=0
autocmd FileType * setlocal formatoptions-=croqt
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ruby
let g:ruby_path = '~/.rvm/rubies/default/bin/ruby'

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
nnoremap <leader>l :!clear && xelatex %<cr>
nnoremap <leader>cs :set colorcolumn=100<cr>
" thanks, John Latham
nnoremap <leader>cj :set colorcolumn=80<cr> 
nnoremap <leader>cr :set colorcolumn=<cr>
nnoremap <leader>ps :SyntasticToggle<cr>
map <leader>vp :exec "w !vpaste ft=".&ft<CR>
vmap <leader>vp <ESC>:exec "'<,'>w !vpaste ft=".&ft<CR>
nnoremap <leader>u :GundoToggle<CR>
noremap <leader>n :bp<CR>
nnoremap <leader>m :bn<CR>

" tests
" function! MapCR()
"   nnoremap <cr> :!clear <CR>:call RunLastSpec()<cr>
" endfunction
" call MapCR()
map <Leader>tc :!clear <CR>:call RunCurrentSpecFile()<CR>
map <Leader>ta :!clear <CR>:call RunAllSpecs()<CR>

" very magic
" nnoremap / /\v
" nnoremap ? ?\v

" split line on K
nnoremap K i<CR><Esc>

" column scroll-binding on <leader>sb (continuous line number)
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

" splits
" window
nmap <silent> <leader>sw<left> :topleft vnew<CR>
nmap <silent> <leader>sw<right> :botright vnew<CR>
nmap <silent> <leader>sw<up> :topleft new<CR>
nmap <silent> <leader>sw<down> :botright new<CR>
nmap <silent> <leader>swj :topleft vnew<CR>
nmap <silent> <leader>swl :botright vnew<CR>
nmap <silent> <leader>swk :topleft new<CR>
nmap <silent> <leader>swj :botright new<CR>
" buffer
nmap <silent> <leader>s<left> :leftabove vnew<CR>
nmap <silent> <leader>s<right> :rightbelow vnew<CR>
nmap <silent> <leader>s<up> :leftabove new<CR>
nmap <silent> <leader>s<down> :rightbelow new<CR>
nmap <silent> <leader>sh :leftabove vnew<CR>
nmap <silent> <leader>sl :rightbelow vnew<CR>
nmap <silent> <leader>sk :leftabove new<CR>
nmap <silent> <leader>sj :rightbelow new<CR>

" highlight trailing whitespace
" highlight ExtraWhitespace ctermbg=red guibg=#D1608D
" au ColorScheme * highlight ExtraWhitespace guibg=#D1608D
" au BufEnter * match ExtraWhitespace /\s\+$/
" au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" au InsertLeave * match ExtraWhiteSpace /\s\+$/

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

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" encoding
set encoding=utf-8
set fileencoding=utf-8

" auto closing brace
" inoremap {			{}<Left>
" inoremap {<CR>	{<CR>}<Esc>O
" inoremap {{			{
" inoremap {}			{}

" airline
" let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1

" bars
nmap <leader>m :TagbarToggle<CR>
nmap <leader>n :NERDTree<CR>
nmap <leader>b :CtrlPBuffer<CR>

" ctrlp
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP .'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = '\v[\/]node_modules$'

" indent guides
nmap <leader>pi :IndentGuidesToggle<CR>
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=235

" ctags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'

" showmarks
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

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

" completion

" default vim completion, good to have even if we're currently using neocomplcache
set ofu=syntaxcomplete#Complete
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" multipurpose tab key
" indent if we're at the beginning of a line. Else, do completion.
" thanks, Gary!
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		" return "\<c-p>"
		" return "\<c-x>\<c-o>"
		return "\<c-n>"
	endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <tab>

if exists('g:loaded_neocomplcache')
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_camel_case_completion = 1
	let g:neocomplcache_enable_underbar_completion = 1
	let g:neocomplcache_enable_smart_case = 1

	" default # of completions is 100, that's crazy
	let g:neocomplcache_max_list = 5

	" Tab / Shift-Tab to cycle completions
	inoremap <expr><TAB>	pumvisible() ? "\<C-n>" : "\<TAB>"
	inoremap <expr><S-TAB>	pumvisible() ? "\<C-p>" : "\<S-TAB>"

	" words less than 3 letters long aren't worth completing
	let g:neocomplcache_auto_completion_start_length = 3

	" This makes sure we use neocomplcache completefunc instead of
	" the one in rails.vim, otherwise this plugin will crap out
	let g:neocomplcache_force_overwrite_completefunc = 1

	" Define file-type dependent dictionaries.
	let g:neocomplcache_dictionary_filetype_lists = {
		\ 'default' : ''
		\ }

	" Define keyword, for minor languages
	if !exists('g:neocomplcache_keyword_patterns')
		let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
		let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
	let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
endif

" private
if filereadable(glob("~/.vimrc_private"))
  source ~/.vimrc_private
endif
