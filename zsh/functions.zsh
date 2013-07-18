# Gives an attach or create style ability to tmux
tmux() {
  MUX=/usr/bin/tmux
  if [ ! $1 ] ; then
    $MUX a -d || $MUX
  else
    $MUX $@
  fi
}

# shorthand for activating a python virtenv
activate() {
  export VIRTUAL_ENV_DISABLE_PROMPT='1'
  source ./$1/bin/activate
}

# ... expands into ../.. for cd and so forth
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# alt+s inserts a sudo at the beginning of the line
insert_sudo() {
  zle beginning-of-line;
  zle -U "sudo "
}
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# returns 0 if the first argument is a function
isFunc() {
  declare -f $@ > /dev/null;
  return $?
}

# runs with every cd to check for a .envrc which
# I store project specific stuff in
function chpwd; {
  DIRECTORY=$PWD
  count=0
  while true; do
    let count=$count+1
    if [ -f './.envrc' ]; then
        source './.envrc'
        testFunc=hasActivateRc
        if isFunc activateRc; then
          activateRc
        fi
        break
    fi
    if [ $PWD = '/' ]; then
      if isFunc deactivateRc; then
        deactivateRc
      fi
      break
    fi
    if [ $count -eq 5 ]; then
      if isFunc deactivateRc; then
        deactivateRc
      fi
      break
    fi
    cd -q ..
  done
  cd -q "$DIRECTORY"
}
