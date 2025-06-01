#!/usr/bin/env bash

# defaults.
RADIUS=16
PADDING=32
SHADOW=1

# parse args.
while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-shadow) SHADOW=0; shift ;;
    --radius) RADIUS="$2"; shift 2 ;;
    --padding) PADDING="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# prep.
FILENAME=$(date +%Y-%m-%d_%H-%M-%S).png
DIR=~/Pictures/Screenshots
mkdir -p "$DIR"

grim -g "$(slurp)" - > "$DIR/$FILENAME"
cp "$DIR/$FILENAME" "$DIR/${FILENAME%.png}_original.png"

# apply effects.
WIDTH=$(magick identify -format "%w" "$DIR/$FILENAME")
HEIGHT=$(magick identify -format "%h" "$DIR/$FILENAME")

if [[ "$RADIUS" -eq 0 ]]; then
  magick "$DIR/$FILENAME" \
    \( -size "${WIDTH}"x"${HEIGHT}" xc:none -draw "fill white rectangle 0,0 $((WIDTH-1)),$((HEIGHT-1))" \) \
    -alpha off -compose CopyOpacity -composite "$DIR/$FILENAME"
else
  magick "$DIR/$FILENAME" \
    \( -size "${WIDTH}"x"${HEIGHT}" xc:none -draw "fill white roundrectangle 0,0 $((WIDTH-1)),$((HEIGHT-1)) $RADIUS,$RADIUS" \) \
    -alpha off -compose CopyOpacity -composite "$DIR/$FILENAME"
fi

magick "$DIR/$FILENAME" -bordercolor none -border "${PADDING}" "$DIR/$FILENAME"

if [[ "$SHADOW" -eq 1 ]]; then
  magick "$DIR/$FILENAME" \
    \( +clone -background none -shadow 60x16+0+8 \) \
    +swap -background none -layers merge +repage "$DIR/$FILENAME"
fi

wl-copy < "$DIR/$FILENAME"
