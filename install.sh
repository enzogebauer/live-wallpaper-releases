#!/bin/bash
# Installs Live Wallpaper on macOS.
#
#   curl -fsSL https://raw.githubusercontent.com/enzogebauer/live-wallpaper-releases/main/install.sh | bash
#   ...add  -s -- --wallpapers  after "bash" to also download the 20 wallpaper videos.
#
# Why a script: files downloaded in a browser get a "quarantine" flag, and macOS then refuses to open
# apps that aren't notarized by Apple. Files fetched with curl don't get the flag, so the app just opens.
set -euo pipefail

REPO="enzogebauer/live-wallpaper-releases"
VERSION="0.0.2"
DMG="Live-Wallpaper-$VERSION.dmg"
DMG_SHA256="8f826b544022756f251c531a9eebaf4dc65499bcd8fe168e7049d0a0393d5c7a"
WALLPAPERS_SHA256="99452bdf361e7a0f66181fe2a951ad770821133badf7bd8859c921939f2411e8"
APP_NAME="Live Wallpaper.app"
INSTALL_DIR="${INSTALL_DIR:-/Applications}"
# Movies isn't one of the folders macOS protects, so neither this script nor the app triggers a
# permission prompt. (Documents, Desktop and Downloads are protected.)
VIDEOS_DIR="${VIDEOS_DIR:-$HOME/Movies/Live Wallpaper}"
BASE="https://github.com/$REPO/releases/download/v$VERSION"

WALLPAPERS=0
for arg in "$@"; do
  if [ "$arg" = "--wallpapers" ]; then WALLPAPERS=1; fi
done

say() { printf '\033[1m==>\033[0m %s\n' "$*"; }
die() { printf '\033[31mError:\033[0m %s\n' "$*" >&2; exit 1; }

[ "$(uname)" = "Darwin" ] || die "This installer is for macOS."
[ "$(sw_vers -productVersion | cut -d. -f1)" -ge 13 ] || die "Live Wallpaper needs macOS 13 or later."

TMP=$(mktemp -d)
MOUNT="$TMP/mnt"
cleanup() { hdiutil detach -quiet "$MOUNT" 2>/dev/null || true; rm -rf "$TMP"; }
trap cleanup EXIT

say "Downloading Live Wallpaper $VERSION"
curl -fL --progress-bar -o "$TMP/$DMG" "$BASE/$DMG"
echo "$DMG_SHA256  $TMP/$DMG" | shasum -a 256 -c - >/dev/null || die "The download is corrupted (checksum mismatch). Nothing was installed."

# Normal users can write to /Applications; if not, use ~/Applications.
mkdir -p "$INSTALL_DIR" 2>/dev/null || true
if [ ! -w "$INSTALL_DIR" ]; then
  INSTALL_DIR="$HOME/Applications"
  mkdir -p "$INSTALL_DIR"
fi

say "Installing to $INSTALL_DIR"
mkdir -p "$MOUNT"
hdiutil attach -nobrowse -noverify -quiet -mountpoint "$MOUNT" "$TMP/$DMG"
pkill -x LiveWallpaper 2>/dev/null || true       # update in place if it is already running
rm -rf "$INSTALL_DIR/$APP_NAME"
cp -R "$MOUNT/$APP_NAME" "$INSTALL_DIR/"
xattr -dr com.apple.quarantine "$INSTALL_DIR/$APP_NAME" 2>/dev/null || true

mkdir -p "$VIDEOS_DIR"

if [ "$WALLPAPERS" = "1" ]; then
  say "Downloading the wallpapers (about 900 MB, this takes a few minutes)"
  curl -fL --progress-bar -o "$TMP/Wallpapers.zip" "$BASE/Wallpapers.zip"
  echo "$WALLPAPERS_SHA256  $TMP/Wallpapers.zip" | shasum -a 256 -c - >/dev/null || die "The wallpapers download is corrupted. The app is installed; the videos are not."
  unzip -q "$TMP/Wallpapers.zip" -d "$TMP/videos"
  for f in "$TMP/videos/wallpapers/"*.mp4; do
    [ -e "$VIDEOS_DIR/$(basename "$f")" ] || mv "$f" "$VIDEOS_DIR/"     # never overwrites a file you already have
  done
  say "Wallpapers are in $VIDEOS_DIR"
fi

# Point the app at that folder, unless you already chose one.
if [ -z "${NO_DEFAULTS:-}" ] && ! defaults read dev.local.livewallpaper folderPath >/dev/null 2>&1; then
  defaults write dev.local.livewallpaper folderPath "$VIDEOS_DIR"
fi

say "Done."
if [ -z "${NO_OPEN:-}" ]; then
  open "$INSTALL_DIR/$APP_NAME"
  echo "Your videos folder: $VIDEOS_DIR  (you can also drop videos onto the Library tab)"
fi
