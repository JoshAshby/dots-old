set fish_greeting

. ~/.config/fish/utils/alias.fish
. ~/.config/fish/utils/git.fish

if test -e ~/.config/fish/utils/ssh.fish
  . ~/.config/fish/utils/ssh.fish
end

if test -e ~/.config/fish/utils/custom.fish
  . ~/.config/fish/utils/custom.fish
end

set PATH /usr/local/sbin $HOME/bin $PATH

set DOTS $HOME/repos/dots
