# Defined in - @ line 1
function gdc --description 'alias gdc=git ls-files --cached'
	git ls-files --cached $argv;
end
