# Defined in - @ line 1
function giD --description 'alias giD=git diff --no-ext-diff --cached --word-diff'
	git diff --no-ext-diff --cached --word-diff $argv;
end
