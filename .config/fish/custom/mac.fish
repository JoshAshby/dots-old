set -g EDITOR gvim

set -x PGDATA /usr/local/var/postgres
set -x ES_JAVA_OPTS '-XX:-MaxFDLimit -Xms8g -Xmx8g'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

source /usr/local/opt/asdf/asdf.fish
