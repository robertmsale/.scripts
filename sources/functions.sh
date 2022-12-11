# ╔════════════════════════════════════════════════════╗
# ║                     Functions                      ║
# ╚════════════════════════════════════════════════════╝
safe-delete-file () {
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

#	additional sources
