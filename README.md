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

### The easy way: one line in Terminal (no warnings)
Open **Terminal** (press ⌘ Space, type "Terminal", press Return), paste this line and press Return:

```sh
curl -fsSL https://raw.githubusercontent.com/enzogebauer/live-wallpaper-releases/main/install.sh | bash
```

To also download the 20 wallpaper videos (about 900 MB), use this one instead:

```sh
curl -fsSL https://raw.githubusercontent.com/enzogebauer/live-wallpaper-releases/main/install-with-wallpapers.sh | bash
```

It installs Live Wallpaper into Applications and opens it. If macOS asks for access to your Documents folder, click **Allow**. This route avoids the "Apple could not verify…" warning that appears when you download the app in a browser, because that warning only applies to files downloaded by a browser. You can read the scripts before running them: [install.sh](install.sh) and [install-with-wallpapers.sh](install-with-wallpapers.sh).

### The drag-and-drop way
1. Download `Live-Wallpaper-….dmg` from the release and open it. Drag **Live Wallpaper** onto the **Applications** folder in the window that appears.
2. Eject the disk image and open Live Wallpaper from Applications.
3. The first launch is blocked because the app isn't notarized by Apple. Click **Done**, open **System Settings → Privacy & Security**, scroll down and click **Open Anyway**. You only need to do this once.
4. Put your videos in `~/Documents/wallpapers` (or choose another folder in Settings) and click **Allow** when it asks for access to the Documents folder. You can also drop `.mp4`, `.mov` or `.m4v` files onto the Library tab.

The release also has an optional `Wallpapers.zip` with 20 videos to start with.

Requires macOS 13 or later, Apple Silicon or Intel.

## Notes
- This is a personal, non-commercial project shared with friends. It isn't for sale.
- The starter-pack videos are third-party content provided for personal use. Please don't redistribute them.
- The source code is not published in this repository.
