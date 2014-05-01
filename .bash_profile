#colors
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
alias tmux="TERM=screen-256color tmux"
export GREP_OPTIONS="--color"
# set -o vi

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
alias irb="irb --simple-prompt"
alias j="jobs"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias dogecat="while true; do doge | lolcat -a -d 100 -s 100 -p 1; done"
alias ioana="say -v ioana"

#sources
source ~/.bin/git-completion.bash
source ~/.bin/bashmarks/bashmarks.sh
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.pineapples"
#if [ -f /usr/libexec/java_home ]; then
# export JAVA_HOME=$(/usr/libexec/java_home)
#fi
export SAVEHIST=$HISTSIZE

#git
function minutes_since_last_commit {
  now=`date +%s`
  last_commit=`git log --pretty=format:'%at' -1`
  seconds_since_last_commit=$((now-last_commit))
  minutes_since_last_commit=$((seconds_since_last_commit/60))
  echo $minutes_since_last_commit
}
grb_git_prompt() {
 	local g="$(__gitdir)"
	if [ -n "$g" ]; then

	# confirm that there is an active branch
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
	fi
}

#prompt
prompt_char="∆"

function prompt-normal {
  PS1="\[\033[G\]\[$c_blue\]\h \[$c_bold\]\[$c_yellow\]\w \[$c_red\]\$(grb_git_prompt)\[$c_green\]\[$c_bold\]$prompt_char \[$c_reset\]"
}
function prompt-username {
  PS1="\[\033[G\]\[$c_blue\]\h \[$c_bold\]\[$c_green\]\u \[$c_bold\]\[$c_yellow\]\W \[$c_red\]\$(grb_git_prompt)\[$c_green\]\[$c_bold\]$prompt_char \[$c_reset\]"
}
function prompt-min {
  PS1="\[\033[G\]\[$c_green\]\[$c_bold\]$prompt_char \[$c_reset\]"
}
prompt-username

# Add paths
export PATH=/usr/local/bin:/usr/local/git/bin:/usr/local/sbin:/usr/games/bin:${PATH}
export PATH="$HOME/.bin:$PATH"
if [[ `hostname -s` = 'sun' ]]; then
  export PATH=.:${PATH}
fi

if [ -f ~/.bash_profile_private ]; then
  source ~/.bash_profile_private
fi
