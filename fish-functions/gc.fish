# Defined in - @ line 1
function gc --description 'alias gc=git commit --verbose'
	env TZ=UTC0 git commit --verbose $argv;
end
