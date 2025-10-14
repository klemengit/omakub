#!/bin/bash

# Create temporary directory for venv
TEMP_VENV=$(mktemp -d)

# Cleanup function
cleanup() {
  if [ -d "$TEMP_VENV" ]; then
    rm -rf "$TEMP_VENV"
  fi
}

# Ensure cleanup on exit
trap cleanup EXIT

gum spin --spinner meter --title "Creating temporary virtual environment" -- \
  uv venv "$TEMP_VENV"

gum spin --spinner meter --title "Installing nidaqmx" -- \
  uv pip install --python "$TEMP_VENV/bin/python" nidaqmx

echo "Installing NI-DAQmx driver (requires sudo)..."
if sudo "$TEMP_VENV/bin/python" -m nidaqmx installdriver; then
  echo "✓ NI-DAQmx driver installation complete"
else
  echo "✗ Driver installation failed"
  exit 1
fi
