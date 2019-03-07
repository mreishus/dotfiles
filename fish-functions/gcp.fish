# Defined in - @ line 1
function gcp --description 'alias gcp=git cherry-pick --ff'
	git cherry-pick --ff $argv;
end
