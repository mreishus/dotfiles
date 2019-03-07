# Defined in - @ line 1
function gdk --description 'alias gdk=git ls-files --killed'
	git ls-files --killed $argv;
end
