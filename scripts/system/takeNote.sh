#!/usr/bin/env bash

notesDir="$HOME/notes/d_notes"
noteFilename="note-$(date +%d-%m-%Y).md"
note="$notesDir/$noteFilename"

if [ ! -f "$note" ]; then
  echo "# Notes for $(date +%d-%m-%Y)" > "$note"
fi

sleep 0.15
vim -c "norm Go" \
  -c "norm Go## $(date +"%I:%M %p")" \
  -c "norm G2o" \
  -c "norm zz" \
  -c "startinsert" "$note"
