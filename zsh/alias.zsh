alias nano="vim"
alias vi="vim"
alias vim="vim"
alias v="gvim"
alias la='ls -la'
alias now="now.sh"
alias sl='ls -la'

alias mux="tmux"

if [[ -r $DOTS/zsh/custom.zsh ]]; then
  source $DOTS/zsh/custom.zsh
fi

if [[ -r $DOTS/zsh/git.zsh ]]; then
  source $DOTS/zsh/git.zsh
fi

if [[ -r $DOTS/zsh/ssh.zsh ]]; then
  source $DOTS/zsh/ssh.zsh
fi
