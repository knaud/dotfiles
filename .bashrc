export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# read system-wide bashrc if it exists
bash_prefix=$(dirname $(dirname $(which bash)))
if [ -f "$bash_prefix/etc/bashrc" ]; then
    . "$bash_prefix/etc/bashrc"
fi
unset bash_prefix

#
# general stuff
#
# update window size after every command
shopt -s checkwinsize

#
# better bash history
#
# don't put duplicate lines or lines starting with space
export HISTCONTROL="erasedups:ignoreboth"

# append to history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=200000
export HISTFILESIZE=300000

# enable incremental history search with up/down arrows (also Readline goodness)
# http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

#
# smarter tab completion (readline bindings)
#
# perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

#
# path
#
export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/python/libexec/bin:$PATH

#
# less config
#
# -F: exit if output fits on screen
# -X: don't send termcap init/deinit string (necessary with -F)
# -R: show ansi colors (don't escape them)
export LESS="-FXR"
if command -v src-hilite-lesspipe.sh > /dev/null; then
    export LESSOPEN="| src-hilite-lesspipe.sh %s"
fi


#
# colored prompt
#
export PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[1;30m\]$(__git_ps1)\[\e[0m\]\$ '

#
# iterm
#
if [ -n "$ITERM_SESSION_ID" ]; then
    # set current folder as iterm title
    # \e]: escape sequence incoming!
    # 0; set both and title (1=only tab, 2=only title)
    # ${PWD##*/} the last dir of #PWD
    # \a BEL escape sequence done, signal to iterm
    SET_ITERM_TITLE='echo -ne "\e]0;${PWD##*/}\a"'
    export PROMPT_COMMAND="$SET_ITERM_TITLE;$PROMPT_COMMAND"
fi

#
# local overrides (.bashrc.local isn't in the dotfiles repo)
#
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
