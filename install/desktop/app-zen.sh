#!/bin/bash

gum spin --spinner meter --title "Installing Zen browser" -- sleep 3
flatpak install -y flathub app.zen_browser.zen

# Wait and find the actual desktop file
#gum spin --spinner meter --title "Setting Zen as default browser" -- sleep 2
#ZEN_DESKTOP=$(ls /var/lib/flatpak/exports/share/applications/ | grep -i zen | head -n1)

#if [ -n "$ZEN_DESKTOP" ]; then
#  gio mime x-scheme-handler/http "$ZEN_DESKTOP"
#  gio mime x-scheme-handler/https "$ZEN_DESKTOP"
#  gio mime text/html "$ZEN_DESKTOP"
#  echo "✓ Zen Browser set as default"
#else
#  echo "✗ Could not find Zen Browser desktop file"
#fi
