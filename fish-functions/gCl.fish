# Defined in - @ line 1
function gCl --description 'alias gCl=git --no-pager diff --name-only --diff-filter=U'
	git --no-pager diff --name-only --diff-filter=U $argv;
end
