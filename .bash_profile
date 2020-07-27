export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export PYTHONIOENCODING=utf-8

shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%F %T "
export HISTFILE=~/.history
export PROMPT_COMMAND='history -a && echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log'

export FZF_DEFAULT_COMMAND='fd --type f -H -E .git'
export PATH=/usr/local/bin:/usr/local/git/bin:/usr/local/sbin:/usr/games/bin:${PATH}
export PATH="$HOME/.bin_private:$HOME/.bin:$PATH"

if [ "$(uname)" == "Darwin" ] || [ "$(uname)" == "FreeBSD" ]; then
  export TERM='screen-256color'
fi

if [ "$(uname)" == "Darwin" ] || [ "$(uname)" == "Linux" ] || [ "$(uname)" == "FreeBSD" ]; then
  prompt_char="$"
else
  prompt_char=">"
fi

if [ "$(uname)" == "FreeBSD" ]; then
  c_red='\e[0;31m'
  c_alsored='\e[0;31m'
  c_green='\e[0;32m'
  c_yellow='\e[1;33m'
  c_blue='\e[0;34m'
  c_purple='\e[0;35m'
  c_reset='\e[0m'
  c_bold=`tput bold`
else
  c_red=`tput setaf 1`
  c_alsored=`tput setaf 6`
  c_green=`tput setaf 2`
  c_yellow=`tput setaf 3`
  c_blue=`tput setaf 4`
  c_purple=`tput setaf 5`
  c_reset=`tput sgr0`
  c_bold=`tput bold`
fi

source ~/.bin/git-completion.bash
source ~/.bin/git-prompt.sh

git_prompt() {
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    local GIT_PROMPT=`__git_ps1 "%s"`
    echo ":${GIT_PROMPT} "
  fi
}

venv_prompt() {
  if [ -n "${VIRTUAL_ENV}" ]; then
    echo "venv "
  fi
}

export PS1="\[\033[G\]\[$c_blue\]\u \[$c_red\]\h\[$c_blue\] \W\$(git_prompt)\$(venv_prompt)\[$c_blue\]$prompt_char \[$c_reset\]"

declare -fx __git_eread
declare -fx __git_find_repo_path
declare -fx __git_ps1
declare -fx __gitdir
declare -fx git_prompt
declare -fx venv_prompt

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.bash_profile_private ]; then
  source ~/.bash_profile_private
fi

source ~/.bin/z.sh
