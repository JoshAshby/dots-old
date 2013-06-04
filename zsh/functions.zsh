tmux() {
  MUX=/usr/bin/tmux
  if [ ! $1 ] ; then
    $MUX a -d || $MUX
  else
    $MUX $@
  fi
}

rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
