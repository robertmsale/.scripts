# ╔════════════════════════════════════════════════════╗
# ║                        Init                        ║
# ╚════════════════════════════════════════════════════╝

# change this to your shell's rc file or make it empty to let the
# system decide based on your login shell
export RCFILE=""
if [ -z $RCFILE ]
then
	GSH=$(basename $SHELL)
	case $GSH in
		sh)
			export RCFILE="$HOME/.profile"
			;;
		bash)
			export RCFILE="$HOME/.bashrc"
			;;
		zsh)
			export RCFILE="$HOME/.zshrc"
			;;
		fizsh)
			export RCFILE="$HOME/.fizsh/.fizshrc"
			;;
		*)
			echo "RCFile not set. Function \"profile-reload\" will not work without it."
			echo "Set RCFile in ~/.sources/init.sh"
			;;
	esac
fi

# RCFILE is used by profile-reload to properly reload your sources 