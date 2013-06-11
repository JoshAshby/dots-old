alias ack="ack-grep"
alias www="cd /var/www/"

function switch() {
  git checkout "$@";
  ./var/www/burn sparkgen;
}
