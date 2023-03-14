#!/bin/bash

clear

## Read new wallpaper path
read -p "Enter wallpaper file name [Leaves.jpg]: " bgname
bgname=${bgname:-Leaves.jpg}


# Set wallpaper
cd ~
xwallpaper --center Pictures/Wallpapers/$bgname
sed -i '/xwallpaper/d' .xinitrc
echo "xwallpaper --center ~/Pictures/Wallpapers/$bgname" | cat - .xinitrc > temp && mv temp .xinitrc

## Generate new pywal colours
wal -i Pictures/Wallpapers/$bgname
sed -i "/SchemeUrg/d" .cache/wal/colors-wal-dwm.h
cp .cache/wal/colors.Xresources .Xresources
xrdb -merge ~/.Xresources

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

