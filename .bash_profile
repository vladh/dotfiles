#colors
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export TERM='screen-256color'
alias tmux="TERM=screen-256color tmux"
export GREP_OPTIONS="--color"
red=`tput setaf 1`
alsored=`tput setaf 6`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
purple=`tput setaf 5`
reset=`tput sgr0`
bold=`tput bold`

#aliases
alias ls='ls -G'
alias ll="ls -lhaG"
alias irb="irb --simple-prompt"
alias c="clear"
alias j="jobs"
alias ta="tmux attach -t"
alias tl="tmux ls"

if [ -f .bash_profile_private ]; then
	source .bash_profile_private
fi

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.pineapples"
#if [ -f /usr/libexec/java_home ]; then
#	export JAVA_HOME=$(/usr/libexec/java_home)
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
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${NORMAL}"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "%s|${SINCE_LAST_COMMIT}"`
        echo ${GIT_PROMPT}" "
    fi
}

#prompt
prompt_char="∆"

function prompt-normal {
    PS1="\[\033[G\]\[$blue\]\h \[$bold\]\[$yellow\]\w \[$red\]\$(grb_git_prompt)\[$green\]\[$bold\]$prompt_char \[$reset\]"
}
function prompt-min {
    PS1="\[\033[G\]\[$green\]\[$bold\]$prompt_char \[$reset\]"
}
prompt-normal

#sources
source ~/bin/git-completion.bash
source ~/.bashrc

# Add paths
export PATH=/usr/local/bin:/usr/local/git/bin:/usr/local/sbin:/usr/games/bin:${PATH}
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"

#rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
