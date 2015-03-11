set _left_segment ''
set _right_segement ''

set _ssh_icon 'ಠ_ಠ'

set _git_branch '  '
set _git_ahead '↑ '
set _git_staged '● '
set _git_unstaged '○ '
set _git_untracked 'ᚐ '
set _git_unmerged '✕ '

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

function _git_prompt
  set index (gitstatus)
  set -l branch (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')

  if test -n "$branch"
    echo -s -n (_left_prompt_segment yellow black) $_git_branch $branch ' '

    # is branch ahead?
    if test (git cherry -v $index[2])
      echo -s -n $_git_ahead
    end

    # is anything staged?
    if test $index[3] -ne 0
      echo -s -n $_git_staged
    end

    # is anything unstaged?
    if test $index[4] -ne 0
      echo -s -n $_git_unstaged
    end

    # is anything untracked?
    if test $index[5] -ne 0
      echo -s -n $_git_untracked
    end

    # is anything unmerged?
    if test $index[6] -ne 0
      echo -s -n $_git_unmerged
    end

  end

end

function _ssh_prompt
  if set -q SSH_CONNECTION
    echo -s -n (_left_prompt_segment red white) $_ssh_icon
  end
end

function _pwd_prompt
  echo -s -n (_left_prompt_segment black white) (prompt_pwd)
end

function _status_prompt
  if test (jobs -l | wc -l) -gt 0
    echo -n (_left_prompt_segment white blue) $_status_jobs
  end

  if test $_lstatus -ne 0
    echo -n (_left_prompt_segment white red) $_status_failed
  end
end

function fish_prompt
  set _lstatus $status
  echo -s -n (_ssh_prompt) (_pwd_prompt) (_git_prompt) (_status_prompt) (_left_prompt_end)
end


function _git_hash
  echo -n (git log -1 ^/dev/null | sed -n -e 's/^commit \([a-z0-9]\{8\}\)[a-z0-9]\{32\}/\1/p')
end

function fish_right_prompt
  echo -s -n (set_color black) $index[2] ' ' (_git_hash) ' ' (date "+%b-%d %H:%M:%S") (set_color normal)
end
