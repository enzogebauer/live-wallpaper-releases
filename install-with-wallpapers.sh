#!/bin/bash
# Installs Live Wallpaper AND downloads the 20 wallpaper videos (about 900 MB).
#   curl -fsSL https://raw.githubusercontent.com/enzogebauer/live-wallpaper-releases/main/install-with-wallpapers.sh | bash
# It runs install.sh with the --wallpapers option, so you don't have to type the option yourself.
set -euo pipefail
curl -fsSL https://raw.githubusercontent.com/enzogebauer/live-wallpaper-releases/main/install.sh | bash -s -- --wallpapers
