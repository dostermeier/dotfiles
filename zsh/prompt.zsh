# Ensure our colours have been loaded.
source $ZSH/system/colours.zsh

setopt prompt_subst             # Enable substritutions within prompt. No need to re-evaluate prompt.

PROMPT_COLOR_GIT="${txtpur}";
PROMPT_COLOR_GIT_BRANCH="";
PROMPT_COLOR_GIT_STATUS="";
PROMPT_COLOR_USERNAME="";
PROMPT_COLOR_HOST="";
PROMPT_COLOR_PATH="";
PROMPT_COLOR_USERNAME_HOST="${txtblu}";

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
