#alias ss="slurp | grim -g - - | wl-copy"
alias nvim="nvim --listen ~/.cache/nvim/server.pipe"

alias chalice="lua -e 'for i=0,9 do print(i .. \" -> \" .. (5 + 3*i*i)) end'"

alias sus="swaylock & sleep 2 && systemctl suspend"
alias e="setsid emacsclient --alternate-editor='' > /dev/null 2>&1"
alias ec="setsid emacsclient --alternate-editor='' --create-frame > /dev/null 2>&1"

alias open="gio open"
alias hs="http-server"

alias sctl="systemctl"

alias pacss="pacman -Ss"
alias pacs="sudo pacman -S --needed"
alias pacr="sudo pacman -Rus"
alias yays="yay -S"

alias rum="gio trash"
#alias rum="/usr/bin/rm"
alias mv="mv -i"
alias ls="ls -FH"
alias cpy=wl-copy
alias pst=wl-paste

alias sorc="source ~/.zshrc"

alias yt='lua ~/.local/script/yt.lua'
alias elaach="bash ~/.local/script/elaach.sh"
alias sam="lua ~/.local/script/sam.lua"

alias asciidoctor-pdf="/home/taki/.local/share/gem/ruby/3.0.0/bin/asciidoctor-pdf"
