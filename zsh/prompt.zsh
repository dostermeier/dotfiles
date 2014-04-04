git_branch() {
  echo -ne $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(git st 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo " "
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo " "
    else
      echo "*"
    fi
  fi
}

git_prompt_info () {
 ref=$(git symbolic-ref HEAD 2>/dev/null) || return
 echo "(%{\e[0;35m%}${ref#refs/heads/}%{\e[0m%})"
}

unpushed () {
  git cherry -v origin/$(git_branch) 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo "%{\e[0;33m%}$%{\e[0m%}"
  fi
}

_prompt_username () {
    echo $(whoami);
}

_prompt_hostname () {
    echo $(hostname);
}

_prompt_git_branch () {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return "";
    echo ${ref#refs/heads/};
}

_prompt_git() {
    if [[ $(_prompt_git_branch) == "" ]]
    then
        echo "";
    else
        echo "/$(_prompt_git_branch)$(git_dirty)/";
    fi
}

#export PROMPT=$'%{\e[0;36m%} - %~ - %{\e[0m%}/ '
_prompt_refresh() {
    PROMPT="$(_prompt_username)@$(_prompt_hostname):$(_prompt_git)(%~)
> "
}

precmd() {
   #print -Pn "\e]0;%~\a"
   _prompt_refresh;
   export RPROMPT="";
}

_prompt_refresh
