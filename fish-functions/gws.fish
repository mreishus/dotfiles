# Defined in - @ line 1
function gws --description 'alias gws=git status --ignore-submodules=none --short'
	git status --ignore-submodules=none --short $argv;
end
