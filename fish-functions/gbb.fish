function gbb --description 'show recent branches'
    # Show recent branches
    #git for-each-ref refs/heads --color=always --sort -committerdate --format='%(HEAD)%(color:reset);%(color:yellow)%(refname:short)%(color:reset);%(contents:subject);%(color:green)(%(committerdate:relative))%(color:blue);<%(authorname)>' | column -t -s ';' | cut -c-$COLUMNS

    # Show recent branches, and checkout one using FZF
    git checkout (git for-each-ref refs/heads --color=always --sort -committerdate --format='%(HEAD)%(color:reset);%(color:yellow)%(refname:short)%(color:reset);%(contents:subject);%(color:green)(%(committerdate:relative))%(color:blue);<%(authorname)>' | column -t -s ';' | cut -c-$COLUMNS | fzf --ansi --no-sort --border --height 40% | awk '{print $1}')

    # Bash alias
    # gbs() {
    #     git checkout "$(git for-each-ref refs/heads --color=always --sort -committerdate --format='%(HEAD)%(color:reset);%(color:yellow)%(refname:short)%(color:reset);%(contents:subject);%(color:green)(%(committerdate:relative))%(color:blue);<%(authorname)>' | column -t -s ';' | cut -c-$COLUMNS | fzf --ansi --no-sort --border --height 40% | awk '{print $1}')"
    # }
end
