#!/usr/bin/env fish

echo
echo "🚀 Generating fish completions"
echo "─────────────────────────────────────────"

# bat
bat --completion fish >~/.config/fish/completions/bat.fish
echo -e ""(set_color green)"✓"(set_color normal)" bat"

# docker
docker completion fish >~/.config/fish/completions/docker.fish
echo -e ""(set_color green)"✓"(set_color normal)" docker"

# eza
wget -o ~/.config/fish/completions/eza.fish -q https://github.com/eza-community/eza/blob/main/completions/fish/eza.fish
echo -e ""(set_color green)"✓"(set_color normal)" eza"

# fd
fd --gen-completions fish >~/.config/fish/completions/fd.fish
echo -e ""(set_color green)"✓"(set_color normal)" fd"

# fnm
fnm completions --shell fish >~/.config/fish/completions/fnm.fish
echo -e ""(set_color green)"✓"(set_color normal)" fnm"

# gh
gh completion --shell fish >~/.config/fish/completions/gh.fish
echo -e ""(set_color green)"✓"(set_color normal)" gh"

# git
wget -o ~/.config/fish/completions/git.fish -q https://github.com/fish-shell/fish-shell/blob/master/share/completions/git.fish
echo -e ""(set_color green)"✓"(set_color normal)" git"
