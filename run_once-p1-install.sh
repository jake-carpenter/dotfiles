#!/usr/bin/env bash
set -e

# Install Homebrew if missing
if ! command -v brew >/dev/null; then
  echo
  echo "🚀 Installing homebrew"
  echo -e "\033[90m[debug]: Ran from run_once-p1-install.sh\033[0m"
  echo "─────────────────────────────────────────"
  echo "🚨 YOU WILL BE ASKED FOR YOUR PASSWORD"
  echo
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "eval \"\$(\/opt\/homebrew\/bin\/brew shellenv)\"" >> "$HOME"/.zshrc
  echo "✅ Homebrew installed successfully"
fi

# Setup Homebrew environment for this shell
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install fish if missing
if ! command -v fish >/dev/null; then
  echo
  echo "🚀 Installing fish"
  echo "─────────────────────────────────────────"
  brew install fish
  echo "✅ Fish shell installed successfully"
fi

# Install pnpm if missing
if ! command -v pnpm >/dev/null; then
  echo
  echo "🚀 Installing pnpm"
  echo "─────────────────────────────────────────"
  brew install pnpm
  echo "✅ pnpm installed successfully"
fi

# Install bun if missing
if ! command -v bun >/dev/null; then
  echo
  echo "🚀 Installing bun"
  echo "─────────────────────────────────────────"
  curl -fsSL https://bun.sh/install | bash
  # Add bun to PATH for this session
  export PATH="$HOME/.bun/bin:$PATH"
  
  # Add bun to .zshrc
  echo "export BUN_INSTALL=\"$HOME\/.bun\"" >> "$HOME/.zshrc"
  echo "export PATH=\"$BUN_INSTALL/bin:\$PATH\"" >> "$HOME/.zshrc"
  echo "✅ bun installed successfully"
fi

# Install fnm if missing
if ! command -v fnm >/dev/null; then
  echo
  echo "🚀 Installing fnm"
  echo "─────────────────────────────────────────"
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  # Source fnm environment for this session
  export PATH="$HOME/.fnm:$PATH"
  eval "$(fnm env)"
  echo "✅ fnm installed successfully"
fi

# fisher
if [ ! -f "$HOME/.config/fish/functions/fisher.fish" ]; then
  echo
  echo "🚀 Installing fisher"
  echo "─────────────────────────────────────────"
  brew install fisher
  echo "✅ fisher installed successfully"
fi

# Install LTS NodeJS
if ! command -v node &> /dev/null; then
  echo
  echo "🚀 Installing latest LTS NodeJS"
  echo "─────────────────────────────────────────"
  fnm install --lts
  echo "✅ NodeJS installed successfully"
fi

# Install proper chezmoi
if ! command -v chezmoi >/dev/null; then
  echo
  echo "🚀 Installing chezmoi"
  echo "─────────────────────────────────────────"
  brew install chezmoi
  echo "✅ chezmoi installed successfully"
fi

chmod +x apply_root.sh

echo "─────────────────────────────────────────"
echo -e "✅ Step 1 of initialization complete\n"
echo -e "\033[33mRun the following commands to apply further steps:\033[0m\n"
echo "source ~/.zshrc"
echo "bash apply_root.sh"
echo
