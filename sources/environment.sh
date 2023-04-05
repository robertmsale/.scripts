# ╔════════════════════════════════════════════════════╗
# ║                    Environment                     ║
# ╚════════════════════════════════════════════════════╝
export EDITOR=/usr/bin/nvim
export LNBIN=$HOME/.bin
export CHROME_EXECUTABLE="/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"

if [[ "$PATH" =~ "$HOME/.bin" ]]; then; else; export PATH="$PATH:$HOME/.bin"; fi
if [[ "$PATH" =~ "/usr/local/bin" ]]; then; else; export PATH="$PATH:/usr/local/bin"; fi
if [[ "$PATH" =~ "$HOME/.scripts" ]]; then; else; export PATH="$PATH:$HOME/.scripts"; fi
if [[ "$PATH" =~ ".dotnet/tools" ]]; then; else; PATH="$PATH:$HOME/.dotnet/tools"; fi
if [[ "$PATH" =~ "/usr/local/share/dotnet" ]]; then; else; PATH="$PATH:/usr/local/share/dotnet"; fi
if [[ "$PATH" =~ "/opt/homebrew/opt/openjdk@17/bin" ]]; then; else; export PATH="$PATH:/opt/homebrew/opt/openjdk@17/bin"; fi

