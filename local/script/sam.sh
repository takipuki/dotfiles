#! /bin/bash

sam_url="$(echo $1 | grep -Eo '172.16.50.[0-9]+')"

echo '#EXTM3U'
curl -s $1 |
  htmlq 'td a' |
  grep -Eo 'href="([^."]+)' |
  grep 'Season' |
  sed 's/href="//' |
  while read -r line; do
    curl -s $sam_url$line |
      grep -Eo '<a href="[^"]+\.(mp4|mkv)' |
      sed 's/<a href="/http:\/\/'$sam_url'/' |
      sed -E 's/^.*([sS][0-9]+[^ ]*[eE][0-9]+).*/#EXTINF:-1,\1\n\0/'
  done

