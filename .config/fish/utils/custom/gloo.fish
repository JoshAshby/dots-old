alias g.ap "echo \"gem 'scubaru', path: '~/repos/scubaru', require: 'scubaru'\" >> Gemfile"

set PGDATA '/usr/local/var/postgres'
set ES_JAVA_OPTS '-XX:-MaxFDLimit'

if test -d $HOME/.rbenv
  set PATH $HOME/.rbenv/shims $PATH
  . (rbenv init -|psub)
end

set EDITOR 'gvim'

alias r 'bundle exec ruby'
alias b 'bundle exec'
alias ra 'bundle exec rake'
alias rc 'bundle exec rails c'
alias rs 'bundle exec rails s'
alias rails 'bundle exec rails'

alias r.yard 'bundle exec yard; and bundle exec yard server --reload'

alias ror.models 'ack "^(?:\s+)(has_|belongs_)"'

alias redis 'redis'
alias redis.m 'redis-cli monitor'

alias ran 'run_and_notify'

alias meep 'echo "http://"(ipconfig getifaddr en0)":8080" | pbcopy'
