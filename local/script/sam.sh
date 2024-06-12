#! /usr/bin/bash

ex () {
  echo ctrl_c
  [ -f .sam_tmp ] && rm .sam_tmp
  exit 1
}
trap ex SIGINT

a_0_9="http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%98%85%20%200%20%20%E2%80%94%20%209/"
a_a_f="http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A5%20%20A%20%20%E2%80%94%20%20F/"
a_g_m="http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A5%20%20G%20%20%E2%80%94%20%20M/"
a_n_s="http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A6%20%20N%20%20%E2%80%94%20%20S/"
a_t_z="http://172.16.50.9/DHAKA-FLIX-9/Anime%20%26%20Cartoon%20TV%20Series/Anime-TV%20Series%20%E2%99%A6%20%20T%20%20%E2%80%94%20%20Z/"
k="http://172.16.50.14/DHAKA-FLIX-14/KOREAN%20TV%20%26%20WEB%20Series/"
t_0_9="http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%98%85%20%200%20%20%E2%80%94%20%209/"
t_a_l="http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A5%20%20A%20%20%E2%80%94%20%20L/"
t_m_r="http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A6%20%20M%20%20%E2%80%94%20%20R/"
t_s_z="http://172.16.50.12/DHAKA-FLIX-12/TV-WEB-Series/TV%20Series%20%E2%99%A6%20%20S%20%20%E2%80%94%20%20Z/"

c=$(
cat << EOM | fzf || exit 1
anime
kdrama
tv
movies
EOM
)
[ $? == 1 ] && exit 1

case $c in
  anime)
    c=$(echo {a..z} | sed 's/ /\n/g' | fzf || exit 1)
    [ $? == 1 ] && exit 1
    case $c in
      [0-9]) url=$a_0_9 ;;
      [a-f]) url=$a_a_f ;;
      [g-m]) url=$a_g_m ;;
      [n-s]) url=$a_n_s ;;
      [t-z]) url=$a_t_z ;;
    esac
    ;;

  kdrama)
    url=$k
    ;;

  tv)
    c=$(echo {a..z} | sed 's/ /\n/g' | fzf || exit 1)
    [ $? == 1 ] && exit 1
    case $c in
      [0-9]) url=$a_0_9 ;;
      [a-f]) url=$a_a_f ;;
      [g-m]) url=$a_g_m ;;
      [n-s]) url=$a_n_s ;;
      [t-z]) url=$a_t_z ;;
    esac
    ;;

  movies)
    c=$(seq 1995 `date +%Y` | sed 's/ /\n/g' | fzf)
    [ $? == 1 ] && exit 1
    url='http://172.16.50.14/DHAKA-FLIX-14/English%20Movies%20%281080p%29/%28'$c'%29%201080p/'
    ;;
esac

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
  get=$(echo "$both" | awk -F$'\t' '{print NR, $2}' | fzf || exit 1)
  [ $? == 1 ] && exit 1
  get=$(echo $get | awk '{print $1}')
  scrape_one $sam_url$(echo "$both" | awk -F$'\t' '{print $1}' | sed $get'q;d') > .sam_tmp &
  echo -n 'filename: '
  read -r f
  mv .sam_tmp $f.m3u
}

scrape_list $url
