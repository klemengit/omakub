#!/bin/bash
# Only ask for default desktop app choices when running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  OPTIONAL_APPS=("1password" "Spotify" "Zoom" "Dropbox" "Inkscape" "GIMP" "DoubleCMD" "BitWarden" "Chromium")
  export OMAKUB_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected "Zoom" --selected "Inkscape" --selected "GIMP" --selected "DoubleCMD" --selected "BitWarden" --selected "Chromium" --height 7 --header "Select optional apps" | tr ' ' '-')
fi

AVAILABLE_LANGUAGES=("Python")
SELECTED_LANGUAGES="Python"
export OMAKUB_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")

AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
SELECTED_DBS="PostgreSQL"
export OMAKUB_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")
