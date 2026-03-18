# Created by newuser for 5.9

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/taki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
setopt nobeep
# End of lines configured by zsh-newuser-install

compdef -d java

PROMPT="%F{#7287fd}%~%f"$'\n'"%F{#dd7878}> %f"

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

bindkey -e
export EDITOR=nvim
setopt HIST_IGNORE_ALL_DUPS
setopt interactivecomments

source $HOME/.zsh/alias.sh
source $HOME/.zsh/function.sh

source ~/.zsh/themes/catppuccin_latte-zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_FZF_HISTORY_SEARCH_END_OF_LINE=1
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_FZF_ARGS='+m --preview-window=hidden'
source ~/.zsh/zsh-fzf-history-search.zsh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

export PATH="$PATH:/home/taki/.local/scripts:/home/taki/.local/bin:"
export MPD_HOST="/home/taki/.local/share/mpd/socket"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
  tmux new-session
fi
