DOTS=$HOME/repos/dotfiles

# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh
COMPLETION_WAITING_DOTS="true"
ZSH_THEME="joshashby"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Base16 Shell
BASE16_SCHEME="default"
BASE16_SHELL="$DOTS/zsh/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

setopt promptsubst

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
