#! /bin/bash

sam_url="$(wl-paste | grep -Eo '172.16.50.[0-9]+')"

echo '#EXTM3U'
curl -s $(wl-paste) | grep -Eo '<a href="[^"]+\.(mp4|mkv)' | sed 's/<a href="/http:\/\/'$sam_url'/' | sed -E 's/^.*([sS][0-9]+[^ ]*[eE][0-9]+).*/#EXTINF:-1,\1\n\0/'
