# Defined in - @ line 1
function gb- --description 'recently checked out branches'
    git reflog | egrep -io "moving from ([^[:space:]]+)" | awk '{ print $3 }' | head -n5;
end
