#really dirty thing borrowed from mortalscumbag theme...
function my_git_prompt() {
        tester=$(git rev-parse --git-dir 2> /dev/null) || return

        INDEX=$(git status --porcelain 2> /dev/null)
        STATUS=""

        # is branch ahead?
        if $(echo "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
        fi

        # is anything staged?
        if $(echo "$INDEX" | grep -E -e '^(D[ M]|[MARC][ MD]) ' &> /dev/null); then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
        fi

        # is anything unstaged?
        if $(echo "$INDEX" | grep -E -e '^[ MARC][MD] ' &> /dev/null); then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
        fi

        # is anything untracked?
        if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
        fi

        # is anything unmerged?
        if $(echo "$INDEX" | grep -E -e '^(A[AU]|D[DU]|U[ADU]) ' &> /dev/null); then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
        fi

        if [[ -n $STATUS ]]; then
                STATUS=" $STATUS"
        fi

        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(my_current_branch)$STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function my_current_branch() {
  echo $(current_branch || echo "(⚠)")
}


#now on to normal stuff and stuff from josh
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi

function virtualenv_info {
        [ $VIRTUAL_ENV  ] && echo "%{$fg_bold[blue]%}(%{$fg_no_bold[green]%}$(echo `basename $VIRTUAL_ENV`)%{$fg_bold[blue]%})%{$reset_color%}"
}

function rhand_info {
        echo '%{$fg[blue]%}(SSH DEV)'
}

function ssh_connection {
        [[ -n $SSH_CONNECTION ]] && echo "%{$fg_bold[red]%}(ssh) %b"
}

PROMPT='$(ssh_connection)%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg[blue]%}%B%c/%b%{$reset_color%} $(my_git_prompt) %(!.#.$) '
RPROMPT='$(rhand_info)'

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_no_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%}"
ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑ "
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}● "
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[red]%}● "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}● "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}✕ "


# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.patch=00;34:*.o=00;32:*.so=01;35:*.ko=01;31:*.la=00;33'
