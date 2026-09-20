#
# ~/.bash_profile
#

# startx

[[ -f ~/.bashrc ]] && . ~/.bashrc

eval $(gnome-keyring-daemon --start)


# Added by Antigravity CLI installer
export PATH="/home/kuba/.local/bin:$PATH"
