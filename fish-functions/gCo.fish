# Defined in - @ line 1
function gCo --description 'alias gCo=git checkout --ours --'
	git checkout --ours -- $argv;
end
