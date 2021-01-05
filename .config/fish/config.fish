set fish_greeting

. ~/.config/fish/aliases.fish

if test -e ~/.config/fish/custom.fish
  . ~/.config/fish/custom.fish
end

set PATH $HOME/bin $PATH

set -x DOTS $HOME/repos/dots
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
