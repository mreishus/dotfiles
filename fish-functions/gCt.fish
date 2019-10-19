# Defined in - @ line 1
function gCt --description 'alias gCt=git checkout --theirs --'
	git checkout --theirs -- $argv;
end
