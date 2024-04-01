# Defined in - @ line 1
function gca --description 'alias gca=git commit --verbose --all'
	env TZ=UTC0 git commit --verbose --all $argv;
end
