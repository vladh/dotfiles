alias grep="grep --color"

alias tmux="TERM=xterm-256color tmux"
alias ta="tmux attach -t"
alias tl="tmux ls"

if ls --color -d . >/dev/null 2>&1; then
  # GNU ls
  alias ls='ls --color --group-directories-first'
  alias ll="ls -lha --color --group-directories-first"
  alias llt="ls -lhrt --color --group-directories-first"
elif ls -G -d . >/dev/null 2>&1; then
  # BSD ls
  alias ls='ls -G'
  alias ll="ls -lhaG"
  alias llt="ls -lhrtG"
fi
