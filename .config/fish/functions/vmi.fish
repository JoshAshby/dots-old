function vmi --argument lang
  set -q lang[1]; or set lang (asdf plugin-list | fzf)

  set version (asdf list-all $lang | fzf)

  asdf local $lang $version
end
