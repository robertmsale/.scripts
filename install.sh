#!/bin/bash

if [ -e $HOME/.scripts/.DOTSCRIPTS_INSTALLED ]
then
	echo ".scripts already installed. Delete \"~/.scripts/.DOTSCRIPTS_INSTALLED\" if you want to run this tool again."
else
	touch $HOME/.scripts/.DOTSCRIPTS_INSTALLED
	if ! [ -d $HOME/.sources ]
	then
		echo "Making ~/.sources directory"
		mkdir $HOME/.sources
	fi
	echo "Removing existing sources in ~/.sources"
	for f in $(ls $HOME/.sources)
	do
		rm $HOME/.sources/$f
	done
	echo "Linking sources from ~/.scripts/sources into ~/.sources"
	for f in $(ls $HOME/.scripts/sources)
	do
		ln -s $HOME/.scripts/sources/$f $HOME/.sources/$f
	done
	INSTALL_RCFILE=""
	case $(basename $SHELL) in
		sh)
			INSTALL_RCFILE=".profile"
			;;
		bash)
			INSTALL_RCFILE=".bashrc"
			;;
		zsh)
			INSTALL_RCFILE=".zshrc"
			;;
		fizsh)
			INSTALL_RCFILE=".fizsh/.fizshrc"
			;;
		*)
			echo "Shell rc file could not be identified. Please enter path to rc file relative to home."
			echo "(i.e. ~/<your input>)"
			read INSTALL_RCFILE
			;;
	esac
	echo "Rc file set to $HOME/$INSTALL_RCFILE"
	if [ -e $HOME/$INSTALL_RCFILE ]
	then
		mv $HOME/$INSTALL_RCFILE $HOME/$INSTALL_RCFILE.bak
		echo "Backup of ~/$INSTALL_RCFILE stored as ~/$INSTALL_RCFILE.bak"
	fi
	echo "Linking $HOME/.scripts/shellrc to $HOME/$INSTALL_RCFILE"
	ln -s $HOME/.scripts/shellrc $HOME/$INSTALL_RCFILE

	if ! [ -d $HOME/.bin ]
	then
		echo "Creating $HOME/.bin folder"
		mkdir $HOME/.bin
	fi
	echo "Sourcing $INSTALL_RCFILE"
	source $HOME/$INSTALL_RCFILE
	echo "Linking scripts into $HOME/.bin"
	$HOME/.scripts/lnbin.sh add $HOME/.scripts/lnbin.sh lnbin
	lnbin add $HOME/.scripts/clip.sh clip
	lnbin add $HOME/.scripts/gen-path-add-string.sh gen-path-add-string
	lnbin add $HOME/.scripts/safe-add-to-path.sh safe-add-to-path

	echo "Listing links in $HOME/.bin"
	lnbin list -1

	echo "Environment successfully set up!"
fi