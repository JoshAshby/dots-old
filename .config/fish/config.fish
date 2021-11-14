# Disable the greeting prompt
set fish_greeting

set -gx DOTS $HOME/repos/dots

fish_add_path $HOME/bin
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin/

source ~/.config/fish/aliases.fish

set -gx EDITOR gvim

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
test -e /opt/homebrew/opt/asdf/asdf.fish ; and source /opt/homebrew/opt/asdf/asdf.fish

direnv hook fish | source
zoxide init fish | source

fish_add_path "$HOME/repos/personal/gni"
fish_add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Hi elasticsearch, welcome to the club
set -gx ES_JAVA_OPTS '-XX:-MaxFDLimit -Xms8g -Xmx8g'
fish_add_path "/opt/homebrew/opt/openjdk/bin"

set -gx DO_NOT_TRACK 1

# seriously fuck off homebrew and stop breaking my shit with auto upgrades that
# aren't documented anywhere besides a pr from 2017
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_NO_INSTALL_UPGRADE 1 # WHAT THE FLYING FUCK HOMEBREW

set -gx ET_NO_TELEMETRY 1

# Setup PG for a specific version cause reasons
set -gx PGDATA /opt/homebrew/var/postgres
fish_add_path /opt/homebrew/opt/postgresql@13/bin
