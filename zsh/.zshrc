ZSH=$HOME/.oh-my-zsh
DOTS=$HOME/repos/dotfiles

COMPLETION_WAITING_DOTS="true"
ZSH_THEME="joshashby"
plugins=(git)
setopt promptsubst

source $ZSH/oh-my-zsh.sh

if [ -f "$DOTS/zsh/now/now.sh" ]; then
  export PATH=$PATH:/home/josh/bin:$DOTS/zsh/now
fi

if [ -f $DOTS/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $DOTS/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# z is a nice predictive dir jumper
if [ -f "$DOTS/zsh/z/z.sh" ]; then
  . $DOTS/zsh/z/z.sh
fi

export GIT_EDITOR="vim"
export EDITOR="gvim"

source $DOTS/zsh/alias.zsh
source $DOTS/zsh/functions.zsh
