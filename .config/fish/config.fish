set fish_greeting

set PATH $HOME/bin $PATH
set PATH /usr/local/bin $PATH

set -x DOTS $HOME/repos/dots

. ~/.config/fish/aliases.fish

if test -e ~/.config/fish/custom.fish
  . ~/.config/fish/custom.fish
end
