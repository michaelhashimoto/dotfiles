#!/bin/bash

for blah in $(find .config/)
do
	if [[ "${blah}" == ".config/" ]]
	then
		continue;
	elif [[ -d ${blah} ]]
	then
		echo "rm -rf ~/${blah}"

		rm -rf ~/${blah}

		echo "mkdir -p ~/${blah}"

		mkdir -p ~/${blah}
	else
		echo "cp ${blah} ~/${blah}"

		cp ${blah} ~/${blah}
	fi
done