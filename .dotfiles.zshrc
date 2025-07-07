#!/bin/zsh

# Change the default editor to neovim when changing files

export EDITOR=nvim
export VISUAL=nvim

# Install starship

eval "$(starship init zsh)"

# Configure kubectl autocomplete

if type kubectl &>/dev/null
then
	autoload -Uz compinit

	compinit

	source <(kubectl completion zsh)
fi

# Configure lazygit

alias lazygit="lazygit --use-config-dir ~/.config/lazygit"
alias lg="lazygit"