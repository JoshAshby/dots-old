# Harddrive stuff, since my laptop likes to CONSTANTLY spin down the drive
# and it's loud and slow ; dcache to drop the cache in swap because Chrome
alias dcache="sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches >> /dev/null"
alias drivetune="sudo hdparm -B 254 /dev/sda; sudo hdparm -M 254 /dev/sda; sudo hdparm -S 12 /dev/sda"

# Yucky JAVA stuff needed for school
#export J2REDIR=/opt/java/jre
#export JAVA_HOME=${JAVA_HOME:-/opt/java/jre}
#export PATH=$PATH:/opt/java/jre/bin
alias siber="sudo pm-hibernate"
alias www="cd /srv/http"
