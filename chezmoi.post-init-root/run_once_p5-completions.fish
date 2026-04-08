#!/usr/bin/env fish

echo
echo "🚀 Generating fish completions"
echo "─────────────────────────────────────────"

# fd
fd --gen-completions fish >~/.config/fish/completions/fd.fish
echo -e ""(set_color green)"✓"(set_color normal)" fd"
