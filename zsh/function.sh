
# alias neovide="neovide -- --listen /tmp/nvimsocket"
function nvr () {
    if [[ -n $1 ]]
    then
        /bin/nvim --server ~/.cache/nvim/server.pipe --remote-tab `pwd`/$1
    fi
}

function rex () {
	printf '\033[0;31m'
	sed -E 's/^('$1')$/\x1b[0;32m\0\x1b[0;31m/'
	printf '\033[0m'
}

# function nvim () {
# 	/bin/nvim --listen ~/.cache/nvim/server.pipe $@
# 	echo -ne '\033[6 q'
# }

# function tm_cp () {
# 	tmux new-window 'cd ~/Desktop/code/cp/ && nvim main.cpp'
# 	tmux split-window -h -c '/home/taki/Desktop/code/cp/'
# 	tmux select-pane -t 0
# 	tmux rename-window cp
# 	tmux resize-pane -x 60%
# }

#
# function uv () {
#     sudo undervolt --core -$1 --cache -$1 --gpu -$1
# }
#
# function batset () {
#     echo ${1:-60} | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
# }
