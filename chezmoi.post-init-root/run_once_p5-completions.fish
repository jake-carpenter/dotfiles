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
wget -qO ~/.config/fish/completions/eza.fish https://raw.githubusercontent.com/eza-community/eza/main/completions/fish/eza.fish
echo -e ""(set_color green)"✓"(set_color normal)" eza"

# fd
fd --gen-completions fish >~/.config/fish/completions/fd.fish
echo -e ""(set_color green)"✓"(set_color normal)" fd"

# fish lsp
fish-lsp complete >~/.config/fish/completions/fish-lsp.fish
echo -e ""(set_color green)"✓"(set_color normal)" fish lsp"

# gh
gh completion --shell fish >~/.config/fish/completions/gh.fish
echo -e ""(set_color green)"✓"(set_color normal)" gh"

# git
wget -qO ~/.config/fish/completions/git.fish https://raw.githubusercontent.com/fish-shell/fish-shell/master/share/completions/git.fish
echo -e ""(set_color green)"✓"(set_color normal)" git"

# volta
volta completions fish >~/.config/fish/completions/volta.fish
echo -e ""(set_color green)"✓"(set_color normal)" volta"
