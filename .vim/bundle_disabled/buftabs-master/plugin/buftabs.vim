"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buftabs (C) 2006 Ico Doornekamp
"
" This program is free software; you can redistribute it and/or modify it
" under the terms of the GNU General Public License as published by the Free
" Software Foundation; either version 2 of the License, or (at your option)
" any later version.
"
" This program is distributed in the hope that it will be useful, but WITHOUT
" ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
" FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
" more details.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" forked by Zefei Xuan
" repo: https://github.com/zefei/buftabs
"
"
" Introduction
" ------------
"
" This is a simple script that shows a tabs-like list of buffers in the 
" statusline. The biggest advantage of this script over various others is that 
" it does not create new window, and thus will not conflit with other navigation 
" plugins such as nerdtree.
"
"
" Screeshots
" ----------
"
" a few opened files in one window: http://i.imgur.com/stvMQ.png
" 3 windows - nerdtree, help and files: http://i.imgur.com/Pdsg9.png
" 3 windows - fugitive and files: http://i.imgur.com/XUoHT.png
"
" (color scheme used in screenshots is https://github.com/zefei/simple-dark)
"
"
" Usage
" -----
" 
" Just copy the file to vim plugin directory, it will start showing buffer list 
" on your statusline. By default, it will take over the entire statusline; but 
" if you want to use only part of the statusline for buftabs, please check the 
" configuration options below.
"
" It might be handy to create a few maps for easy switching of buffers in your
" .vimrc file. For example:
"
"   noremap <F1> :bprev!<CR>
"   noremap <F2> :bnext!<CR>
"   noremap <F4> :confirm bd<CR>
"
"
" Configuration
" -------------
"
" The following extra configuration variables are availabe:
" 
" * statusline
"
"   By default buftabs will take up the whole statusline. You can
"   alternatively specify precisely where it goes using #{buftabs} e.g.:
"
"   :set laststatus=2
"   :set statusline=\ #{buftabs}%=\ \ Ln\ %-5.5l\ Col\ %-4.4v
"
"   NOTICE: If you customize your statusline like above, you will HAVE to 
"   specify the total charactor length of non-buftabs components in the 
"   statusline. By default, it is 0 since there are no other components. To 
"   change:
"
"   " for the example statusline above, length of other components is 20
"   :let g:buftabs_other_components_length=20
"
"
" * g:buftabs_active_highlight_group (default '')
"
"   The name of a highlight group (:help highligh-groups) which is used to
"   show the name of the current active buffer. To change:
"
"   :let g:buftabs_active_highlight_group="Visual"
"
"
" * g:buftabs_only_basename (default 1)
"
"   This variable makes buftabs only print the filename of each buffer,
"   omitting the preceding directory name. To unset:
"
"   :let g:buftabs_only_basename=0
"
"
" * g:buftabs_show_number     1
" * g:buftabs_marker_start    [
" * g:buftabs_marker_end      ]
" * g:buftabs_separator       -
" * g:buftabs_marker_modified !
"
"   These strings are drawn around each tab as separators, the 'marker_modified' 
"   symbol is used to denote a modified (unsaved) buffer. If
"   'buftabs_show_number' is set to 0, neither buffer number nor separator is
"   shown. To change:
"
"   :let g:buftabs_separator = "."  
"   :let g:buftabs_marker_start = " "
"   :let g:buftabs_marker_end = " "
"   :let g:buftabs_marker_modified = " +"
"
"
" * g:buftabs_blacklist (default ["^NERD_tree_[0-9]*$"])
"
"   You might not want to show buftabs when working with some buffers (e.g.
"   NERDtree). You can add patterns of these buffer names to
"   'buftabs_blacklist':
"
"   :let g:buftabs_blacklist = ["^NERD_tree_[0-9]*$", "^__Tagbar__$"]
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" Don't bother when in diff mode
"

if &diff                                      
  finish
endif     


" Set status line visible

set laststatus=2


" Parse statusline to extract #{buftabs}

let s:original_statusline_left = matchstr(&statusline, ".*#{buftabs}")
let s:original_statusline_right = matchstr(&statusline, "#{buftabs}.*")


"
" Enable buftabs statusline if the initial buffer in the window is not 
" blacklisted
"

function! Buftabs_enable()
  let w:buftabs_enabled = 0

  let l:buftabs_blacklist = ["^NERD_tree_[0-9]*$"]
  if exists("g:buftabs_blacklist")
    let l:buftabs_blacklist = g:buftabs_blacklist
  endif

  " Do not enable buftabs if current buffer name is in the blacklist
  for name in l:buftabs_blacklist
    if match(bufname(""), name) != -1
      return
    endif
  endfor
  
  let w:buftabs_enabled = 1
endfunction


"
" Draw buftabs
"

