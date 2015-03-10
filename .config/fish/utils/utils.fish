. ./utils/alias.fish
. ./utils/git.fish

if test -e ./utils/ssh.fish
  . ./utils/ssh.fish
end

if test -e ./utils/custom.fish
  . ./utils/custom.fish
end

function _utils
  echo 'hia'
end
