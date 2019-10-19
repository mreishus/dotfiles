# Defined in - @ line 1
function ggL --description 'alias ggL=git grep --files-without-matches'
	git grep --files-without-matches $argv;
end
