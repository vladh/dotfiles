if has('nvim')
  let plugged_path='~/.config/nvim/plugged'
  set undodir=$HOME/.config/nvim/undo
else
  let plugged_path='~/.vim/plugged'
  set undodir=$HOME/.vim/undo
endif


"
" plugins
"
let g:polyglot_disabled = ['ftdetect']
call plug#begin(plugged_path)
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-swap'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'vladh/nord-vim', { 'branch': 'main' }

" languages
Plug 'digitaltoad/vim-pug'
Plug 'https://git.sr.ht/~sircmpwn/hare.vim'
Plug 'https://git.sr.ht/~vladh/shimei.vim', { 'branch': 'main' }
Plug 'iloginow/vim-stylus'
Plug 'karolbelina/uxntal.vim', { 'branch': 'main' }
Plug 'otherjoel/vim-pollen'
Plug 'wlangstroth/vim-racket'
Plug 'ziglang/zig.vim'

if has('nvim')
  Plug 'vladh/nvim-treesitter', {'do': ':TSUpdate'}
endif
call plug#end()


"
" general
"
let mapleader=","
set noshowmode " airline will show this
set gdefault
set timeoutlen=1000 ttimeoutlen=0 " eliminate <esc> delay
set mouse=a
set signcolumn=yes
set updatetime=300
set nofixendofline
set showbreak=+
set hlsearch


"
" theme
"
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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set wrapmargin=0
autocmd FileType * setlocal textwidth=120
autocmd FileType * setlocal wrapmargin=0
" don't continue comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"
" binds
"
" w!! for sudo
command! Wsudo w !sudo tee % >/dev/null
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
" strips whitespace from current buffer
nmap <leader>ss :StripWhitespace<CR>
" ; clears highlighted search results
nnoremap ; :nohlsearch<cr>
" ,sp toggles paste mode
set pastetoggle=<leader>sp
" ,c0 sets a marker at column 101
nnoremap <leader>c0 :set colorcolumn=101<cr>
" ,cs sets a marker at column 121
nnoremap <leader>cs :set colorcolumn=121<cr>
" ,c8 sets a marker at column 81
nnoremap <leader>c8 :set colorcolumn=81<cr>
" ,c6 sets a marker at column 66
nnoremap <leader>c6 :set colorcolumn=66<cr>
" ,cr clears column markers
nnoremap <leader>cr :set colorcolumn=<cr>
" ,r runs the current file
nnoremap <leader>r :!"%:p" <cr>
" ,w runs `make run`
nnoremap <leader>e :!make run<cr>
" ,l runs the current file and pipes it into less
nnoremap <leader>l :!"%:p"  \| less -r<cr>
" ,x compiles LaTeX
nnoremap <leader>x :!clear && xelatex -shell-escape %<cr>
" ,<space> runs `make`
nnoremap <leader><space> :!make<cr>
" disable Shift+Down and Shift+Up which are not needed and I
" keep accidentally pressing
nnoremap <S-Up> <Nop>
nnoremap <S-Down> <Nop>
" - to switch files
nnoremap - <C-^>
nmap ga <Plug>(EasyAlign)
" disable Ex mode
nnoremap Q <Nop>

" rebind up/down/left/right keys in :e autocomplete
" by default, left/right go up and down, while up/down go in an out of
" directories, which is extremely confusing!
" this changes it to be the "right" way around
" https://vi.stackexchange.com/a/22628
set wildcharm=<C-Z>
let edit_re='e\%[dit] '
cnoremap <expr> <up> getcmdline() =~# edit_re && wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> getcmdline() =~# edit_re && wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> getcmdline() =~# edit_re && wildmenumode() ? "\<up>" : "\<left>"
cnoremap <expr> <right> getcmdline() =~# edit_re && wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"


"
" plugins
"

" airline
let g:airline_theme='nord'
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_powerline_fonts=0

" EasyAlign
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. gaip)

" tmuxline
let g:tmuxline_powerline_separators=0

" fzf
let g:fzf_layout={'down': '~30%'}

" vimwiki
let g:vimwiki_list=[{'path': '~/Dropbox/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
" don't hide bold/italic markers (*/_)
set conceallevel=0
let g:vim_json_syntax_conceal=0
let g:vim_markdown_conceal=0
let g:vim_markdown_conceal_code_blocks=0
let g:vimwiki_conceallevel=0

" whitespace
let g:better_whitespace_ctermcolor='grey'
let g:better_whitespace_guicolor='grey'
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
" peony
au BufRead,BufNewFile *.peony* set filetype=dosini
" qss
au BufRead,BufNewFile *.qss set filetype=css
" qrc
au BufRead,BufNewFile *.qrc set filetype=xml
" glsl
au BufRead,BufNewFile *.vert set filetype=glsl
au BufRead,BufNewFile *.geom set filetype=glsl
au BufRead,BufNewFile *.frag set filetype=glsl
" pollen
au BufRead,BufNewFile *.pm set filetype=pollen
au BufRead,BufNewFile *.pp set filetype=pollen
au BufRead,BufNewFile *.ptree set filetype=pollen
au BufRead,BufNewFile *.p set filetype=pollen
" ejs
au BufNewFile,BufRead *.ejs set filetype=html
" python
au FileType python setlocal shiftwidth=4 tabstop=4
" asm
au FileType asm setlocal commentstring=;\ %s
" rust
au FileType rust setlocal shiftwidth=4 tabstop=4
" go
au FileType go setlocal noexpandtab shiftwidth=4 tabstop=4
" vue
au FileType vue syntax sync fromstart
" tex
let g:tex_no_error=1
let g:tex_flavor="latex"
" javascript
let g:jsx_ext_required=0
" r
let r_indent_align_args=0
let r_indent_ess_compatible=1
" c
" don't indent `case`, `public`, `protected`, and `private`
" don't indent code in any special way when splitting (args, ...) over multiple lines
" don't indent function type when it's on its own line
set cinoptions+=g0,(s,Ws,m1,:0,=s,l1,t0
set cinkeys+=0#
" zig
let g:zig_fmt_autosave = 0


"
" lsp
"
if has('nvim')
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
EOF
endif


"
" allow per-project .vimrc
"
set exrc
set secure
