# Defined in - @ line 1
function gdx --description 'alias gdx=git ls-files --deleted'
	git ls-files --deleted $argv;
end