function! Buftabs_show(deleted_buf)

  let l:i = 1
  let s:list = ''
  let l:start = 0
  let l:end = 0
  if ! exists("w:from") 
    let w:from = 0
  endif

  if ! exists("w:buftabs_enabled") || w:buftabs_enabled == 0
    return
  endif

  let l:buftabs_other_components_length = 0
  if exists("g:buftabs_other_components_length")
    let l:buftabs_other_components_length = g:buftabs_other_components_length
  endif

  let l:buftabs_active_highlight_group = ''
  if exists("g:buftabs_active_highlight_group")
    let l:buftabs_active_highlight_group = g:buftabs_active_highlight_group
  endif

  let l:buftabs_show_number = 1
  if exists("g:buftabs_show_number")
    let l:buftabs_show_number = g:buftabs_show_number
  endif

  let l:buftabs_marker_modified = "!"
  if exists("g:buftabs_marker_modified")
    let l:buftabs_marker_modified = g:buftabs_marker_modified
  endif

  let l:buftabs_separator = "-"
  if exists("g:buftabs_separator")
    let l:buftabs_separator = g:buftabs_separator
  endif

  let l:buftabs_marker_start = "["
  if exists("g:buftabs_marker_start")
    let l:buftabs_marker_start = g:buftabs_marker_start
  endif

  let l:buftabs_marker_end = "]"
  if exists("g:buftabs_marker_end")
    let l:buftabs_marker_end = g:buftabs_marker_end
  endif

  " Walk the list of buffers

  while(l:i <= bufnr('$'))

    let l:listed = buflisted(l:i) && getbufvar(l:i, "&modifiable") && a:deleted_buf != l:i

    " Only show buffers that are listed; if current buffer is not listed, only 
    " show current buffer 

    if l:listed || winbufnr(0) == l:i

      " Truncate list if current buffer is not listed

      if !l:listed
        let s:list = ''
      endif

      " Get the name of the current buffer, and escape characters that might
      " mess up the statusline

      if exists("g:buftabs_only_basename") && !g:buftabs_only_basename
        let l:name = bufname(l:i)
      else
        let l:name = fnamemodify(bufname(l:i), ":t")
      endif
      let l:name = substitute(l:name, "%", "%%", "g")
      if l:name == ""
        let l:name = "[No Name]"
      endif
      
      " Append the current buffer number and name to the list. If the buffer
      " is the active buffer, enclose it in some magick characters which will
      " be replaced by markers later. If it is modified, it is appended with
      " an appropriate symbol (an exclamation mark by default)

      if winbufnr(0) == l:i
        let l:start = strlen(s:list)
        let s:list = s:list . "\x01"
      else
        let s:list = s:list . ' '
      endif
        
      if l:buftabs_show_number == 1
        let s:list = s:list . l:i . l:buftabs_separator
      endif
      let s:list = s:list . l:name

      if getbufvar(l:i, "&modified") == 1
        let s:list = s:list . l:buftabs_marker_modified
      endif
      
      if winbufnr(winnr()) == l:i
        let s:list = s:list . "\x02"
        let l:end = strlen(s:list)
      else
        let s:list = s:list . ' '
      endif

      " Truncate list if current buffer is not listed

      if !l:listed
        break
      endif

    end

    let l:i = l:i + 1
  endwhile

  " If the resulting list is too long to fit on the screen, chop
  " out the appropriate part

  let l:width = winwidth(0)
  let l:width -= l:buftabs_other_components_length

  if l:end > w:from + l:width
    let w:from = l:end - l:width 
  endif
  if(l:start < w:from) 
    let w:from = l:start
  endif

  let l:len = strlen(s:list)
  let s:list = strpart(s:list, w:from, l:width)
  
  " Show some nice arrows to indicate that some part of the list is chopped

  " Check if left arrow is needed

  let l:offset = 0
  let l:larrow = w:from > 0
  if l:larrow
    let l:loffset = l:start - w:from
    if l:loffset > 2
      let l:loffset = 2
    endif
    let w:from -= 2 - l:loffset
    let l:offset += l:loffset
  endif

  " Check if right arrow is needed

  let l:to = w:from + l:width
  let l:rarrow = l:to < l:len
  if l:rarrow
    let l:roffset = l:end + 2 - l:to
    if l:roffset < 0
      let l:roffset = 0
    endif
    let w:from += l:roffset
    let l:offset += l:roffset
  endif

  " Check left arrow again since right arrow may change it

  if !l:larrow && w:from > 0
    let l:larrow = 1
    let l:loffset = l:start - w:from
    if l:loffset > 2
      let l:loffset = 2
    endif
    let w:from -= 2 - l:loffset
    let l:offset += l:loffset
  endif

  " Clean up offset and append arrow

  let l:lmark = ''
  let l:rmark = ''
  if l:larrow
    let l:lmark = '◁ '
    let l:width -= 2
  endif
  if l:rarrow
    let l:rmark = ' ▷'
    let l:width -= 2
  endif
  let s:list = l:lmark . strpart(s:list, l:offset, l:width) . l:rmark

  " Replace the magic characters by visible markers for highlighting the
  " current buffer. The markers can be simple characters like square brackets,
  " but can also be special codes with highlight groups
  
  let l:buftabs_marker_start = "%#" . l:buftabs_active_highlight_group . "#" . l:buftabs_marker_start
  let l:buftabs_marker_end = l:buftabs_marker_end . "%##"

  let s:list = substitute(s:list, "\x01", l:buftabs_marker_start, 'g')
  let s:list = substitute(s:list, "\x02", l:buftabs_marker_end, 'g')

  " Show the list.

  let &l:statusline = substitute(s:original_statusline_left . s:list . s:original_statusline_right, "#{buftabs}", '', 'g')

endfunction


"
" Check if modified flag is changed for the current buffer, refresh buftabs if
" it is changed
"

function! Buftabs_check_mod()
  if ! exists("b:buftabs_mod") || b:buftabs_mod != getbufvar(winbufnr(0), "&mod")
    let b:buftabs_mod = getbufvar(winbufnr(0), "&mod")
    call Buftabs_show(-1)
  endif
endfunction


"
" Hook to events to show buftabs at startup, when creating and when switching
" buffers
"

autocmd CmdwinEnter,BufEnter * call Buftabs_enable()
autocmd CmdwinEnter,BufNew,BufEnter,BufWritePost,VimResized * call Buftabs_show(-1)
autocmd BufDelete * call Buftabs_show(expand('<abuf>'))
autocmd CursorMoved,CursorMovedI * call Buftabs_check_mod()

" vi: ts=2 sw=2
