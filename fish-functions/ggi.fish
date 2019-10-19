# Defined in - @ line 1
function ggi --description 'alias ggi=git grep --ignore-case'
	git grep --ignore-case $argv;
end
