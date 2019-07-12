"
" plugins
"
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-gitgutter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
call plug#end()

"
" general
"
set number
set wrap
let mapleader=","
set noshowmode
set gdefault
" eliminate <esc> delay
set timeoutlen=1000 ttimeoutlen=0

"
" theme
"
set background="dark"
colorscheme molokai_vladh
" normally we're supposed to set this I guess, but it doesn't work in tmux
" set termguicolors

"
" directories
"
set nobackup
set noswapfile

"
" indenting
"
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" set nosmartindent
" set nocindent
" don't break lines
set textwidth=0
set wrapmargin=0
autocmd FileType * setlocal textwidth=0
autocmd FileType * setlocal wrapmargin=0
" don't continue comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"
" binds
"
" w!! for sudo
cmap w!! w !sudo tee % >/dev/null
" handle W and Q typos
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>
" split line on K
nnoremap K i<CR><Esc>
" column scroll-binding (continuous line number)
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
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
" plugins
nmap <C-p> :FZF<CR>
" nmap <leader>b :CtrlPBuffer<CR>
" other maps
set pastetoggle=<leader>sp
nnoremap ; :nohlsearch<cr>
nnoremap <leader>c0 :set colorcolumn=100<cr>
nnoremap <leader>c8 :set colorcolumn=80<cr>
nnoremap <leader>cr :set colorcolumn=<cr>

"
" plugins
"

" airline
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_powerline_fonts=0

" tmuxline
let g:tmuxline_powerline_separators = 0

" " ctrlp
" let g:ctrlp_working_path_mode='a'
" let g:ctrlp_user_command=['.git', 'cd %s && git ls-files -co --exclude-standard']

" " syntastic - disable HTML checking altogether
" let g:syntastic_html_checkers=['']
" let g:syntastic_python_checkers=['flake8']

" whitespace
let g:better_whitespace_ctermcolor='grey'

"
" languages
"
" python
autocmd FileType python setlocal shiftwidth=4 tabstop=4
" rust
autocmd FileType rust setlocal shiftwidth=2 tabstop=2
" javascript
let g:jsx_ext_required=0
" ejs
au BufNewFile,BufRead *.ejs set filetype=html
" pollen
augroup configgroup
  autocmd!
  au! BufRead,BufNewFile *.pm set filetype=pollen
  au! BufRead,BufNewFile *.pp set filetype=pollen
  au! BufRead,BufNewFile *.ptree set filetype=pollen
  au! BufRead,BufNewFile *.html.p set filetype=pollen
augroup END
" vue
autocmd FileType vue syntax sync fromstart

"
" completion
"
" " default vim completion
" set ofu=syntaxcomplete#Complete
" set complete=.,w,b,u,t
" set completeopt=longest,menuone,preview

"
" includes
"
if filereadable(glob("~/.config/nvim/private.vim"))
  source ~/.config/nvim/private.vim
endif
