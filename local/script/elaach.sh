#! /bin/bash

echo '#EXTM3U'
curl -s $(wl-paste) -o - | sed -E 's/\s*<td><a href="([^"]+)".*/\1/' | grep '^h' | sed -E 's/^.*([sS][0-9]+[^ ]*[eE][0-9]+).*/#EXTINF:-1,\1\n\0/'
