# Live Wallpaper

A small macOS menu-bar app that plays looping videos as your desktop wallpaper.

**[Download the latest release →](../../releases/latest)**

## Features
- Looping video on every display, with playlists, shuffle and timed rotation
- A different video, playlist or fixed clip per display
- Dock icon or menu-bar only
- Library tab: drag videos in, search, rename, move to Trash
- Pauses on battery, in Low Power Mode, when hot, when locked, and when the desktop is covered
- Lock screen shows a still frame of the video (macOS can't play video on the lock screen)

## Install
1. Download `Live-Wallpaper-…-macOS.zip` from the release, unzip it and drag **Live Wallpaper** to Applications.
2. The app isn't notarized by Apple, so the first launch is blocked. Open **System Settings → Privacy & Security** and click **Open Anyway**. If macOS says the app is damaged, run `xattr -dr com.apple.quarantine "/Applications/Live Wallpaper.app"` once.
3. Put your videos in `~/Documents/wallpapers` (or choose another folder in Settings) and allow access to the Documents folder when asked. You can also drop `.mp4`, `.mov` or `.m4v` files onto the Library tab.

The release also has an optional `Wallpapers.zip` with 20 videos to start with.

Requires macOS 13 or later, Apple Silicon or Intel.

## Notes
- This is a personal, non-commercial project shared with friends. It isn't for sale.
- The starter-pack videos are third-party content provided for personal use. Please don't redistribute them.
- The source code is not published in this repository.
