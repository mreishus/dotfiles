# Defined in - @ line 1
function glc --description 'alias glc=git shortlog --summary --numbered'
	git shortlog --summary --numbered $argv;
end
