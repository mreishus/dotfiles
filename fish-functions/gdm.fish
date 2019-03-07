# Defined in - @ line 1
function gdm --description 'alias gdm=git ls-files --modified'
	git ls-files --modified $argv;
end
