function dev_clean
  # Dotnet
  set -a rules 'bin,obj@*.csproj'

  # Expo-related stuff
  set -a rules 'dist,release,ios,android@package.json'

  # Node
  set -a rules 'node_modules'

  if test -z "$argv[1]"
    set cwd .
  else
    set cwd $argv[1]
  end 

  projclean --cwd $cwd $rules
end