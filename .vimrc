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
call plug#begin(plugged_path)
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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
Plug 'mbbill/undotree'
if has('nvim')
  Plug 'neoclide/coc.nvim'
  Plug 'jackguo380/vim-lsp-cxx-highlight'
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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=90
set wrapmargin=0
autocmd FileType * setlocal textwidth=90
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
" ,cs sets a marker at column 90
nnoremap <leader>cs :set colorcolumn=90<cr>
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
" indent entire file
nnoremap =a gg=G``

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
" python
autocmd FileType python setlocal shiftwidth=4 tabstop=4
" asm
autocmd FileType asm setlocal commentstring=;\ %s
" tex
let g:tex_no_error=1
let g:tex_flavor="latex"
" rust
autocmd FileType rust setlocal shiftwidth=2 tabstop=2
" javascript
let g:jsx_ext_required=0
" ejs
au BufNewFile,BufRead *.ejs set filetype=html
" glsl
au BufRead,BufNewFile *.vert set filetype=glsl
au BufRead,BufNewFile *.geom set filetype=glsl
au BufRead,BufNewFile *.frag set filetype=glsl
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
let r_indent_align_args=0
let r_indent_ess_compatible=1
" c
" don't indent `public`, `protected`, and `private`
" don't specifically indent code inside multiple-line ()
set cinoptions+=g0,(s,Ws,m1


"
" nvim lsp stuff
"
if has('nvim')
  " don't give |ins-completion-menu| messages.  For example, 'match 1 of 2', 'The only
  " match' etc.
  set shortmess+=c

  " " use tab to trigger completion
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  function! s:check_back_space() abort
    let col=col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  nmap <silent> <C-e> <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gt <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " use K to show definition of word under cursor
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
endif


"
" allow per-project .vimrc
"
set exrc
set secure

if filereadable(glob("~/.vimrc_private"))
  source ~/.vimrc_private
endif
