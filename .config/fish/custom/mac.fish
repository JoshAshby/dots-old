set -g EDITOR gvim

set -x PGDATA /usr/local/var/postgres
set -x ES_JAVA_OPTS '-XX:-MaxFDLimit -Xms8g -Xmx8g'
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

source ~/.iterm2_shell_integration.(basename $SHELL)

source /usr/local/opt/asdf/asdf.fish

direnv hook fish | source
zoxide init fish | source
