function node_update
  if not command -v npm >/dev/null 2>&1
    return 0
  end

  if set -q VOLTA_HOME; and test -n "$VOLTA_HOME"; and command -v volta >/dev/null 2>&1
    echo "🚀 Updating Node packages via Volta"

    set -l outdated_json (npm outdated -g --json --min-release-age=3 2>/dev/null)
    set -l npm_status $status

    if test $npm_status -ne 0; and test -z "$outdated_json"
      echo "Unable to inspect outdated global packages."
      return 0
    end

    if test -z "$outdated_json"; or test "$outdated_json" = "{}"
      echo "No outdated global packages found."
      return 0
    end

    set -l updates (printf '%s\n' "$outdated_json" | jq -r 'to_entries[] | select(.value.wanted != null and .value.wanted != .value.current) | "\(.key)|\(.value.wanted)"')

    if test -n "$updates"
      echo ""
      echo "⇢ Packages to update:"
      for update in $updates
        echo "  - $update"
      end
      echo ""
    end

    for update in $updates
      set -l parts (string split "|" "$update")
      set -l pkg_name $parts[1]
      set -l pkg_version $parts[2]

      if test -n "$pkg_name"; and test -n "$pkg_version"
        echo "⇢ Updating $pkg_name to $pkg_version via Volta..."
        volta install "$pkg_name@$pkg_version"
        echo ""
      end
    end
  else
    echo "🚀 Updating Node packages via Volta"
    npm update --global
  end
end
