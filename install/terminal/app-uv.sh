#!/bin/bash

gum spin --spinner meter --title "Installing uv" -- \
  curl -LsSf https://astral.sh/uv/install.sh | sh
