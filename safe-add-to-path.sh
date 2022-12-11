#!/bin/bash

__execp="$(basename $0)"
__usage=$(cat << EOM
Usage: $__execp <...paths>

Description:
    This script generates the string used to set the PATH variable,
    taking into account what is already inside PATH.

    This ensures the PATH variable does not get cluttered with
    duplicate entries (i.e. sourcing the same file twice).

    The new PATH variable is passed to standard output.

Examples:
    single path    -           $__execp /usr/bin
    multiple paths -           $__execp /usr/bin \$HOME/.cargo/bin
EOM
)

if [[ -z $1 ]] # check if no arguments were passed and print usage
then
	echo "$__usage"
else
	args=("$@") # create args array
	newPath="$PATH" # create separate path var for manipulation
	for n in "${args[@]}" # loop through args
	do
		if [[ $newPath =~ "$n" ]] # if path contains one of the args
		then # do nothing
			touch /dev/null 
		else # otherwise add to new path
			newPath="$newPath:$n"
		fi
	done

	echo "$newPath" # pass result to standard output
fi

