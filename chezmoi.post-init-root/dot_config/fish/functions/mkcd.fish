# Creates one or more directories and changes into the first provided.
# Supports `mkdir` options.
#
# Usage: mkcd [mkdir options] DIRECTORY...
function mkcd --description 'Creates and changes into directory'
  if not set -q "argv[1]"
    echo (set_color $fish_color_error) "Enter a directory name" (set_color normal)
  else
    set -l mkdir_args $argv
    argparse --ignore-unknown 'm/mode=' 'p/parents' 'v/verbose' -- $argv
    or return
    command mkdir $mkdir_args; and cd $argv[1]
  end
end
