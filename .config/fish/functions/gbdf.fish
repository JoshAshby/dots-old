function gbdf
git branch | grep --invert-match '\*' | cut -c 3- | fzf --preview='git log {}' --height 20% --reverse --border --multi | xargs git branch --delete --force
end
