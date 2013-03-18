loki() {
    xscreensaver -nosplash&
    xmodmap ~/.Xmodmap&
}

tmux() {
  MUX=/usr/bin/tmux
  if [ ! $1 ] ; then
    $MUX a -d || $MUX
  else
    $MUX $@
  fi
}
alias mux="tmux"


activate() {
    export VIRTUAL_ENV_DISABLE_PROMPT='1'
    source ./$1/bin/activate
}
