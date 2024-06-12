#! /usr/bin/bash

usage () { echo "Usage: $0 [url] [-s query]"; exit 1; }
# if [[ $# -lt 1 || $# -gt 2 ]]; then
#   usage
# fi

digit='http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%98%85%20%200%20%20%E2%80%94%20%209/'
a_l='http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A5%20%20A%20%20%E2%80%94%20%20L/'
m_r='http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A6%20%20M%20%20%E2%80%94%20%20R/'
s_z='http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A6%20%20S%20%20%E2%80%94%20%20Z/'
kdrama='http://172.16.50.14/DHAKA-FLIX-14/KOREAN%20TV%20%26%20WEB%20Series/'
stdout='/dev/stdout'

scrape_one () {
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
}

scrape_list () {
  sam_url="$(echo $1 | grep -Eo '172.16.50.[0-9]+')"
  both=$(
    curl -s $1 |
      htmlq '.fb-n > a' |
      sed '1d' |
      sed -E 's|.*"([^"]+)">([^<]+)<.*|\1\t\2|'
  )
  get=$(echo "$both" | awk -F$'\t' '{print NR, $2}' | fzf | awk '{print $1}')
  scrape_one $sam_url$(echo "$both" | awk -F$'\t' '{print $1}' | sed $get'q;d')
}

while getopts ":s:o:k" o; do
  case "${o}" in
    s)
      query=${OPTARG}
      ;;
    o)
      stdout=${OPTARG}
      ;;
    k)
      kd=y
      ;;
    *)
      usage
      ;;
  esac
done

shift $((OPTIND-1))

if [[ -n $1 ]]; then
  scrape_one $1 > $stdout
  exit 0
fi

c=${query:0:1}
if [[ -n $kd ]]; then
  scrape_list $kdrama
elif [[ $c =~ [0-9] ]]; then
  scrape_list $digit
elif [[ $c =~ [a-l] ]]; then
  scrape_list $a_l
elif [[ $c =~ [m-r] ]]; then
  scrape_list $m_r
else
  scrape_list $s_z
fi > $stdout
