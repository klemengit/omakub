#!/bin/bash

gum spin --spinner meter --title "Installing Inkscape" -- sleep 3
flatpak install -y flathub org.inkscape.Inkscape
