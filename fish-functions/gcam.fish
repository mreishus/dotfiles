# Defined in - @ line 1
function gcam --description 'alias gcam=git commit --all --message'
	git commit --all --message $argv;
end
