#!/usr/bin/env bash

DIR="${1:-.}"

find "$DIR" -type f \( \
    -iname '*.jpg' -o \
    -iname '*.jpeg' -o \
    -iname '*.png' -o \
    -iname '*.bmp' -o \
    -iname '*.tiff' -o \
    -iname '*.gif' \
    \) | while read -r img; do

    # get extension & base name
    ext="${img##*.}"
    base="${img%.*}"
    bak="${base}.bak.${ext}"

    # create backup
    if [ ! -f "$bak" ]; then
        echo "creating backup: $img -> $bak"
        cp "$img" "$bak"
    else
        echo "backup already exists: $bak"
    fi

    out="${base}.webp"
    if [ -f "$out" ]; then
        echo "skipping (already exists): $out"
        continue
    fi
    echo "converting: $img -> $out"
    magick convert "$img" "$out"
done
