
alias sudo="sudo "

alias dmp="2>&1 >/dev/null"

alias sus="swaylock & sleep 2 && systemctl suspend"
# alias e="setsid emacsclient --alternate-editor='' > /dev/null 2>&1"
# alias ec="setsid emacsclient --alternate-editor='' --create-frame > /dev/null 2>&1"

alias open="gio open"
alias hs="http-server"

alias stl="systemctl"
alias htl="hyprctl"

alias pacss="pacman -Ss"
alias pacs="sudo pacman -S --needed"
alias pacr="sudo pacman -Rus"
alias pacrr="sudo pacman -Qtdq | sudo pacman -Rns -"

alias rm="gio trash"
alias mv="mv -i"
alias cp="cp -i"
alias ls="ls -FH"
alias feh="feh -.Z"
alias cpy=wl-copy
alias pst=wl-paste
alias psti="wl-paste -t image"
alias nvip="nvim --noplugin -i NONE --cmd 'set noswapfile nobackup'"
alias sc-im="sc-im --autocalc"
alias php="/opt/lampp/bin/php"
alias yay="MAKEFLAGS=--jobs=$(nproc) yay"
alias icat="kitten icat"

alias asciidoctor-pdf="/home/taki/.local/share/gem/ruby/3.0.0/bin/asciidoctor-pdf"
