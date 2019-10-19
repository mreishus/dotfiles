# Defined in - @ line 1
function gls --description 'alias gls=git log --topo-order --stat --pretty=format:"$_git_log_medium_format"'
	set -l _git_log_medium_format '%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
	set -l _git_log_oneline_format '%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
	set -l _git_log_brief_format '%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'
	git log --topo-order --stat --pretty=format:"$_git_log_medium_format" $argv;
end
