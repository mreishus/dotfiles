# Defined in - @ line 1
function gwS --description 'alias gwS=git status --ignore-submodules=none'
	git status --ignore-submodules=none $argv;
end
