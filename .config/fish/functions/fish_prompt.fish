set _left_segment ''
set _right_segement ''

if set -q SSH_CONNECTION
  set _left_segment '>'
end

set _ssh_icon 'ಠ_ಠ'

set _status_jobs  ' ⚙ '
set _status_failed ' ✕ '

set _current_bg NONE
set _lstatus 0

function _left_prompt_segment
  set -l bg $argv[1]
  set -l fg $argv[2]

  if test $_current_bg != 'NONE'
    if test $_current_bg != $bg
      set_color $_current_bg -b $bg
      echo -n $_left_segment
    end
  end

  set_color $fg -b $bg
  set _current_bg $bg
end

function _left_prompt_end
  if test $_current_bg != 'NONE'
    set_color $_current_bg -b normal
  end

  echo -n $_left_segment
  set_color normal

  set _current_bg NONE
end

# display the latest git hash for the current branch if we're in a git dir
function _git_hash
  echo -n (git log -1 ^/dev/null | sed -n -e 's/^commit \([a-z0-9]\{8\}\)[a-z0-9]\{32\}/\1/p')
end

function _fossil_hash
  echo -n (fossil status ^/dev/null | sed -n -e 's/^checkout:[[:space:]]*\([a-z0-9]\{8\}\)[a-z0-9]\{32\}[[:space:]].*$/\1/p')
end

function _git_prompt
  set index (fish -lc "eval (asdf where ruby 2.7.3)/bin/ruby $DOTS/bin/gitstatus")

  if test -n "$index[1]"
    echo -s -n (_left_prompt_segment red black) $index
  end
end

function _fossil_prompt
  set index (fish -lc "eval (asdf where ruby 2.7.3)/bin/ruby $DOTS/bin/fossilstatus")

  if test -n "$index[1]"
    echo -s -n (_left_prompt_segment red black) $index
  end
end

function _ssh_prompt
  if set -q SSH_CONNECTION
    echo -s -n (_left_prompt_segment red white) $_ssh_icon
  end
end

function _pwd_prompt
  echo -s -n (_left_prompt_segment white black) (prompt_pwd)
end

function _status_prompt
  if test (jobs -l | wc -l) -gt 1
    echo -n (_left_prompt_segment white blue) $_status_jobs
  end

  if test $_lstatus != 0
    echo -n (_left_prompt_segment white red) $_status_failed
  end
end

function _env_prompt
  if set -q RAILS_ENV
    echo -s -n (_left_prompt_segment white blue) ' ' $RAILS_ENV ' ' (set_color normal)
  end

  if set -q RACK_ENV
    echo -s -n (_left_prompt_segment white blue) ' ' $RACK_ENV ' ' (set_color normal)
  end

  if set -q APP_ENV
    echo -s -n (_left_prompt_segment white blue) ' ' $APP_ENV ' ' (set_color normal)
  end

  if set -q MIX_ENV
    echo -s -n (_left_prompt_segment white blue) ' ' $MIX_ENV ' ' (set_color normal)
  end

  if set -q AWS_VAULT
    echo -s -n (_left_prompt_segment yellow black) ' {|' $AWS_VAULT '|} ' (set_color normal)
  end
end

function _repo_hash_prompt
  echo -s -n (_left_prompt_segment black black) ' ' (_git_hash) ' ' (_fossil_hash) ' ' (set_color normal)
end

function _date_prompt
  echo -s -n (_left_prompt_segment black white) ' ' (date "+%b-%d %H:%M:%S") ' ' (set_color normal)
end

function fish_prompt
  set _lstatus $status
  echo
  echo -s -n '┌─' (_status_prompt) (_env_prompt) (_date_prompt) (_left_prompt_end)
  echo
  echo -s -n '| ' (_ssh_prompt) (_git_prompt) (_fossil_prompt) (_repo_hash_prompt) (_left_prompt_end)
  echo
  echo -s -n '└─' (_pwd_prompt) (_left_prompt_end)
end

# function fish_right_prompt
#   echo -s -n (set_color black) (_git_hash) (set_color normal)
# end
