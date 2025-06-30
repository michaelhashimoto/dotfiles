#!/bin/bash

for config_file in $(ls .config/)
do
	echo config_file=${config_file}

	echo "rm -rf ~/.config/${config_file}"

	rm -rf ~/.config/${config_file}

	echo "ln -s $(pwd)/.config/${config_file} ~/.config/${config_file}"

	ln -s $(pwd)/.config/${config_file} ~/.config/${config_file}
done