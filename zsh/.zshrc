DOTS=$HOME/repos/dots/zsh

source $DOTS/alias.zsh
source $DOTS/functions.zsh
source $DOTS/antigens.zsh
. $DOTS/z/z.sh

#Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme
ZSH_THEME="philips"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# plugins=(git archlinux pip python vim)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/usr/share//arduino-1.0:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/qt/bin:/home/josh/scripts

export EDITOR="vim"
export BROWSER="firefox"

[ -s "/home/josh/.scm_breeze/scm_breeze.sh" ] && source "/home/josh/.scm_breeze/scm_breeze.sh"

export J2REDIR=/opt/java/jre
export PATH=$PATH:/opt/java/jre/bin
export JAVA_HOME=${JAVA_HOME:-/opt/java/jre}
