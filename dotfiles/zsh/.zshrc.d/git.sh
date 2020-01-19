#!/bin/bash
alias delete_remotely_deleted_git_branches="LANG=en git branch -vv | grep ': gone]'|  grep -v '\*' | awk '{ print $1; }' | xargs -r git branch -d"
