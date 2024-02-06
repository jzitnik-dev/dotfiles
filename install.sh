#!/bin/bash
cp -r .config/* ~/.config/
cp -r .xmonad ~
cp -r bin ~
cp -r wallpapers ~

mv ~/.bash_profile ~/.bash_profile.old
cp .bash_profile ~
mv ~/.bashrc ~/.bashrc.old
cp .bashrc ~

cp .Xmodmap ~
cp bash.command-not-found /etc
