# .scripts
This repo is a mashup of shell scripts I use on a regular basis. Made the repo public because perhaps people will find some of the scripts useful.

## Install
I scaffold my home folder like so:

- ~/.scripts
- ~/.sources
- ~/.bin

This repo is the `~/.scripts` folder, and `~/.sources` is a symbolic link to `~/.scripts/sources`. My shell profile treats the `~/.sources` directory the same way systemd treats `.d` folders (or how nginx separates `sites-available` and `sites-enabled`). Any file you would like to source, simply put it in `~/.sources` and your bash/zsh/fizsh/etc shell will load every file in that directory. If you would like this functionality I've provided a `install.sh` script to simplify the setup process.

## Tools

### clip
```text
Usage: clip.sh [-h|--help]

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
	cat somefile.txt | clip.sh
	echo hello world! | clip.sh
	clip.sh < somefile.txt
```

### gen-path-add-string
```text

Usage: gen-path-add-string <...paths>

Description:
    Generates a string that can be used in shell source profiles
    to safely add a path to the PATH environment variable.

    If you were to source the same file twice, sometimes PATH 
    starts growing duplicate entries. The string generated by this
    script ensures no duplicate paths are being added.

    You can pipe the output directly to a source file or to clipboard
    for pasting into a source file of your choice.

Example:
	gen-path-add-string $HOME/.bin
		outputs: "if [[ "$PATH" =~ "$HOME/.bin" ]]; then; else; PATH="$PATH:$HOME/.bin"; fi"
```

This utility helps me because I edit my sources fairly often, and if you reload the source multiple times, and that source happens to append to the `$PATH` environment variable, it can be absolute bedlam. This generates a line of shell script that uses a regular expression to determine whether the specific path is already in `$PATH`, and if not it appends. I use this as a safe way to add to path in my sources.

### lnbin
```text
Usage: LNBIN=/path/to/bin/folder lnbin <add|remove|list|rename> <executable> [optional name]

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
```

I personally like to keep installed packages separate from applications I build from source in my home folder. This tool creates and manages symbolic links between stuff I compile and one of my bin folders in `$PATH`. The list command lets you pass in any optional parameters you can pass into `ls`. For this to work all you have to do is set the `LNBIN` environment variable and start throwing links into that directory with this tool. I switch between Windows and \*nix OSs fairly frequently and because `mklink` and `ln` targets and sources are flip-flopped I get them mixed up regularly. This tool abstracts away the `target` parameter.

## Bonus content

I keep my *extremely basic* `tmux.conf` here and some of my quick provisioning scripts in the `provisioning` directory. 