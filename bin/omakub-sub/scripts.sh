#!/bin/bash

CHOICES=(
  "Install latex     Install a full texlive."
  "Firefox symlink   Create a symlink from firefox (snap) to system, so the system discovers the certificates."
  "nidaqmx driver    Install the nidaqmx driver."
  "eduroam           Set up eduroam wifi."
  "Slovenian keyboard  Install Slovenian keyboard layout without dead keys."
  "<< Back           "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 26 --header "Run script")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  # Don't install anything
  echo ""
else
  INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

  case "$INSTALLER" in
  "install-latex") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/install_latex.sh" ;;
  "firefox-symlink") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/firefox-symlink.sh" ;;
  "nidaqmx-driver") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/nidaqmx.sh" ;;
  "eduroam") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/eduroam.sh" ;;
  "slovenian-keyboard") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/slovenian-keyboard.sh" ;;
  # ...
  esac

  source $INSTALLER_FILE && gum spin --spinner globe --title "Script executed!" -- sleep 3
fi

clear
source $OMAKUB_PATH/bin/omakub
