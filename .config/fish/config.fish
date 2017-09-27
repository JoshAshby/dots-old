set fish_greeting

. ~/.config/fish/alias.fish
. ~/.config/fish/git.fish
. ~/.config/fish/ssh.fish

if test -e ~/.config/fish/custom.fish
  . ~/.config/fish/custom.fish
end

set PATH $HOME/bin $PATH

set -x DOTS $HOME/repos/dots
