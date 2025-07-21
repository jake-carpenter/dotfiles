#! /usr/bin/env fish

function set_default
  set domain $argv[1]
  set key $argv[2]
  set type $argv[3]
  set expected_value $argv[4]
  set description $argv[5]
  set changed_flag_name $argv[6]

  set current_value (defaults read $domain $key 2>/dev/null)
  set target_value $expected_value

  switch $type
    case bool
      if test "$expected_value" = true
        set target_value 1
      else
        set target_value 0
      end
  end

  if test "$current_value" != "$target_value"
    echo "    - $description"
    defaults write $domain $key "-$type" $expected_value
    set -g $changed_flag_name true
  end
end

set yaml_file (chezmoi source-path)/.chezmoidata/defaults.yaml

set num_groups (yq '.defaults | length' $yaml_file)

for i in (seq 0 (math $num_groups - 1))
  set group_name (yq ".defaults[$i] | keys | .[0]" $yaml_file)
  set group_data_query ".defaults[$i].$group_name"

  set message (yq "$group_data_query.message" $yaml_file)
  echo -e "⚙️ $message"

  set changed_flag_name "$group_name""_changed"
  set $changed_flag_name false

  set num_entries (yq "$group_data_query.entries | length" $yaml_file)
  for j in (seq 0 (math $num_entries - 1))
    set entry_query "$group_data_query.entries[$j]"
    set domain (yq "$entry_query.domain" $yaml_file)
    set key (yq "$entry_query.key" $yaml_file)
    set type (yq "$entry_query.type" $yaml_file)
    set expected_value (yq "$entry_query.expected_value" $yaml_file)
    set description (yq "$entry_query.description" $yaml_file)

    set_default $domain $key $type $expected_value $description $changed_flag_name
  end

  if set -q (echo $changed_flag_name)
    if test $$changed_flag_name = true
      set kill_process (yq "$group_data_query.kill" $yaml_file)
      if test "$kill_process" != "null"
        killall $kill_process
      end
    end
  end
end
