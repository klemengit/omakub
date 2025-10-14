#!/bin/bash

gum spin --spinner meter --title "Installing Chromium application" -- sleep 3
flatpak install -y flathub org.chromium.Chromium
