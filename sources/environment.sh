# ╔════════════════════════════════════════════════════╗
# ║                    Environment                     ║
# ╚════════════════════════════════════════════════════╝
export EDITOR=/usr/bin/nvim
export LNBIN=$HOME/.bin

if [[ "$PATH" =~ "$HOME/.bin" ]]; then; else; export PATH="$PATH:$HOME/.bin"; fi
if [[ "$PATH" =~ "$HOME/.scripts" ]]; then; else; export PATH="$PATH:$HOME/.scripts"; fi
if [[ "$PATH" =~ ".dotnet/tools" ]]; then; else; PATH="$PATH:$HOME/.dotnet/tools"; fi
if [[ "$PATH" =~ "/usr/local/share/dotnet" ]]; then; else; PATH="$PATH:/usr/local/share/dotnet"; fi