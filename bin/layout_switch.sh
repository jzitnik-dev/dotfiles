#!/bin/zsh
# LICENSE: PUBLIC DOMAIN
# switch between my layouts

# If an explicit layout is provided as an argument, use it. Otherwise, select the next layout from
# the set [us, it, fr].
if [[ -n "$1" ]]; then
    setxkbmap $1
else
    layout=$(setxkbmap -query | awk '/layout/{print $2}')
    case $layout in
        cz)
                notify-send "Layout changed!" "Keyboard layout was changed to US."
                setxkbmap us
            ;;
        *)
                notify-send "Layout changed!" "Keyboard layout was changed to CZ."
                setxkbmap cz
            ;;
    esac
fi
xmodmap ~/.Xmodmap
