#!/usr/bin/env bash

# defaults.
RADIUS=16
PADDING=32
SHADOW=1
WINDOW=0

# parse args.
while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-shadow) SHADOW=0; shift ;;
    --radius) RADIUS="$2"; shift 2 ;;
    --padding) PADDING="$2"; shift 2 ;;
    --window) WINDOW=1; shift ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# prep.
FILENAME=$(date +%Y-%m-%d_%H-%M-%S).png
DIR=~/Pictures/Screenshots
mkdir -p "$DIR"
grim -g "0,0 3840x1080" - > "$DIR/$FILENAME.original"

GEOM=""
if [[ "$WINDOW" -eq 1 ]]; then
  GEOM=$(swaymsg -t get_tree | jq -r '
    .. | (.nodes? // empty)[]?, (.floating_nodes? // empty)[]
      | select(.pid and .visible)
      | {name} + .rect
      | "\(.x),\(.y) \(.width)x\(.height) \(.name)"
  ' | slurp -r)
else
  GEOM=$(slurp)
fi

read -r XY WH <<< "$GEOM"
X=${XY%,*}
Y=${XY#*,}
CROP="${WH}+${X}+${Y}"

magick "$DIR/$FILENAME.original" -crop "$CROP" +repage "$DIR/${FILENAME%.png}.png"

# apply effects.
WIDTH=$(magick identify -format "%w" "$DIR/$FILENAME")
HEIGHT=$(magick identify -format "%h" "$DIR/$FILENAME")

if [[ "$RADIUS" -eq 0 ]]; then
  magick "$DIR/$FILENAME" \
    \( -size "${WIDTH}"x"${HEIGHT}" xc:none -draw "fill white rectangle 0,0 $((WIDTH-1)),$((HEIGHT-1))" \) \
    -alpha off -compose CopyOpacity -composite "$DIR/$FILENAME"
else
  # apply rounded corners.
  magick "$DIR/$FILENAME" \
    \( -size "${WIDTH}"x"${HEIGHT}" xc:none -draw "fill white roundrectangle 0,0 $((WIDTH-1)),$((HEIGHT-1)) $RADIUS,$RADIUS" \) \
    -alpha off -compose CopyOpacity -composite "$DIR/$FILENAME"

    BORDER_COLOR="#f5c2e7"
    BORDER_WIDTH=1

    # add border.
    magick -size "${WIDTH}x${HEIGHT}" xc:none \
      -stroke "$BORDER_COLOR" -strokewidth $BORDER_WIDTH -fill none \
      -draw "roundrectangle $((BORDER_WIDTH/2)),$((BORDER_WIDTH/2)) $((WIDTH-1-BORDER_WIDTH/2)),$((HEIGHT-1-BORDER_WIDTH/2)) $RADIUS,$RADIUS" \
      "$DIR/border.png"

    magick "$DIR/$FILENAME" "$DIR/border.png" -compose over -composite "$DIR/$FILENAME"

    rm "$DIR/border.png"
fi

# add padding
magick "$DIR/$FILENAME" -bordercolor none -border "${PADDING}" "$DIR/$FILENAME"

# add shadow
if [[ "$SHADOW" -eq 1 ]]; then
  magick "$DIR/$FILENAME" \
    \( +clone -background none -shadow 60x16+0+8 \) \
    +swap -background none -layers merge +repage "$DIR/$FILENAME"
fi

wl-copy < "$DIR/$FILENAME"
