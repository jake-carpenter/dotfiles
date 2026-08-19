function node_update
  if not command -v npm >/dev/null 2>&1
    return 0
  end

  if set -q VOLTA_HOME; and test -n "$VOLTA_HOME"; and command -v volta >/dev/null 2>&1
    echo "🚀 Updating Node packages via Volta"

    set -l volta_pkg_dir "$VOLTA_HOME/tools/image/packages"
    if not test -d "$volta_pkg_dir"
      echo "No volta global packages directory found."
      return 0
    end

    set -l updates_needed
    set -l pkg_dirs (find "$volta_pkg_dir" -mindepth 1 -maxdepth 1 -type d | sort)

    for dir in $pkg_dirs
      set -l pkg_name (basename "$dir")
      set -l pkg_json_path "$dir/lib/node_modules/$pkg_name/package.json"

      if not test -f "$pkg_json_path"
        continue
      end

      set -l installed_version (jq -r '.version // empty' "$pkg_json_path" 2>/dev/null)
      if test -z "$installed_version"; or test "$installed_version" = "null"
        continue
      end

      set -l registry_json (curl -sf --max-time 5 "https://registry.npmjs.org/$pkg_name" 2>/dev/null)
      if test -z "$registry_json"
        continue
      end

      set -l latest_version (echo "$registry_json" | jq -r '.dist-tags.latest // empty' 2>/dev/null)
      if test -z "$latest_version"; or test "$latest_version" = "null"
        continue
      end

      if test "$installed_version" = "$latest_version"
        echo ""
        echo "✓ $pkg_name@$installed_version"
        continue
      end

      echo ""
      echo "⇢ $pkg_name"
      echo "    Current: $installed_version"
      echo "    Latest:  $latest_version"
      set updates_needed $updates_needed "$pkg_name@$latest_version"
    end

    if test (count $updates_needed) -eq 0
      echo ""
      echo "All packages are up to date."
      return 0
    end

    echo ""
    echo "⇢ Updating $(count $updates_needed) package(s)..."
    echo ""

    for update_spec in $updates_needed
      set -l parts (string split "@" "$update_spec")
      set -l pkg_name $parts[1]
      set -l pkg_version $parts[2]
      echo "⇢ Installing $pkg_name@$pkg_version via Volta..."
      volta install "$pkg_name@$pkg_version"
      echo ""
    end
  else
    echo "🚀 Updating Node packages via Volta"
    npm update --global
  end
end
