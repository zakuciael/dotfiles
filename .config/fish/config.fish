# Configure "z"
set -U Z_DATA "$HOME/.z"

# Add custom paths to $PATH env
fish_add_path "$HOME/.local/bin"

# Disable greeting
set fish_greeting

# Bind Ctrl+S to append sudo
bind \cs '__ethp_commandline_toggle_sudo'

# Envs
set -U EDITOR "nvim"
set -U XDG_CONFIG_HOME "$HOME/.config/"

# Aliases
alias ls="exa -lag --header --icons --git"
alias cat="bat"
alias vim="nvim"
alias tmux="tmux -2"

# Load rtx (asdf rust clone)
rtx activate fish | source

# Load zoxide (smarter cd)
zoxide init fish | source

# Load mcfly (better shell history)
mcfly init fish | source

# TabTab source for packages
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# Setup PNPM
set -gx PNPM_HOME "/home/zakku/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# Load 1password plugins
source /home/zakku/.config/op/plugins.sh
source /home/zakku/.op/plugins.sh

# Start starship prompt
starship init fish | source
