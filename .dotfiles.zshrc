#!/bin/zsh

eval "$(starship init zsh)"

alias lazygit="lazygit --use-config-dir ~/.config/lazygit"

if type kubectl &>/dev/null; then
	source <(kubectl completion zsh)
fi