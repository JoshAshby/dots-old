function gloo
  if test -n "$argv"
    cd ~/gloo/$argv
  else
    cd ~/gloo/
  end
end
