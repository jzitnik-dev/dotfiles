#!/bin/bash
cp -r .config/* ~/.config/
cp -r .xmonad ~
cp -r bin ~
cp -r wallpapers ~

mv ~/.bash_profile{,.old}
cp .bash_profile ~
mv ~/.bashrc{,.old}
cp .bashrc ~

cp .Xmodmap ~
cp bash.command-not-found /etc

cp .tmux.conf ~/.tmux.conf
cp .tmux.conf.local ~/.tmux.conf.local

# This needs sudo so asking for it
# Sorry if you use doas
sudo mv /etc/xdg/swayosd{,.bak}
sudo cp -r ./swayosd /etc/xdg/swayosd
sudo mv /etc/xdg/swaync{,.bak}
sudo cp -r ./swaync /etc/xdg/swaync
