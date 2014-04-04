
setopt prompt_subst             # Enable substritutions within prompt. No need to re-evaluate prompt.
autoload -U colors && colors    # Enable colours in the prompt.

# Colors:
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

PROMPT_COLOR_GIT="${txtpur}";
PROMPT_COLOR_GIT_BRANCH="";
PROMPT_COLOR_GIT_STATUS="";
PROMPT_COLOR_USERNAME="";
PROMPT_COLOR_HOST="";
PROMPT_COLOR_PATH="";
PROMPT_COLOR_USERNAME_HOST="${txtgrn}";

#
# GIT prompt support (move this into the git module and selectively use it? at least the functions?)
#

_prompt_git_dirty() {
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
        fi;
    fi;
}

#is_unpushed () {
#    echo $(git cherry -v origin/$(git_branch) 2>/dev/null);
#}

#need_push () {
#  if [[ $(is_unpushed) == "" ]]
#  then
#    echo " "
#  else
#    echo "%{\e[0;33m%}$%{\e[0m%}"
#  fi
#}

_prompt_username () {
    echo "${PROMPT_COLOR_USERNAME}$(whoami)${txtrst}";
}

_prompt_hostname () {
    echo "${PROMPT_COLOR_HOST}$(hostname)${txtrst}";
}

_prompt_git_branch () {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return "";
    echo ${ref#(refs/heads/|tags/)};
}

_prompt_username_host () {
    echo "${PROMPT_COLOR_USERNAME_HOST}$(_prompt_username)${PROMPT_COLOR_USERNAME_HOST}@$(_prompt_hostname)${txtrst}"
}

_prompt_git() {
    if [[ $(_prompt_git_branch) == "" ]]
    then
        echo "";
    else
        echo "${PROMPT_COLOR_GIT}${PROMPT_COLOR_GIT_BRANCH}$(_prompt_git_branch)${PROMPT_GIT_COLOR}:${PROMPT_COLOR_GIT_STATUS}$(_prompt_git_dirty)${txtrst}";
    fi
}

_prompt_refresh() {
    PROMPT="$(_prompt_username_host)> %~ >
$(_prompt_git)> ";
    RPROMPT="";
}

# Hook to refresh the prompt each time it needs to be rendered.
precmd() {
   _prompt_refresh;
}

_prompt_refresh
