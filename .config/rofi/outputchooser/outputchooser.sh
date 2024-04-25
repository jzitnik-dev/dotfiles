#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='style-1'

## Run
rofi \
    -show rofi-sound \
    -modi rofi-sound:~/bin/rofi-sound-output-chooser \
    -theme ${dir}/${theme}.rasi
