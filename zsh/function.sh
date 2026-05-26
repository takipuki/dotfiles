
clipstart () {
	f=/dev/shm/clip
	cat > $f
	htl keyword bindn "CTRL, V, execr, (head -n 1 $f | wl-copy) && sed -i 1d $f"
}

clipend() {
	htl keyword unbind 'CTRL, V'
}

e () {
	tab=
	if [[ $1 = "-t" ]]; then tab=-tab; shift 1; fi
	(nvim \
		--server /tmp/neovide.pipe \
		--remote$tab \
		"$(echo "$@" | sed -E 's/(\S+)/realpath \1/e')" 2>&1 > /dev/null &)
}

sorc () {
	[ -r .sh ] && source .sh || source ~/.zshrc
}

tmcp () {
	cd ~/Desktop/code/cp
	nvim --server /tmp/neovide.pipe \
		--remote-send "<esc>:e $(realpath main.cpp) | so .vim<cr>"
	[ -z $TMUX ] && tmux a
	tmux splitw -d -v -l 35% 'zsh -c "make watch_deb; $SHELL"'
	sorc
}

rxp () {
	rnote-cli export doc --on-conflict overwrite -p -f pdf "$@"
}

chalice () {
	for i in {0..9}; do
		echo "$i -> $((5 + 3*i*i))"
	done
}
