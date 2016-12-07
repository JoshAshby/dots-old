test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

function exec_start --on-event fish_preexec -d "Starts the execution clock of a process"
  set -g _exec_start (date +%s)
  set -g _last_cmd $argv[1]
end

function exec_end --on-event fish_postexec -d "Stop the execution clock of a process and set _exec_delta"
  set -g _exec_delta (math (date +%s) - $_exec_start)
  set -e -g _exec_start
end
