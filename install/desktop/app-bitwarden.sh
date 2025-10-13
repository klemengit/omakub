#!/bin/bash

gum spin --spinner meter --title "Installing Bitwarden application" -- sleep 3
flatpak install -y flathub com.bitwarden.desktop
