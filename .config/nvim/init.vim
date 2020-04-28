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
set timeoutlen=1000 ttimeoutlen=0 " eliminate <esc> delay

"
" theme
"
set background="dark"
colorscheme molokai_vladh

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
" <Ctrl-p> opens fuzzy file browser
nmap <C-p> :FZF<CR>
" ; clears highlighted search results
nnoremap ; :nohlsearch<cr>
" ,sp toggles paste mode
set pastetoggle=<leader>sp
" ,c0 sets a marker at column 100
nnoremap <leader>c0 :set colorcolumn=100<cr>
" ,c8 sets a marker at column 80
nnoremap <leader>c8 :set colorcolumn=80<cr>
" ,c8 clears column markers
nnoremap <leader>cr :set colorcolumn=<cr>
" ,a toggles syntax checking
nnoremap <leader>a :ALEToggle<cr>
" ,r runs the current file
nnoremap <leader>r :!"%:p" <cr>
" ,l runs the current file and pipes it into less
nnoremap <leader>l :!"%:p"  \| less<cr>
" ,<space> runs `make`
nnoremap <leader><space> :!make<cr>
" disable Shift+Down which is not needed and I keep accidentally pressing
nnoremap <S-Down> <Nop>

"
" plugins
"

" airline
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_powerline_fonts=0

" tmuxline
let g:tmuxline_powerline_separators = 0

" whitespace
let g:better_whitespace_ctermcolor='grey'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" compensate for polyglot highlighting too much
if exists('python_highlight_all')
    unlet python_highlight_all
endif
if exists('python_space_error_highlight')
    unlet python_space_error_highlight
endif

"
" languages
"
" python
autocmd FileType python setlocal shiftwidth=4 tabstop=4
" tex
let g:tex_no_error=1
" rust
autocmd FileType rust setlocal shiftwidth=2 tabstop=2
" javascript
let g:jsx_ext_required=0
let g:ale_linters = {
\ 'javascript': ['eslint'],
\}
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
" r
let r_indent_align_args = 0
let r_indent_ess_compatible = 1

"
" includes
"
if filereadable(glob("~/.config/nvim/private.vim"))
  source ~/.config/nvim/private.vim
endif
