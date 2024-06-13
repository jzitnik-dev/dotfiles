#!/usr/bin/env bash

dir="$HOME/.config/rofi"
theme='style-1'

## Run
cliphist list | \
rofi \
  -dmenu \
  -theme "${dir}/${theme}" | \
cliphist decode | \
wl-copy
