
e () {
    if [[ -n "$1" ]]; then
		nvim \
			--server /tmp/neovide.pipe \
			--remote \
			$([[ $1 =~ ^/ ]] && echo $1 || echo $(pwd)/$1)
    fi
}


sorc () {
	[ -r .sh ] && source .sh || source ~/.zshrc
}

chalice () {
	for i in {0..9}; do
		echo "$i -> $((5 + 3*i*i))"
	done
}
