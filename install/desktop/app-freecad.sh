#!/bin/bash

gum spin --spinner meter --title "Installing FreeCAD" -- sleep 3
flatpak install -y flathub org.freecad.FreeCAD
