# Defined in - @ line 1
function gii --description 'alias gii=git update-index --assume-unchanged'
	git update-index --assume-unchanged $argv;
end
