function exec_start --on-event fish_preexec -d "Starts the execution clock of a process"
  set -g _exec_start (date +%s)
  set -g _last_cmd $argv[1]
end
