# Defined in - @ line 1
function gid --description 'alias gid=git diff --no-ext-diff --cached'
	git diff --no-ext-diff --cached $argv;
end
