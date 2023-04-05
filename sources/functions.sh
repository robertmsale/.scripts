# ╔════════════════════════════════════════════════════╗
# ║                     Functions                      ║
# ╚════════════════════════════════════════════════════╝
FUNCTIONS_LIST=("safe-delete-file" "math" "a" "sources" "xcode-run" "extract" "ls-functions" "profile-reload")

fizsh-reload () {
	source $HOME/.fizsh/.fizshrc
}

ls-functions () {
	echo $FUNCTIONS_LIST | sed 's/ /\n/g'
}

safe-delete-file () { # uses trash-cli, or regular old remove that does directories
	if which trash | grep -q -o 'not found'
	then
		if [[ -d "$1" ]]; then; /bin/rm -r $1
		else; /bin/rm $1; fi
	else
		trash $1
	fi
}
math () {
	echo $(( $@ ))
}
a () {
	lxc exec $1 -- bash
}

sources () {
	local __usage=$( cat << EOM
Usage: sources <add|remove|list|rename|edit> <source>

Description:
	Allows easy management of sources.

	Whenever you edit 

Options:
	list [options]	  	-	  	passes options directly to "ls" command
	rename <from> <to>	-		renames a symlink
EOM
)

	local command=$1
	if [ $command = "" ] | [ $command = "-h" ] | [ $command = "--help" ]
	then
		echo "$__usage"
		return 0
	fi
	case $command in
		add)
			touch $HOME/.sources
			;;
		remove)
			rm $HOME/.sources/$2
			;;
		list)
			local args=$@
			eval "ls ${args[@]:2} $HOME/.sources"
			;;
		rename)
			mv $HOME/.sources/$2 $HOME/.sources/$3
			;;
		edit)
			eval "$EDITOR $HOME/.sources/$2"
			profile-reload
			;;
	esac
}

function xcode-run {
	if [ $( uname ) != "Darwin" ]; then 
		echo This function is for Mac OS X only
		return
	fi
	$HOME/Library/Developer/Xcode/DerivedData/$( ls $HOME/Library/Developer/Xcode/DerivedData | grep $1 )/Build/Products/Debug/$@
}

function extract {
	if [ -z "$1" ]; then
    		# display usage if no parameters given
    		echo "Usage: extract ."
 	else
		if [ -f $1 ] ; then
        		# NAME=${1%.*}
        		# mkdir $NAME && cd $NAME
        		case $1 in
          			*.tar.bz2) tar xvjf ../$1 ;;
          			*.tar.gz) tar xvzf ../$1 ;;
          			*.tar.xz) tar xvJf ../$1 ;;
          			*.lzma) unlzma ../$1 ;;
          			*.bz2) bunzip2 ../$1 ;;
					*.rar) unrar x -ad ../$1 ;;
					*.gz) gunzip ../$1 ;;
					*.tar) tar xvf ../$1 ;;
					*.tbz2) tar xvjf ../$1 ;;
					*.tgz) tar xvzf ../$1 ;;
					*.zip) unzip ../$1 ;;
					*.Z) uncompress ../$1 ;;
					*.7z) 7z x ../$1 ;;
					*.xz) unxz ../$1 ;;
					*.exe) cabextract ../$1 ;;
					*) echo "extract: '$1' - unknown archive method" ;;
    			esac
		else
			echo "$1 - file does not exist"
    		fi
	fi
}

profile-reload() {
	source $RCFILE
}
