set -x PGDATA /usr/local/var/postgres
set -x ES_JAVA_OPTS '-XX:-MaxFDLimit -Xms8g -Xmx8g'

if test -d $HOME/.rbenv
  set PATH $HOME/.rbenv/shims $PATH
  . (rbenv init - | psub)
end

test -d {$HOME}/.cargo ; and set PATH $HOME/.cargo/bin $PATH

set -g EDITOR gvim

alias r 'bundle exec ruby'
alias b 'bundle exec'
alias ra 'bundle exec rake'
alias rc 'bundle exec rails c'
alias rs 'bundle exec rails s'

alias r.yard 'bundle exec yard; and bundle exec yard server --reload'

alias ror.models 'ack "^(?:\s+)(has_|belongs_)"'

alias redis 'redis'
alias redis.m 'redis-cli monitor'

alias ran 'run_and_notify'

alias g.ap "echo \"gem 'scubaru', path: '~/repos/scubaru', require: 'scubaru'\" >> Gemfile"

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

