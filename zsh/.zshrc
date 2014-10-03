DOTS=$HOME/repos/dots
COMPLETION_WAITING_DOTS="true"

# antigen takes care of setting up oh-my-zsh and themes and that
# see zsh/antigens.zsh for more info
. $DOTS/zsh/antigens.zsh

# If I cd in a dir stored in a var, place the dir name in the prompt
# and not the var name
setopt promptsubst

# If now is around then add it to the path...
if [ -f "$DOTS/zsh/now/now.sh" ]; then
  export PATH=$PATH:$DOTS/zsh/now
fi

export EDITOR="vim"

source $DOTS/zsh/alias.zsh
source $DOTS/zsh/functions.zsh

# If we have z then use it
# z is a nice predictive dir jumper
if [ -f "$DOTS/zsh/z/z.sh" ]; then
  . $DOTS/zsh/z/z.sh
fi

export PGDATA="/usr/local/var/postgres"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
