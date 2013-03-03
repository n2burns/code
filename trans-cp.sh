#!/bin/sh

#trans-cp.sh - copy completed torrents to another dir, so they can continue to seed in the original
# from https://forum.transmissionbt.com/viewtopic.php?f=2&t=10593#p49318

if [ -e "$TR_TORRENT_DIR/$TR_TORRENT_NAME" ]; then
  cp -R "$TR_TORRENT_DIR/$TR_TORRENT_NAME" "/home/n2burns/dlTor/finished/" 2>/dev/null
fi
