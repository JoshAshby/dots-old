# Harddrive stuff, since my laptop likes to CONSTANTLY spin down the drive
# and it's loud and slow ; dcache to drop the cache in swap because Chrome
alias dcache="sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches >> /dev/null"
alias drivetune="sudo hdparm -B 254 /dev/sda; sudo hdparm -M 254 /dev/sda; sudo hdparm -S 12 /dev/sda"

#screenshots and upload to transientbug for leach to index
alias scrn="scrot ~/screenshots/%Y-%m-%d-%T-screenshot.png -s -e 'scp $f sigyn:../transientbug/html/scrn/' -d 10"

# Yucky JAVA stuff needed for school
#export J2REDIR=/opt/java/jre
#export JAVA_HOME=${JAVA_HOME:-/opt/java/jre}
export PATH=$PATH:~/bin
alias siber="sudo pm-suspend"
alias www="cd /srv/http"
