let plugged_path = '~/.config/nvim/plugged'

" we include this separate file to easily use one config with both
" vim and neovim
source ~/.vimrc_general

"
" includes
"
if filereadable(glob("~/.config/nvim/private.vim"))
  source ~/.config/nvim/private.vim
endif
