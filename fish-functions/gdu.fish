# Defined in - @ line 1
function gdu --description 'alias gdu=git ls-files --other --exclude-standard'
	git ls-files --other --exclude-standard $argv;
end
