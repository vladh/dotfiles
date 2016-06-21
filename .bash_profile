#colors
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
alias tmux="TERM=xterm-256color tmux"
alias grep="grep --color"

if [ "$(uname)" == "Darwin" ]; then
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

#aliases
if [ "$(uname)" == "Darwin" ]; then
  alias ls='ls -G'
  alias ll="ls -lhaG"
  alias lt="ls -lhrtG"
else
  alias ls='ls --color'
  alias ll="ls -lha --color"
  alias lt="ls -lhrt --color"
fi
alias ta="tmux attach -t"
alias tl="tmux ls"
alias isodate="date -u +'%Y-%m-%dT%H:%M:%SZ'"

#sources
source ~/.bin/git-completion.bash
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# History
unset HISTFILE
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

#git
function minutes_since_last_commit {
  now=`date +%s`
  last_commit=`git log --pretty=format:'%at' -1`
  seconds_since_last_commit=$((now-last_commit))
  minutes_since_last_commit=$((seconds_since_last_commit/60))
  echo $minutes_since_last_commit
}
git_prompt() {
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    local GIT_PROMPT=`__git_ps1`
    echo ${GIT_PROMPT}" "
  fi
}
git_prompt_with_minutes() {
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    local branch_count=$(git branch -a --no-color | wc -l | bc)
    if [ $branch_count -gt 0 ]; then
      local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
      if [ "$MINUTES_SINCE_LAST_COMMIT" -lt 60 ]
      then
        local SINCE_LAST_COMMIT="$(minutes_since_last_commit)m"
      elif [ "$MINUTES_SINCE_LAST_COMMIT" -lt 1440 ]
      then
        local SINCE_LAST_COMMIT="$(expr $MINUTES_SINCE_LAST_COMMIT / 60)h$(expr $MINUTES_SINCE_LAST_COMMIT % 60)m"
      else
        local SINCE_LAST_COMMIT="$(expr $MINUTES_SINCE_LAST_COMMIT / 1440)d$(expr $MINUTES_SINCE_LAST_COMMIT % 1440 / 60)h"
      fi
      # The __git_ps1 function inserts the current git branch where %s is
      local GIT_PROMPT=`__git_ps1 "%s|${SINCE_LAST_COMMIT}"`
      echo ${GIT_PROMPT}" "
    fi
    local GIT_PROMPT=`__git_ps1`
    echo ${GIT_PROMPT}" "
  fi
}

#prompt
prompt_char="∆"

function prompt-username {
  PS1="\[\033[G\]\[$c_blue\]\h \[$c_bold\]\[$c_green\]\u \[$c_bold\]\[$c_yellow\]\W \[$c_red\]\$(git_prompt)\[$c_green\]\[$c_bold\]$prompt_char \[$c_reset\]"
}
prompt-username

# Add paths
export PATH=/usr/local/bin:/usr/local/git/bin:/usr/local/sbin:/usr/games/bin:${PATH}
export PATH="$HOME/.bin_private:$HOME/.bin:$PATH"

if [ -f ~/.bash_profile_private ]; then
  source ~/.bash_profile_private
fi
