alias g.ap "echo \"gem 'scubaru', path: '~/repos/scubaru', require: 'scubaru'\" >> Gemfile"

set PGDATA '/usr/local/var/postgres'

if test -d $HOME/.rbenv
  set PATH $HOME/.rbenv/shims $PATH
  . (rbenv init -|psub)
end

alias r 'rails'
alias ra 'rake'

alias r.yard 'yard; and yard server --reload'

alias ror.models 'ack "^(?:\s+)(has_|belongs_)"'

alias redis 'redis'
alias redis.m 'redis-cli monitor'

alias ran 'run_and_notify'
