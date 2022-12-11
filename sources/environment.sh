# ╔════════════════════════════════════════════════════╗
# ║                    Environment                     ║
# ╚════════════════════════════════════════════════════╝
export EDITOR=/usr/bin/nvim
export LNBIN=$HOME/.bin

if [[ "$PATH" =~ "$HOME/.bin" ]]; then; else; export PATH="$PATH:$HOME/.bin"; fi
if [[ "$PATH" =~ "$HOME/.scripts" ]]; then; else; export PATH="$PATH:$HOME/.scripts"; fi