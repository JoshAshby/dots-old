tmux() {
  MUX=/usr/bin/tmux
  if [ ! $1 ] ; then
    $MUX a -d || $MUX
  else
    $MUX $@
  fi
}
alias mux="tmux"
