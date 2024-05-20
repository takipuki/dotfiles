#alias ss="slurp | grim -g - - | wl-copy"
#alias nvr="nvr --remote-tab-silent"

alias sus="swaylock & sleep 2 && systemctl suspend"
alias e="setsid emacsclient --alternate-editor=''"
alias ec="setsid emacsclient --alternate-editor='' --create-frame"

alias open="gio open"
alias hs="http-server"

alias sctl="systemctl"

alias pacss="sudo pacman -Ss"
alias pacs="sudo pacman -S"
alias pacr="sudo pacman -Rus"
alias yays="yay -S"

alias rum="gio trash"
#alias rum="/usr/bin/rm"
alias mv="mv -i"
alias ls="ls -FH"
alias cpy=wl-copy
alias pst=wl-paste

alias sorc="source ~/.zshrc"

alias yt='COLUMNS=$COLUMNS lua ~/.local/script/yt.lua'
alias elaach="bash ~/.local/script/elaach.sh"
alias sam="bash ~/.local/script/sam.sh"

alias asciidoctor-pdf="/home/taki/.local/share/gem/ruby/3.0.0/bin/asciidoctor-pdf"
