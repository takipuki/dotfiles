
alias neovide="neovide -- --listen /tmp/nvimsocket"
#function nvr () {
#    if [[ -n $1 ]]
#    then
#        nvim --server ~/.cache/nvim/server.pipe --remote-tab `pwd`/$1
#    fi
#}

function yt-video () {
    #echo '"'$*'"'
    local OPTIND option
    getopts ":l:" option
    case $option in
        l)
            yt-dlp -q -o - $OPTARG | mpv -
            ;;
        *)
            for query in $@
            do
                yt-dlp -q -o - ytsearch:'"'$query'"' | mpv -
            done
            ;;
    esac
}

function uv () {
    sudo undervolt --core -$1 --cache -$1 --gpu -$1
}

function batset () {
    echo ${1:-60} | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
}
