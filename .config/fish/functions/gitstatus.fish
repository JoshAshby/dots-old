function gitstatus
  git status --porcelain -b ^ /dev/null | awk '
    /^##/ {
      split($2, a, ".")
      status["branch"] = a[1]
      status["remote"] = a[4]
    }

    /^(D[ M]|[MARC][ MD])/ {
      status["staged"] ++
    }

    /^[ MARC][MD]/ {
      status["unstaged"] ++
    }

    /^\?\?/ {
      status["untracked"] ++
    }

    /^(A[AU]|D[DU]|U[ADU])/ {
      status["unmerged"] ++
    }

    END {
      print status["branch"]
      print status["remote"]
      print status["staged"]
      print status["unstaged"]
      print status["untracked"]
      print status["unmerged"]
    }
  '
end
