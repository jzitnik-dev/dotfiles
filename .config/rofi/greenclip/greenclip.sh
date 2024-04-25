#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='style-1'

## Run
rofi \
    -modi "\63053 :greenclip print" \
    -show "\63053 " \
    -run-command '{cmd}' \
    -theme ${dir}/${theme}.rasi
