# Defined in - @ line 1
function gcSf --description 'alias gcSf=git commit -S --amend --reuse-message HEAD'
	git commit -S --amend --reuse-message HEAD $argv;
end
