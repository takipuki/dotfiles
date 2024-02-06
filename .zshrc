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
bindkey -e
# End of lines configured by zsh-newuser-install

PROMPT="%F{#7287fd}%~%f"$'\n'"%F{#dd7878}> %f"

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export EDITOR=nvim
setopt HIST_IGNORE_ALL_DUPS

source $HOME/.zsh/alias.sh
source $HOME/.zsh/function.sh

source ~/.zsh/themes/catppuccin_latte-zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Created by `pipx` on 2023-12-09 12:18:40
#export PATH="$PATH:/home/taki/.local/bin"
