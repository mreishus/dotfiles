# Defined in - @ line 1
function gSu --description 'alias gSu=git submodule foreach git pull origin master'
	git submodule foreach git pull origin master $argv;
end
