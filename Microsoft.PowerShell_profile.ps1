# To find out where this should be placed:
# echo $profile
# For me, it's C:\Users\matt\Documents\WindowsPowerShell

# To enable running of unsigned scripts:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

$HOMEDRIVE = "C:\"
$HOMEPATH = "Users\" + $env:username
$Env:HOME = $HOMEDRIVE + $HOMEPATH

# Set and force overwrite of the $HOME variable
Set-Variable HOME "$HOMEDRIVE$HOMEPATH" -Force

# Set the "~" shortcut value for the FileSystem provider
(get-psprovider 'FileSystem').Home = $HOMEDRIVE + $HOMEPATH

#Import-Module "Oh-My-Posh" -DisableNameChecking -NoClobber
#Import-Module PSColor
#Import-Module Posh-Git

Import-Module PSReadline
Set-PSReadlineOption -EditMode Emacs

Set-Alias show Get-ChildItem

#Import-Module bookmarks.psm1
#Set-Alias gg Invoke-Bookmark
#Set-Bookmark abc "C:\dev\test\test"

# Git
function g { git $args }

# Branch (b)
function gb { git branch $args }
function gbc { git checkout -b $args }
function gbl { git branch -v $args }
function gbL { git branch -av $args }
function gbx { git branch -d $args }
#function gbX { git branch -D $args }
function gbm { git branch -m $args }
#function gbM { git branch -M $args }
function gbs { git show-branch $args }
#function gbS { git show-branch -a $args }

# Commit (c)
#function gc { git commit --verbose $args } #Get-Content .. 
function gcc { git commit --verbose $args } #Get-Content .. 
function gca { git commit --verbose --all $args }
#function gcm { git commit --message $args } #Get-Command
function gcmm { git commit --message $args }
function gco { git checkout $args }
#function gcO { git checkout --patch $args }
function gcf { git commit --amend --reuse-message HEAD $args }
#function gcF { git commit --verbose --amend $args }
function gcp { git cherry-pick --ff $args }
#function gcP { git cherry-pick --no-commit $args }
function gcr { git revert $args }
#function gcR { git reset "HEAD^" $args }
function gcs { git show $args }
function gcl { git-commit-lost $args }

# Conflict (C)
# 
#function gCl { git status | sed -n "s/^.*both [a-z]*ed: *//p" }
#function gCa { git add $(gCl) }
#function gCe { git mergetool $(gCl) }
#function gCo { git checkout --ours -- }
#function gCO { gCo $(gCl) }
#function gCt { git checkout --theirs -- }
#function gCT { gCt $(gCl) }

# Data (d)
function gd { git ls-files $args }
function gdc { git ls-files --cached $args }
function gdx { git ls-files --deleted $args}
function gdm { git ls-files --modified $args}
function gdu { git ls-files --other --exclude-standard $args }
function gdk { git ls-files --killed $args }
function gdi { git status --porcelain --short --ignored | sed -n "s/^!! //p" }

# Fetch (f)
function gf { git fetch $args}
function gfc { git clone $args}
function gfm { git pull $args}
function gfr { git pull --rebase $args}

# Grep (g)
function gg { git grep $args }
function ggi { git grep --ignore-case $args }
function ggl { git grep --files-with-matches $args }
function ggL { git grep --files-without-matches $args }
function ggv { git grep --invert-match $args }
function ggw { git grep --word-regexp $args }

# Index (i)
function gia { git add $args}
#function giA { git add --patch $args }
function giu { git add --update $args }
function gid { git diff --no-ext-diff --cached $args }
#function giD { git diff --no-ext-diff --cached --word-diff $args }
function gir { git reset $args }
#function giR { git reset --patch $args }
function gix { git rm -r --cached $args }
#function giX { git rm -rf --cached $args }

# Log (l)
$_git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
$_git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
$_git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'

#function gl { git log --topo-order --pretty=format:"${_git_log_medium_format}" $args }
function gll { git log --topo-order --pretty=format:"${_git_log_medium_format}" $args }
function gls { git log --topo-order --stat --pretty=format:"${_git_log_medium_format}" $args }
function gld { git log --topo-order --stat --patch --full-diff --pretty=format:"${_git_log_medium_format}" $args }
function glo { git log --topo-order --pretty=format:"${_git_log_oneline_format}" $args }
function glg { git log --topo-order --all --graph --pretty=format:"${_git_log_oneline_format}" $args }
function glb { git log --topo-order --pretty=format:"${_git_log_brief_format}"  $args }
function glc { git shortlog --summary --numbered $args }

# Merge (m)
#function gm { git merge $args } #Get-Member
function gmm { git merge $args }
function gmC { git merge --no-commit $args }
function gmF { git merge --no-ff $args }
function gma { git merge --abort $args }
function gmt { git mergetool $args }

# Push (p)
function gp { git push $args } #Get-ItemProperty
function gpp { git push $args }
function gpf { git push --force $args }
function gpa { git push --all $args }
#function gpA { git push --all && git push --tags }
function gpt { git push --tags $args }
#function gpc { git push --set-upstream origin "$(git-branch-current 2> /dev/null)" $args }
#function gpp { git pull origin "$(git-branch-current 2> /dev/null)" && git push origin "$(git-branch-current 2> /dev/null)" }

# Rebase (r)
function gr { git rebase $args }
function gra { git rebase --abort $args }
function grc { git rebase --continue $args }
function gri { git rebase --interactive $args }
function grs { git rebase --skip $args }

# Remote (R)
function gR { git remote $args }
function gRl { git remote --verbose $args }
function gRa { git remote add $args }
function gRx { git remote rm $args}
function gRm { git remote rename $args}
function gRu { git remote update $args}
function gRp { git remote prune $args}
function gRs { git remote show $args}
function gRb { git-hub-browse $args}

# Stash (s)
function gs { git stash $args}
function gsa { git stash apply $args}
function gsx { git stash drop $args}
function gsX { git-stash-clear-interactive $args}
function gsl { git stash list $args}
function gsL { git-stash-dropped $args}
function gsd { git stash show --patch --stat $args}
function gsp { git stash pop $args}
function gsr { git-stash-recover $args}
function gss { git stash save --include-untracked $args}
function gsS { git stash save --patch --no-keep-index $args}
function gsw { git stash save --include-untracked --keep-index $args}

# Submodule (S)
function gS { git submodule $args}
function gSa { git submodule add $args}
function gSf { git submodule foreach $args}
function gSi { git submodule init $args}
function gSI { git submodule update --init --recursive $args}
function gSl { git submodule status $args}
function gSm { git-submodule-move $args}
function gSs { git submodule sync $args}
function gSu { git submodule foreach git pull origin master $args}
function gSx { git-submodule-remove $args}

# Working Copy (w)
#function gws { git status --ignore-submodules=${_git_status_ignore_submodules} --short }
#function gwS { git status --ignore-submodules=${_git_status_ignore_submodules} }
function gws { git status --short $args}
function gwss { git status $args}
function gwd { git diff --no-ext-diff $args}
#function gwD { git diff --no-ext-diff --word-diff $args}
function gwr { git reset --soft $args}
#function gwR { git reset --hard $args}
function gwc { git clean -n $args}
#function gwC { git clean -f $args}
function gwx { git rm -r $args}
#function gwX { git rm -rf $args}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

chcp 65001