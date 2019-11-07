source ~/anaconda3/etc/fish/conf.d/conda.fish
set -gx ERL_AFLAGS "-kernel shell_history enabled"
set -gx PATH $PATH ~/.yarn/bin/
set -gx PATH $PATH ~/.gem/ruby/2.6.0/bin
set -gx PATH $PATH ~/go/bin/
set -gx GOPATH $HOME/go

# Doesn't work in konsole
# Works in other terms, but none of those support
# Iosevka ligatures.. :(
#
# if status --is-interactive
#     set BASE16_SHELL "$HOME/.config/base16-shell/"
#     source "$BASE16_SHELL/profile_helper.fish"
# end
