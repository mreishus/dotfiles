if test -e ~/anaconda3/etc/fish/conf.d/conda.fish
    source ~/anaconda3/etc/fish/conf.d/conda.fish
end

set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx PATH $PATH ~/.yarn/bin/
set -gx PATH $PATH ~/.cargo/bin/
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

# ssh-agent integration
if test -z (pgrep -u (whoami) ssh-agent)
    echo Starting ssh-agent..
    eval (ssh-agent -c)
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
else
    if test -e $XDG_RUNTIME_DIR/ssh-agent.socket
        #echo ssh-agent already running, guessing SSH_AUTH_SOCK
        set -Ux SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
    else
        # This makes SCP fail!
        # echo !!! ssh-agent is running, but we can\'t find it
    end
end

# eval (direnv hook fish)
#fzf_key_bindings


function zt6
    # Query the current number of tabs and count them
    set -l current_tab_count (zellij action query-tab-names | wc -l)

    # Calculate how many tabs need to be created to have 6
    set -l tabs_to_create (math "6 - $current_tab_count")

    # If we need to create tabs (tabs_to_create > 0), do so
    if test $tabs_to_create -gt 0
        for i in (seq $tabs_to_create)
            zellij action new-tab
        end
    end
end

function zt9
    # Query the current number of tabs and count them
    set -l current_tab_count (zellij action query-tab-names | wc -l)

    # Calculate how many tabs need to be created to have 6
    set -l tabs_to_create (math "9 - $current_tab_count")

    # If we need to create tabs (tabs_to_create > 0), do so
    if test $tabs_to_create -gt 0
        for i in (seq $tabs_to_create)
            zellij action new-tab
        end
    end
end

if status is-interactive
    if type -q zellij
        zellij setup --generate-completion fish | source
    end
    if type -q zoxide
        zoxide init fish --cmd j | source
    end
    if type -q borgmatic
        borgmatic --fish-completion | source
    end
end
