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

    if not command -v jq >/dev/null 2>&1; or not command -v curl >/dev/null 2>&1
      echo "jq and curl are required to check package versions."
      return 1
    end

    set -l update_names
    set -l update_versions
    set -l pkg_dirs (find "$volta_pkg_dir" -mindepth 1 -maxdepth 2 -type d | sort)
    echo ""

    for dir in $pkg_dirs
      set -l package_jsons (find "$dir/lib/node_modules" -maxdepth 3 -type f -name package.json 2>/dev/null)
      if test (count $package_jsons) -eq 0
        continue
      end

      for pkg_json_path in $package_jsons
        set -l pkg_name (jq -r '.name // empty' "$pkg_json_path" 2>/dev/null)
        set -l installed_version (jq -r '.version // empty' "$pkg_json_path" 2>/dev/null)
        if test -z "$pkg_name"; or test -z "$installed_version"; or test "$installed_version" = "null"
          continue
        end

        set -l registry_json (curl -sf --max-time 5 "https://registry.npmjs.org/"(string escape -- "$pkg_name") 2>/dev/null)
        if test -z "$registry_json"
          continue
        end

        set -l latest_version (echo "$registry_json" | jq -r '."dist-tags".latest // empty' 2>/dev/null)
        if test -z "$latest_version"; or test "$latest_version" = "null"
          continue
        end

        if test "$installed_version" = "$latest_version"
          set_color green
          echo -n "✓ "
          set_color normal
          echo -n "$pkg_name"
          set_color brblack
          echo -n "@"
          set_color normal
          echo "$installed_version"
          continue
        end

        set_color yellow
        echo -n "⇢ "
        set_color normal
        echo -n "$pkg_name"
        set_color brblack
        echo -n "@"
        set_color brred
        echo -n "$installed_version"
        set_color normal
        echo -n " ⇢ "
        set_color green
        echo "$latest_version"
        set_color normal
        
        set update_names $update_names "$pkg_name"
        set update_versions $update_versions "$latest_version"
      end
    end

    if test (count $update_names) -eq 0
      echo ""
      echo "All packages are up to date."
      return 0
    end

    echo ""
    echo "⇢ Updating "(count $update_names)" package(s)..."
    echo ""

    for i in (seq (count $update_names))
      set -l pkg_name $update_names[$i]
      set -l pkg_version $update_versions[$i]
      volta install "$pkg_name@$pkg_version"
      echo ""
    end
  else
    echo "🚀 Updating Node packages via npm"
    npm update --global
  end
end
