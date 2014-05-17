# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt vladh

# Initialize completion
autoload -U compinit
compinit

# Colorize terminal
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
alias tmux="TERM=xterm-256color tmux"
export GREP_OPTIONS="--color"

if [[ "$(uname)" == "Darwin" ]]; then
  export TERM='screen-256color'
fi

c_red=`tput setaf 1`
c_alsored=`tput setaf 6`
c_green=`tput setaf 2`
c_yellow=`tput setaf 3`
c_blue=`tput setaf 4`
c_purple=`tput setaf 5`
c_reset=`tput sgr0`
c_bold=`tput bold`

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.pineapples"
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export EDITOR=vi
# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back.
set -o emacs

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

# Aliases
if [[ "$(uname)" == "Darwin" ]]; then
  alias ls='ls -G'
  alias ll="ls -lhaG"
  alias lt="ls -lhrtG"
else
  alias ls='ls --color'
  alias ll="ls -lha --color"
  alias lt="ls -lhrt --color"
fi
alias irb="irb --simple-prompt"
alias j="jobs"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias dogecat="while true; do doge | lolcat -a -d 100 -s 100 -p 1; done"
alias ioana="say -v ioana"

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol
# Run Selecta in the current working directory, appending the selected path, if
# any, to the current command.
function insert-selecta-path-in-command-line() {
    local selected_path
    # Print a newline or we'll clobber the old prompt.
    echo
    # Find the path; abort if the user doesn't select anything.
    selected_path=$(find * -type f | selecta) || return
    # Append the selection to the current command buffer.
    eval 'LBUFFER="$LBUFFER$selected_path"'
    # Redraw the prompt since Selecta has drawn several new lines of text.
    zle reset-prompt
}
# Create the zle widget
zle -N insert-selecta-path-in-command-line
# Bind the key to the newly created widget
bindkey "^S" "insert-selecta-path-in-command-line"
zstyle ':completion:*:*:git:*' script /usr/local/share/zsh/site-functions

# Add paths
export PATH=/usr/local/bin:/usr/local/git/bin:/usr/local/sbin:/usr/games/bin:${PATH}
export PATH="$HOME/.bin:$PATH"

# Includes
. ~/.bin/z.sh
if [[ -f ~/.zshrc_private ]]; then
  . ~/.zshrc_private
fi
