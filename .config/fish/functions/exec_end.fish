function exec_end --on-event fish_postexec -d "Stop the execution clock of a process and set _exec_delta"
  set -g _exec_delta (math (date +%s) - $_exec_start)
  set -e -g _exec_start
end
