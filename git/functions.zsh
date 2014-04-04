#
# A collection of functions for working with a git repository.
#

_is_git_dirty() {
    st=$(git st 2>/dev/null | tail -n 1)
    if [[ $st == "" ]]
    then
        echo "false";
    else
        if [[ $st == "nothing to commit (working directory clean)" ]]
        then
            echo "false";
        else
            echo "true";
        fi;
    fi;
}

_git_root () {
    echo $(git rev-parse --show-toplevel 2>/dev/null);
}

_is_git_repo () {
    if [[ "$(_git_root)" == "" ]]; then
        echo "false";
    else
        echo "true";
    fi;
}

_git_branch () {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return "";
    echo "${ref#(refs/heads/|tags/)}";
}
