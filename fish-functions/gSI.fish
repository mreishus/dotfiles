# Defined in - @ line 1
function gSI --description 'alias gSI=git submodule update --init --recursive'
	git submodule update --init --recursive $argv;
end
