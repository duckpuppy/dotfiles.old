# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [[ -n "$PS1" ]] ; then

# enable ps1_functions
if [ -f ~/.ps1_functions ]; then
    . ~/.ps1_functions
fi

# Useful for adding the branch to your prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git:\1)/'
}

parse_git_short_hash() {
  git show --abbrev-commit 2> /dev/null | grep "^commit" | sed -e '/^[^commit]/d' -e 's/commit \(.*\)/\1/'
}

# Useful for adding the branch to your prompt
parse_git_branch_bare() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/git:\1/'
}

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
rxvt-cygwin-native) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

###################### the above is a separate prompt which can be used instead of below. NOTE: only ONE line at a time should be uncommented. so there are 5 different prompts above!!!!!

# color_name='\[\033[ color_code m\]'

rgb_restore='\e[00m'
rgb_black='\e[00;30m'
rgb_firebrick='\e[00;31m'
rgb_red='\e[01;31m'
rgb_forest='\e[00;32m'
rgb_green='\e[01;32m'
rgb_brown='\e[00;33m'
rgb_yellow='\e[01;33m'
rgb_navy='\e[00;34m'
rgb_blue='\e[01;34m'
rgb_purple='\e[00;35m'
rgb_magenta='\e[01;35m'
rgb_cadet='\e[00;36m'
rgb_cyan='\e[01;36m'
rgb_gray='\e[00;37m'
rgb_white='\e[01;37m'

rgb_std="${rgb_white}"

if [ `id -u` -eq 0 ]
then
    rgb_usr="${rgb_red}"
else
    rgb_usr="${rgb_forest}"
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\n\[${rgb_usr}\]\u@\h:\[${rgb_brown}\]\w \[${rgb_purple}\]\$(parse_git_branch)\n\[${rgb_restore}\]\\$ "
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(parse_git_branch)\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $(parse_git_branch)\n\$ '
fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Override all the functions if ps1_set is available
if type -t ps1_set | grep -q "^function$"; then
	ps1_set --notime "$ "
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
#    alias dir='dir --color=auto'
#    alias vdir='vdir --color=auto'

#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable bash_functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable completions
if [ -d ~/.bash_completion.d ]; then
    for f in $( ls ~/.bash_completion.d ); do
       source ~/.bash_completion.d/$f
    done 
fi

export ALTERNATE_EDITOR=""
export VISUAL="vim"
export EDITOR="vim"
#alias emacs="vim"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
[[ -r $HOME/.rvm/scripts/completion ]] && . $HOME/.rvm/scripts/completion

fi



PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
