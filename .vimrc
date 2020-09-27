if has('nvim')
  let plugged_path = '~/.config/nvim/plugged'
  set undodir=$HOME/.config/nvim/undo
else
  let plugged_path = '~/.vim/plugged'
  set undodir=$HOME/.vim/undo
endif

"
" plugins
"
call plug#begin(plugged_path)
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'jremmen/vim-ripgrep'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'mbbill/undotree'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

"
" general
"
set number
let mapleader=","
set noshowmode " airline will show this
set gdefault
set timeoutlen=1000 ttimeoutlen=0 " eliminate <esc> delay
set mouse=a

"
" theme
"
set background="dark"
" colorscheme molokai_vladh
colorscheme nord

"
" directories
"
set nobackup
set noswapfile
set undofile

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
" opens fuzzy file browser
nmap <C-p> :FZF<CR>
" opens in-file search with ripgrep
nmap <C-t> :Rg<CR>
" strips whitespace from current buffer
nmap <leader>ss :StripWhitespace<CR>
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
nnoremap <leader>l :!"%:p"  \| less -r<cr>
" ,<space> runs `make`
nnoremap <leader><space> :!make<cr>
" disable Shift+Down and Shift+Up which are not needed and I
" keep accidentally pressing
nnoremap <S-Up> <Nop>
nnoremap <S-Down> <Nop>
" indent entire file
nnoremap =a gg=G``

"
" plugins
"

" airline
" let g:airline_theme='powerlineish'
let g:airline_theme='nord'
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_powerline_fonts=0

" tmuxline
let g:tmuxline_powerline_separators = 0

" fzf
let g:fzf_layout = { 'down': '~30%' }

" vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" autocompletion
let g:deoplete#enable_at_startup=0
if exists("deoplete#custom#option")
  call deoplete#custom#option('auto_complete_popup', 'manual')
endif
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#complete() " deoplete#manual_complete()
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" whitespace
let g:better_whitespace_ctermcolor='grey'
let g:better_whitespace_enabled=1

" compensate for polyglot highlighting too much
if exists('python_highlight_all')
    unlet python_highlight_all
endif
if exists('python_space_error_highlight')
    unlet python_space_error_highlight
endif

" always highlight certain words
augroup highlight_todo
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call
    \ matchadd('Todo', 'TODO\|NOTE\|FIXME\|SLOW\|#slow', -1)
augroup END

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
" c
" don't indent `public`, `protected`, and `private`
" don't specifically indent code inside multiple-line ()
set cinoptions+=g0,(s,Ws,m1
"ale
" let g:ale_lint_on_text_changed='never'
" let g:ale_lint_on_insert_leave=0
let g:ale_disable_lsp=1
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'asm': [],
\}

"
" allow per-project .vimrc
"
set exrc
set secure

if has('nvim')
  if filereadable(glob("~/.config/nvim/private.vim"))
    source ~/.config/nvim/private.vim
  endif
else
  if filereadable(glob("~/.vimrc_private"))
    source ~/.vimrc_private
  endif
endif
