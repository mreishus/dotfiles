# Defined in - @ line 1
function gfcr --description 'alias gfcr=git clone --recurse-submodules'
	git clone --recurse-submodules $argv;
end
