#!/bin/bash

function delete_stale_branches {
    force=false
    while getopts "f" opt; do
        case ${opt} in
        f)
            force=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" 1>&2
            ;;
        esac
    done
    shift $((OPTIND - 1))
    command_args="-d"
    if [ "$force" = true ]; then
        echo "Forcing dangling branches deletion"
        command_args="-D"
    fi
    git fetch -p
    candidate_branches=$(git branch -vv | awk '/: desaparecido]/{print $1}')
    if [ -z "$candidate_branches" ]; then
        echo "No dangling branches to delete"
    else
        echo "$candidate_branches" | xargs git branch ${command_args}
    fi
}

function prune {
    git gc --aggressive --prune=all
}

function parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}