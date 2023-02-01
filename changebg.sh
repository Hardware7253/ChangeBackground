#!/bin/bash

clear

## Read new wallpaper path
read -p "Enter wallpaper file name: " bgname

# Set wallpaper
xwallpaper --center ~/Pictures/Wallpapers/$bgname
sed -i '/xwallpaper/d' ~/.xinitrc
sed -i "1ixwallpaper --center ~/Pictures/Wallpapers/$bgname" ~/.xinitrc

## Generate new pywal colours
wal -i ~/Pictures/Wallpapers/$bgname
sed -i "/SchemeUrg/d" ~/.cache/wal/colors-wal-dwm.h

## Rebuild suckless programs
build() {
 cd "$srcpath"
 sudo make clean install
 return
}

srcpath="/usr/src/dwm"
build

srcpath="/usr/src/st"
build

srcpath="/usr/src/dmenu"
build

