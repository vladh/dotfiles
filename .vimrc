let plugged_path = '~/.vim/plugged'

" we include this separate file to easily use one config with both
" vim and neovim
source ~/.vimrc_general

"
" includes
"
if filereadable(glob("~/.vimrc_private"))
  source ~/.vimrc_private
endif
