
rxp () {
	rnote-cli export doc --on-conflict overwrite -p -f pdf "$@"
}

e () {
	tab=
	if [[ $1 = "-t" ]]; then tab=-tab; shift 1; fi
	(nvim \
		--server /tmp/neovide.pipe \
		--remote$tab \
		"$(echo "$@" | sed -r 's/(\S+)/realpath \1/e')" 2>&1 > /dev/null &)
}

sorc () {
	[ -r .sh ] && source .sh || source ~/.zshrc
}

tmcp () {
	cd ~/Desktop/code/cp
	e -t main.cpp in.txt
	[ -z $TMUX ] && tmux a
	tmux splitw -d -v -l 35% 'zsh -c "make watch_deb; $SHELL"'
	sorc
}

chalice () {
	for i in {0..9}; do
		echo "$i -> $((5 + 3*i*i))"
	done
}
