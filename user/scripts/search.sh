#!/usr/bin/env bash

CACHE="$HOME/.cache/_scripts/search_index"
DIRS="$HOME"
CACHE_AGE=600

mkdir -p "$(dirname "$CACHE")"

refresh_cache() {
    find "$DIRS" \
        -type d \( \
            -name .cache -o -name .git -o -name _cacache -o -name node_modules \
            -o -name .cargo -o -name .npm -o -name .yarn -o -name .local \
            -o -name .mozilla -o -name .thumbnails -o -name .steam \
            -o -name .var -o -name .android -o -name .vscode \
            -o -name .conda -o -name .miniconda* -o -name .pyenv \
            -o -name .rbenv -o -name .gem -o -name .bundle \
            -o -name .snap -o -name .Trash* -o -name .wine \
            -o -name .VirtualBox* -o -name .docker -o -name .gvfs \
            -o -name .flatpak  -o -name .nextcloud \
            -o -name sessionData -o -name target -o -name .cargo-cache \
            -o -name BeeperTexts -o -name .thunderbird \
        \) -prune -o \
        \( -type f -o -type d \) -print 2>/dev/null > "$CACHE"
}

# refresh the cache in background if it's missing or too old.
if [[ ! -f "$CACHE" || $(find "$CACHE" -mmin +$((CACHE_AGE/60)) 2>/dev/null) ]]; then
    refresh_cache &
fi

# wait for the cache to be built.
if [[ ! -s "$CACHE" ]]; then
    rofi -e "cache is being built. please try again in a moment."
    exit 1
fi

SELECTED=$(cat "$CACHE" | rofi -dmenu -i -p "open file/dir")

if [[ -n "$SELECTED" ]]; then
    if command -v xdg-open >/dev/null; then
        xdg-open "$SELECTED"
    elif command -v open >/dev/null; then
        open "$SELECTED"
    else
        echo "no opener found for $SELECTED"
    fi
fi
