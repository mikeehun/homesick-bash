# .bashrc

# uncomment to debug
#set -x

# expand aliases on non-interactive shell
shopt -s expand_aliases

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# If not running interactively, skip the rest
[ -z "$PS1" ] && return

# if not a login shell, produce a warning
[ "$(shopt login_shell | cut -f2)" == "off" ] && echo "Warning: not a login shell. configure your terminal!"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# fix history.
# keeps track with multiple shells open !!!
# using .bash_logout to erase non-sequencial duplicates.
export HISTCONTROL=erasedups            # no sequencial duplicate entries
export HISTSIZE=100000                  # big big history
export HISTFILESIZE=100000              # big big history
export HISTIGNORE="&:cd:ls:exit:logout:top:pwd:clear:uptime"
export PROMPT_COMMAND="history -a"      # append history to .bash_history after every command

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
	xterm-256color) color_prompt=yes;;
	rxvt-256color) color_prompt=yes;;
	rxvt-unicode) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ]; then
		if [ $(tput colors) -ge 8 ]; then
			color_prompt=yes
		else
			color_prompt=
		fi
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	PS1="\n\[\033[1;37m\]\342\224\214[\!]\
 $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;35m\]\u\[\033[00;35m\]@\h'; fi)\[\033[1;37m\] \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]V\"; else echo \"\[\033[01;31m\]X\"; fi)\[\033[1;37m\] \[\033[1;34m\]\w\[\033[1;37m\]\[\033[1;37m\]\n\342\224\224\342\224\200 \$ \[\033[0m\]"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset force_color_prompt

# FIRST add functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# AND THEN aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load custom bash completions
while read f; do
	. "$f"
done < <(find ~/.bash_completion.d/ -type f -name "*completion*.*sh")

# Load custom scripts to ~/bin
load-scripts

