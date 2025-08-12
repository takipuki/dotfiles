
e () {
	tab=
	if [[ $1 = "-t" ]]; then tab=-tab; shift 1; fi
	for arg in $@; do
		(nvim \
			--server /tmp/neovide.pipe \
			--remote$tab \
			$([[ $arg =~ ^/ ]] && echo $arg || echo $(pwd)/$arg) 2>&1 > /dev/null &)
	done
}

sorc () {
	[ -r .sh ] && source .sh || source ~/.zshrc
}

tmcp () {
	cd ~/Desktop/code/cp
	e -t main.cpp in.txt in.sh
	tmux splitw -d -v -l 35% 'zsh -c "make watch_deb; $SHELL"'
	sorc
}

chalice () {
	for i in {0..9}; do
		echo "$i -> $((5 + 3*i*i))"
	done
}
