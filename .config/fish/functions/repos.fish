function repos
  if test -n "$argv"
    cd ~/repos/$argv
  else
    cd ~/repos/
  end
end
