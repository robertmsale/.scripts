#!/bin/bash

__execp="$(basename $0)"
__usage="
Usage: $__execp <...paths>

Description:
    Generates a string that can be used in shell source profiles
    to safely add a path to the PATH environment variable.

    If you were to source the same file twice, sometimes PATH 
    starts growing duplicate entries. The string generated by this
    script ensures no duplicate paths are being added.

    You can pipe the output directly to a source file or to clipboard
    for pasting into a source file of your choice.

Example:
	$__execp \$HOME/.bin
		outputs: \"if [[ \"\$PATH\" =~ \"\$HOME/.bin\" ]]; then; else; PATH=\"\$PATH:\$HOME/.bin\"; fi\"
"

if [[ -z $1 ]] # check if no arguments were passed and print usage
then
	echo "$__usage"
else
	args=("$@")
	retval=""
	for n in "${args[@]}" # loop through args
	do
		retval="$retval|if [[ \"\$PATH\" =~ \"$n\" ]]; then; else; export PATH=\"\$PATH:$n\"; fi"
	done
	retval="${retval:1}"
	retval="$(echo $retval | sed 's/|/\n/g')"
	echo "$retval" # pass result to standard output
fi


