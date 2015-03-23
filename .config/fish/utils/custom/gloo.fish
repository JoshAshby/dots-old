alias g.reset 'bower update; and npm install; and grunt sass; and bundle install; and rake db:reset db:migrate db:preload; and rbenv rehash'
alias g.test 'rake; and grunt tests'

set PGDATA '/usr/local/var/postgres'

set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

. ~/.config/fish/utils/custom/nvm-wrapper/nvm.fish
