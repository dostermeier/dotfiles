# Ensure our colours have been loaded.
source $ZSH/system/colours.zsh

# Ensure out git functions have been loaded.
source $ZSH/git/functions.zsh;

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

_prompt_git_status() {
    if [[ $(_is_git_dirty) == "true" ]]
    then
        echo "*";
    else
        echo " ";
    fi;
}

_prompt_username () {
    echo "${PROMPT_COLOR_USERNAME}$(whoami)${txtrst}";
}

_prompt_hostname () {
    echo "${PROMPT_COLOR_HOST}$(hostname)${txtrst}";
}

_prompt_username_host () {
    echo "${PROMPT_COLOR_USERNAME_HOST}$(_prompt_username)${PROMPT_COLOR_USERNAME_HOST}@$(_prompt_hostname)${txtrst}"
}

_prompt_git() {
    if [[ $(_is_git_repo) == "true" ]];
    then
        echo "${PROMPT_COLOR_GIT}${PROMPT_COLOR_GIT_BRANCH}$(_git_branch)${PROMPT_GIT_COLOR}:${PROMPT_COLOR_GIT_STATUS}$(_prompt_git_status)${txtrst}";
    else 
        echo "";
    fi
}

_set_prompt () {
    PROMPT="$(_prompt_username_host)> %~ >
$(_prompt_git)> ";
    RPROMPT="";
}

# Hook to refresh the prompt each time it needs to be rendered.
precmd() {
   _set_prompt;
}

_set_prompt
