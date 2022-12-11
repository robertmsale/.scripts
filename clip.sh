#!/bin/bash

__execp="$(basename $0)"
__usage="
Usage: $__execp [-h|--help]

Description:
    Takes standard input and copies it to clipboard.

    Uses any of the following cli tools:
    	- xsel     : Linux tool for working with clipboard
    	- xclip    : Another Linux tool
    	- pbcopy   : MacOS tool
    	- wl-copy  : Linux Wayland clipboard tool
    	- clip.exe : Windows clipboard tool (works with WSL)

    If none of those CLI tools are available this script wont work.
    On Linux you may have to install xsel, xclip, or wl-copy.

Examples:
	cat somefile.txt | $__execp
	echo hello world! | $__execp
	$__execp < somefile.txt
"


if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
	echo "$__usage"
	exit 0
else
	toclip=$(cat -)
fi

if ! [[ "$(which pbcopy)" =~ " not found" ]]
then
	eval "echo -n \"$toclip\" | pbcopy"
elif ! [[ "$(which xsel)" =~ " not found" ]]
then
	eval "echo -n \"$toclip\" | xsel -ib"
elif ! [[ "$(which xclip)" =~ " not found" ]]
then
	eval "echo -n \"$toclip\" | xclip -sel clip"
elif ! [[ "$(which wl-copy)" =~ " not found" ]]
then
	eval "echo -n \"$toclip\" | wl-copy"
elif ! [[ "$(which clip.exe)" =~ " not found" ]]
then
	eval "echo -n \"$toclip\" | clip.exe"
else
	echo "No clipboard tools could be found. Please refer to usage for more info."
	echo ""
	echo $__usage
fi