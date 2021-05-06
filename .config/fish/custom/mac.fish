set -g EDITOR gvim

set -x PGDATA /usr/local/var/postgres
set -x ES_JAVA_OPTS '-XX:-MaxFDLimit -Xms8g -Xmx8g'

source ~/.iterm2_shell_integration.(basename $SHELL)

source /usr/local/opt/asdf/asdf.fish
