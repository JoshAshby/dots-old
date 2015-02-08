alias g.reset='bower update && npm install && grunt sass && bundle install && rake db:reset db:preload && rbenv rehash'
alias g.yard='yard && yard server --reload'
alias g.test='rake && grunt tests'

alias ror.models='ack "^(?:\s+)(has_|belongs_)"'

alias redis='redis'
alias redis.m='redis-cli monitor'

export PGDATA="/usr/local/var/postgres"

export PATH=$PATH:/usr/local/sbin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval "$(rbenv init -)"

[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"
