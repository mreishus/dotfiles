function gbfX --description 'delete all local branches that do not exist on remote; dry run'
    git pull && git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}';
end
