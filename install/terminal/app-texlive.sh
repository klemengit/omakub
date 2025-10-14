#!/bin/bash

# Install LaTeX packages
gum spin --spinner meter --title "Installing LaTeX (this may take a while)..." -- \
  sudo apt install -y \
  texlive-full \
  latexmk

echo "✓ LaTeX installation complete"
