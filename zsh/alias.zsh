#alias repos="cd ~/repos/"
alias www="cd /srv/http/"
alias nano="vim"
alias vi="vim"
alias vim="vim"
alias v="gvim"
alias la='ls -la'
alias now="now.sh"
alias sl='ls -CS1hl'
alias mk='mkdir'
alias nope="echo 'Oh, okay... :('"
alias c=/bin/cat
#alias cat=lolcat # trolololol

source $DOTS/zsh/git.zsh

# If I have tmuxinator, then source it
# otherwise alias mux to tmux
if [ -f "~/bin/tmuxinator.zsh" ]; then
  source ~/bin/tmuxinator.zsh
else
  alias mux="tmux"
fi

# If I've linked to a custom and or ssh stuff, then source it.
# This shouldn't probably be in the alias file but thats okay,
# fuckc it, its a shell script anyways.
if [[ -r $DOTS/zsh/custom.zsh ]]; then
  source $DOTS/zsh/custom.zsh
fi

if [[ -r $DOTS/zsh/ssh.zsh ]]; then
  source $DOTS/zsh/ssh.zsh
fi
