# Defined in - @ line 1
function ggl --description 'alias ggl=git grep --files-with-matches'
	git grep --files-with-matches $argv;
end
