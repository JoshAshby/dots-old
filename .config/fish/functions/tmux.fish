function tmux
  if test -n "$argv"
    command tmux $argv
  else
    command tmux a -d
    if test $status -ne 0
      command tmux
    end
  end
end
