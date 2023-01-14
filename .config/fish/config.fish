# Configure "z"
set -U Z_DATA "$HOME/.z"

# Add custom paths to $PATH env
fish_add_path "$HOME/.local/bin"

# Disable greeting
set fish_greeting

# Bind Ctrl+S to append sudo
bind \cs '__ethp_commandline_toggle_sudo.fish'

# Envs
set -U EDITOR "nvim"
set -U XDG_CONFIG_HOME "$HOME/.config/"

# Aliases
alias ls="exa -lag --header"
alias cat="bat"
alias vim="nvim"
alias tmux="tmux -2"

# Load asdf
# source /opt/asdf-vm/asdf.fish

# Setup JAVA_HOME
# source $HOME/.asdf/plugins/java/set-java-home.fish

# Start starship prompt
starship init fish | source

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# pnpm
set -gx PNPM_HOME "/home/zakku/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
