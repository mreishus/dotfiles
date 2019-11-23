if test -e ~/anaconda3/etc/fish/conf.d/conda.fish
    source ~/anaconda3/etc/fish/conf.d/conda.fish
end

set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx PATH $PATH ~/.yarn/bin/
set -gx PATH $PATH ~/.gem/ruby/2.6.0/bin
set -gx PATH $PATH ~/go/bin/
set -gx GOPATH $HOME/go

# Set GPG TTY
set -x GPG_TTY (tty)


## Run AutoJump if it exists (Ubuntu)

begin
    set --local AUTOJUMP_PATH_UBUNTU /usr/share/autojump/autojump.fish
        if test -e $AUTOJUMP_PATH_UBUNTU
        source $AUTOJUMP_PATH_UBUNTU
    end
end

# https://t.co/R7mbz1kEmI?amp=1

# Doesn't work in konsole
# Works in other terms, but none of those support
# Iosevka ligatures.. :(
#
# if status --is-interactive
#     set BASE16_SHELL "$HOME/.config/base16-shell/"
#     source "$BASE16_SHELL/profile_helper.fish"
# end

# Bootstrap Fisher package manager
# https://github.com/jorgebucaran/fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# fisher add evanlucas/fish-kubectl-completions
