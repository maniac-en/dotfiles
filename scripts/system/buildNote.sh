#!/usr/bin/env bash

filename="$1"
target="$(dirname "${filename}")/pdf"
outputFile="$(basename "$filename" .md).pdf"
mkdir -p "$target"

pandoc \
    --pdf-engine=xelatex \
    --highlight-style zenburn \
    -f markdown-blank_before_blockquote \
    -V 'mainfont:DejaVuSerif' \
    -V 'mainfontoptions:Extension=.ttf, UprightFont=*, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic' \
    -V 'sansfont:DejaVuSans.ttf' \
    -V 'monofont:DejaVuSansMono.ttf' \
    -V "geometry:margin=1in" \
    -o "$target"/"$outputFile" \
    "$filename" && \
    "$HOME"/bin/notify2 "Note-making" "Build successful" -t 2000 -r 213 -i "/usr/share/icons/Faba/64x64/mimetypes/x-office-document.png"
