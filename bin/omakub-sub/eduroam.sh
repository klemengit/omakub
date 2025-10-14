#!/bin/bash

# URL of the Python script
SCRIPT_URL="https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=887&device=linux&generatedfor=user&openroaming=0"

# Download the script to a temporary file
TEMP_SCRIPT=$(mktemp --suffix=.py)

# Cleanup function
cleanup() {
  if [ -f "$TEMP_SCRIPT" ]; then
    rm -f "$TEMP_SCRIPT"
  fi
}

# Ensure cleanup on exit
trap cleanup EXIT

# Download the script
if gum spin --spinner meter --title "Downloading Python script" -- \
  curl -fsSL "$SCRIPT_URL" -o "$TEMP_SCRIPT"; then
  echo "✓ Download complete"
else
  echo "✗ Download failed"
  exit 1
fi

# Run the script
echo "Running Python script..."
if python3 "$TEMP_SCRIPT"; then
  echo "✓ Script execution complete"
else
  echo "✗ Script execution failed"
  exit 1
fi
