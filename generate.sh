#!/bin/bash

source profile/.profile
source themes/gruvbox.sh

envsubst <alacritty/.config/alacritty/alacritty.toml.template \
  >alacritty/.config/alacritty/alacritty.toml

envsubst '${FONT_SIZE}' <i3/.config/i3/config.template \
  >i3/.config/i3/config

envsubst <hypr/.config/hypr/hyprpaper.conf.template \
  >hypr/.config/hypr/hyprpaper.conf

echo $BG
