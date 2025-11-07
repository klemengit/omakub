#!/bin/bash

# Install a full TeXLive distribution with all packages and documentation

echo "Installing TeXLive (this may take a while and require ~5-7 GB of disk space)..."

# Update package lists
gum spin --spinner meter --title "Updating package lists" -- \
  sudo apt-get update

# Install texlive-full which includes all LaTeX packages
gum spin --spinner meter --title "Installing TeXLive (this will take several minutes)" -- \
  sudo apt-get install -y texlive-full

# Verify installation
if command -v pdflatex &> /dev/null && command -v xelatex &> /dev/null; then
  echo " TeXLive installation complete"
  echo ""
  echo "Installed compilers:"
  echo "  " pdflatex ($(pdflatex --version | head -n 1))"
  echo "  " xelatex ($(xelatex --version | head -n 1))"
  echo "  " lualatex ($(lualatex --version | head -n 1))"
  echo ""
else
  echo " TeXLive installation failed"
  exit 1
fi
