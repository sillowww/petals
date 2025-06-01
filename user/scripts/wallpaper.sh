#!/usr/bin/env bash
set -e

CACHE_DIR="$HOME/.cache/wallpaper-gradients"
mkdir -p "$CACHE_DIR"

TRANSITION_BEZIER=".05,.4,.49,.96"
GRADIENT_HEIGHT=96

RANDOM_WALLPAPER=0
while [[ $# -gt 0 ]]; do
    case "$1" in
        -r|--random)
            RANDOM_WALLPAPER=1
            shift
            ;;
        *)
            shift
            ;;
    esac
done

mapping=$(mktemp)
find ~/Pictures/Wallpapers -type f -name "*.jpg" -o -name "*.png" -o -name "*.webp" -o -name "*.jpeg" | while read -r path; do
    rel="${path#"$HOME"/Pictures/Wallpapers/}"
    dir=$(dirname "$rel")
    file=$(basename "$rel")
    name="${file%.*}"
    if [ "$dir" != "." ]; then
        pretty="$dir - $name"
    else
        pretty="$name"
    fi
    echo "$pretty|$path"
done > "$mapping"

if [[ "$RANDOM_WALLPAPER" -eq 1 ]]; then
    selected_line=$(shuf -n1 "$mapping")
    wallpaper=$(echo "$selected_line" | cut -d'|' -f2-)
    rm "$mapping"
    [ -z "$wallpaper" ] && exit 1
else
    selected_pretty=$(cut -d'|' -f1 "$mapping" | dmenu -i -l 20 -p "Select wallpaper:")
    [ -z "$selected_pretty" ] && rm "$mapping" && exit 1

    wallpaper=$(grep -F "$selected_pretty|" "$mapping" | head -n1 | cut -d'|' -f2-)
    rm "$mapping"
    [ -z "$wallpaper" ] && exit 1
fi

hash=$(printf "%s|%s|%s" "$wallpaper" "$GRADIENT_HEIGHT" "$TRANSITION_BEZIER" | sha256sum | cut -d' ' -f1)
cached_wallpaper="$CACHE_DIR/$hash.png"

if [ ! -f "$cached_wallpaper" ]; then
    width=$(identify -format "%w" "$wallpaper")

    gradient_png=$(mktemp --suffix=.png)
    magick -size "${width}x${GRADIENT_HEIGHT}" gradient:none-black -sigmoidal-contrast 4,50% "$gradient_png"
    magick "$wallpaper" "$gradient_png" -gravity south -composite "$cached_wallpaper"
    rm "$gradient_png"
fi

swww img "$cached_wallpaper" --transition-bezier $TRANSITION_BEZIER -t grow
