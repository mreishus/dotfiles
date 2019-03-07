# Defined in - @ line 1
function gcsS --description 'alias gcsS=git show --pretty=short --show-signature'
	git show --pretty=short --show-signature $argv;
end
