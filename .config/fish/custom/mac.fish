set -g EDITOR gvim

set -x PGDATA /usr/local/var/postgres
set -x ES_JAVA_OPTS '-XX:-MaxFDLimit -Xms8g -Xmx8g'

#if test -d $HOME/.rbenv
  #set PATH $HOME/.rbenv/shims $PATH
  #. (rbenv init - | psub)
#end

#test -d {$HOME}/.cargo ; and set PATH $HOME/.cargo/bin $PATH

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

source /usr/local/opt/asdf/asdf.fish
