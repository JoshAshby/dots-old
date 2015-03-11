set fish_greeting

. ~/.config/fish/utils/alias.fish
. ~/.config/fish/utils/git.fish

if test -e ~/.config/fish/utils/ssh.fish
  . ~/.config/fish/utils/ssh.fish
end

if test -e ~/.config/fish/utils/custom.fish
  . ~/.config/fish/utils/custom.fish
end
