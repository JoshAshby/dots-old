# Gives an attach or create style ability to tmux
tmux() {
  MUX=/usr/local/bin/tmux
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

# Just kiind of comment this out, since I don't need
# it at work
#
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

# allows repos to act like cd and auto complete to stuff in
# ~/repos
repos() {
  cd ~/repos/$@
}
compctl -/ -W ~/repos repos

gloo() {
  cd ~/gloo/$@
}
compctl -/ -W ~/gloo gloo


# taken from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
# But not using the git plugin because fuck those alias's, I want my own.
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}
