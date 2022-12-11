#!/bin/bash

__execp="$(basename $0)"
__usage=$( cat << EOM
Usage: LNBIN=/path/to/bin/folder $__execp <add|remove|list|rename> <executable> [optional name]

Description:
    Quick and easy symlinking. This script uses the LNBIN
    environment variable to store symbolic links to any 
    executable files you pass in as parameters.

    If you have a directory such as '~/.bin' in your path,
    you can set that to be your LNBIN and throw links to
    executables in there with ease.

Options:
	list [options]	  	-	  	passes options directly to "ls" command
	rename <from> <to>	-		renames a symlink
EOM
)

if [ -z "$LNBIN" ]
then
	echo "LNBIN env var not set. Please refer to usage for more info."
	echo ""
	lnbinc=""
elif [ -z "$LNBIN" ] || [ $# -eq 0 ]
then
	lnbinc=""
elif ! [ -d "$LNBIN" ]
then
	echo "LNBIN directory does not exist. Want to create it? (Y/n)"
	read -n 1 input
	if [ "$input" = "n" ] || [ "$input" = "N" ]
	then
		lnbinc=""
	else
		mkdir -p $LNBIN
		lnbinc=$1
	fi
else
	lnbinc=$1
fi

case $lnbinc in
	add)
		optionName=$(basename $2)
		if [ -n $3 ] 
		then 
			optionName=$3 
		fi
		ln -s $2 $LNBIN/$optionName
		;;
	remove)
		rm $LNBIN/$(basename $2)
		;;
	rename)
		mv $LNBIN/$(basename $2) $LNBIN/$3
		;;
	list)
		options=""
		if [ $# -eq 2 ] 
		then 
			options=$2 
		fi
		eval "ls $options $LNBIN"
		;;
	*)
		echo "$__usage"
		;;
esac
