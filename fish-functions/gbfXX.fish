function gbfXX --description 'delete all local branches that do not exist on remote; do it'
    git pull && git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D;
end
