#!/bin/bash

echo "cp -f .dotfiles.zshrc ~/.dotfiles.zshrc"

cp -f .dotfiles.zshrc ~/.dotfiles.zshrc

grep -qxF 'source ~/.dotfiles.zshrc' ~/.zshrc || echo 'source ~/.dotfiles.zshrc' >> ~/.zshrc

for config_file in $(ls .config/)
do
	echo "rm -rf ~/.config/${config_file}"

	rm -rf ~/.config/${config_file}

	echo "ln -s $(pwd)/.config/${config_file} ~/.config/${config_file}"

	ln -s $(pwd)/.config/${config_file} ~/.config/${config_file}
done