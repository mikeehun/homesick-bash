# ~/.bash_logout: executed by bash(1) when login shell exits.

history -a

cat ~/.bash_history | nl | sort -k 2 | uniq -f 1 | sort -n | cut -f 2 > /tmp/bash_history_bak
cp -f /tmp/bash_history_bak ~/.bash_history

# when leaving the console clear the screen to increase privacy
clear
