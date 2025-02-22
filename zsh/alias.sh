
alias dmp="2>&1 >/dev/null"
alias nvim="nvim --listen ~/.cache/nvim/server.pipe"

alias weztitle="wezterm cli set-tab-title"

alias chalice="lua -e 'for i=0,9 do print(i .. \" -> \" .. (5 + 3*i*i)) end'"

alias sus="swaylock & sleep 2 && systemctl suspend"
alias e="setsid emacsclient --alternate-editor='' > /dev/null 2>&1"
alias ec="setsid emacsclient --alternate-editor='' --create-frame > /dev/null 2>&1"

alias open="gio open"
alias hs="http-server"

alias stl="systemctl"

alias pacss="pacman -Ss"
alias pacs="sudo pacman -S --needed"
alias pacr="sudo pacman -Rus"
alias yays="yay -S"

alias rum="gio trash"
alias mv="mv -i"
alias ls="ls -FH"
alias cpy=wl-copy
alias pst=wl-paste

alias lyr='bash ~/.local/scripts/lyrics.sh'
alias yt='lua ~/.local/scripts/yt.lua'
alias elaach="bash ~/.local/scripts/elaach.sh"
alias sam="lua ~/.local/scripts/sam.lua"

alias asciidoctor-pdf="/home/taki/.local/share/gem/ruby/3.0.0/bin/asciidoctor-pdf"
