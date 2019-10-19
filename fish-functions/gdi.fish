# Defined in - @ line 1
function gdi --description 'alias gdi=git status --porcelain --short --ignored | sed -n "s/^!! //p"'
	git status --porcelain --short --ignored | sed -n "s/^!! //p" $argv;
end
