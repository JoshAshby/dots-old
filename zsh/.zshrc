DOTS=$HOME/repos/dotfiles

#Path to your oh-my-zsh configuration.
#ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme
#ZSH_THEME="philips"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# plugins=(git archlinux pip python vim)

#source $ZSH/oh-my-zsh.sh
. $DOTS/zsh/antigens.zsh

export PATH=$PATH:/home/josh/bin:$DOTS/zsh/now

export EDITOR="vim"
#export BROWSER="firefox"

export J2REDIR=/opt/java/jre
export PATH=$PATH:/opt/java/jre/bin
export JAVA_HOME=${JAVA_HOME:-/opt/java/jre}

source $DOTS/zsh/alias.zsh
source $DOTS/zsh/functions.zsh
. $DOTS/zsh/z/z.sh

#[ -s "/home/josh/.scm_breeze/scm_breeze.sh" ] && source "/home/josh/.scm_breeze/scm_breeze.sh"
