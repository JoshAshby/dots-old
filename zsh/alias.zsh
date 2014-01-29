alias repos="cd ~/repos/"
alias www="cd /srv/http/"
alias nano="vim"
alias vi="vim"
alias vim="vim"
alias v="gvim"
alias la='ls -la --color'
alias now="now.sh"
alias sl='ls -la --color'
alias mk='mkdir'


if [ -f "~/bin/tmuxinator.zsh" ]; then
  source ~/bin/tmuxinator.zsh
else
  alias mux="tmux"
fi

if [[ -r $DOTS/zsh/custom.zsh ]]; then
  source $DOTS/zsh/custom.zsh
fi

if [[ -r $DOTS/zsh/git.zsh ]]; then
  source $DOTS/zsh/git.zsh
fi

if [[ -r $DOTS/zsh/ssh.zsh ]]; then
  source $DOTS/zsh/ssh.zsh
fi
