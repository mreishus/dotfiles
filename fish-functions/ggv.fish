# Defined in - @ line 1
function ggv --description 'alias ggv=git grep --invert-match'
	git grep --invert-match $argv;
end
