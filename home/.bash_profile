# .bash_profile

if [ "$TERM" == "xterm" ]; then
	if [ "$COLORTERM" == "gnome-terminal" ] || [ "$COLORTERM" == "xfce4-terminal" ]; then
		TERM=xterm-256color
	elif [ "$COLORTERM" == "rxvt-xpm" ]; then
		TERM=rxvt-256color
	fi
elif [ "$TERM" == "urxvt" ]; then
	TERM=rxvt-unicode
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -d "$HOME/bin" ] ; then
	PATH=$HOME/bin:$PATH
	export PATH
fi

EDITOR='vim'
export EDITOR
