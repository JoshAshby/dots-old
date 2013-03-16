alias dhcp="sudo dhcpcd"
alias sigyn="ssh -XA -L 9050:localhost:9050 -D 3500 -L 8118:localhost:8118 sigyn"
alias repos="cd ~/repos/"
alias www="cd /srv/http/"
alias nano="vim"
alias vi="vim"
alias vim="vim"
alias -g v="vim"
alias vg="gvim"
alias awvim='vim ~/.config/awesome/rc.lua'
alias la='ls -la'
alias pacman='sudo pacman'
alias backlight="sudo backlight"
alias now="now.sh"
alias sl='ls -la --color'

alias dcache="sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches >> /dev/null"
alias drivetune="sudo hdparm -B 254 /dev/sda; sudo hdparm -M 254 /dev/sda; sudo hdparm -S 12 /dev/sda"
