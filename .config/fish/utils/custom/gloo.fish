alias g.reset 'bower update and npm install and grunt sass and bundle install and rake db:reset db:preload and rbenv rehash'
alias g.yard 'yard and yard server --reload'
alias g.test 'rake and grunt tests'

alias ror.models 'ack "^(?:\s+)(has_|belongs_)"'

alias redis 'redis'
alias redis.m 'redis-cli monitor'

set -g PGDATA '/usr/local/var/postgres'

set -g PATH $PATH:/usr/local/sbin

set -g LC_ALL en_US.UTF-8
set -g LANG en_US.UTF-8

set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1
