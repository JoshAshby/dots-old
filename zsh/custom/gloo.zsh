alias g.reset='bower update && npm install && grunt sass && bundle install && rake db:reset db:preload && rbenv rehash'
alias g.yard='yard && yard server --reload'
alias g.test='rake && grunt test'

alias ror.models='ack "^(?:\s+)(has_|belongs_)"'

alias redis='redis'
alias redis.m='redis-cli monitor'
