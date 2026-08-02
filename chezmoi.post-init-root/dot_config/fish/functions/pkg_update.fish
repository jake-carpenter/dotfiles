function pkg_update
  if command -v npm >/dev/null 2>&1
    node_update
    echo ""
  end

  if command -v bun >/dev/null 2>&1
    echo "🚀 Updating Bun packages"
    bun update --global
    echo ""
  end

  if command -v cargo >/dev/null 2>&1
    echo "🚀 Updating Cargo packages"
    cargo install-update --all
    echo ""
  end

  if command -v brew >/dev/null 2>&1
    echo "🚀 Updating Homebrew packages"
    brew update
    brew_update
    echo ""
  end

  if command -v apt >/dev/null 2>&1
    echo "🚀 Updating APT packages"
    sudo apt update
    sudo apt upgrade -y
    echo ""
  end

  if command -v snap >/dev/null 2>&1
    echo "🚀 Updating Snap packages"
    sudo snap refresh
    echo ""
  end
end