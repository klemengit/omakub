#!/bin/bash

# Create a symlink from firefox to system (for the system to discrover the certificates that are imported in firefox)

# Create the ~/.mozilla/firefox directory if it doesn't exist
mkdir -p ~/.mozilla/firefox

# Find the Firefox snap profile directory
SNAP_PROFILE_DIR=$(find ~/snap/firefox/common/.mozilla/firefox -maxdepth 1 -type d -name "*.default" | head -n 1)

# Check if a profile directory was found
if [ -z "$SNAP_PROFILE_DIR" ]; then
  echo "Error: No Firefox snap profile found. Firefox may not have been run yet."
  exit 1
fi

# Extract the profile name (e.g., "9yjrrn6n.default")
PROFILE_NAME=$(basename "$SNAP_PROFILE_DIR")

# Create the symlink
ln -sf "$SNAP_PROFILE_DIR" ~/.mozilla/firefox/"$PROFILE_NAME"

echo "Successfully created symlink: ~/.mozilla/firefox/$PROFILE_NAME -> $SNAP_PROFILE_DIR"
