DOTS=$HOME/repos/dots

# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh
COMPLETION_WAITING_DOTS="true"
ZSH_THEME="joshashby"
source $ZSH/oh-my-zsh.sh

setopt promptsubst

if [ -f $DOTS/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $DOTS/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Useful little think that prints the time every second,
# good for piping something into it
if [ -f "$DOTS/zsh/now/now.sh" ]; then
  export PATH=$PATH:$HOME/bin:$DOTS/zsh/now
fi

# z is a nice predictive dir jumper
if [ -f "$DOTS/zsh/z/z.sh" ]; then
  . $DOTS/zsh/z/z.sh
fi

export GIT_EDITOR="vim"
export EDITOR="gvim"

source $DOTS/zsh/alias.zsh
source $DOTS/zsh/functions.zsh
