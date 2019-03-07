# Defined in - @ line 1
function gcf --description 'alias gcf=git commit --amend --reuse-message HEAD'
	git commit --amend --reuse-message HEAD $argv;
end
