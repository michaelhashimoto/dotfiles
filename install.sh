#!/bin/bash

echo "rm -fr ~/.dotfiles.zshrc"

rm -fr ~/.dotfiles.zshrc

echo "ln -s $(pwd)/.dotfiles.zshrc ~/.dotfiles.zshrc"

ln -s $(pwd)/.dotfiles.zshrc ~/.dotfiles.zshrc

grep -qxF 'source ~/.dotfiles.zshrc' ~/.zshrc || echo 'source ~/.dotfiles.zshrc' >> ~/.zshrc

for config_file in $(ls .config/)
do
	echo "rm -rf ~/.config/${config_file}"

	rm -rf ~/.config/${config_file}

	echo "ln -s $(pwd)/.config/${config_file} ~/.config/${config_file}"

	ln -s $(pwd)/.config/${config_file} ~/.config/${config_file}
done