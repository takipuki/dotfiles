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

bindkey -M isearch '^R' history-incremental-search-backward
bindkey -M isearch '^S' history-incremental-search-forward

compdef -d java

PROMPT="%F{#7287fd}%~%f"$'\n'"%F{#dd7878}> %f"

_fix_cursor() {
   echo -ne '\e[5 q'
}
# precmd_functions+=(_fix_cursor)


[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

bindkey -e
export EDITOR=nvim
setopt HIST_IGNORE_ALL_DUPS

precmd() {
    if [[ `pwd` != $HOME && -f '.zshrc' ]]; then
        source .zshrc
    fi
}

source $HOME/.zsh/alias.sh
source $HOME/.zsh/function.sh

source ~/.zsh/themes/catppuccin_latte-zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Created by `pipx` on 2023-12-09 12:18:40
#export PATH="$PATH:/home/taki/.local/bin"

# Created by `pipx` on 2024-05-26 21:09:23
export PATH="$PATH:/home/taki/.dotfiles/local/bin"
