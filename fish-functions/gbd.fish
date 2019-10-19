# Defined in - @ line 1
function gbd --description 'alias gbd=git branch --delete'
	git branch --delete $argv;
end
