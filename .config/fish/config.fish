# Add custom paths to $PATH env
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.local/share/JetBrains/Toolbox/scripts"
fish_add_path "$HOME/.scripts/git"

# Editor settings
set -gx VISUAL "nvim"
set -gx EDITOR "$VISUAL"
set -gx LESS "-R"

# Envs
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx Z_DATA "$HOME/.z"

# Setup PNPM
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path "$PNPM_HOME"

# Aliases
alias ls="eza -lag --header --icons --git"
alias cat="bat"
alias df="duf"
alias vim="nvim"
alias tmux="tmux -2"
alias cloc="tokei"
alias locate="lolcate"

# Abbreviations
abbr --add config --position anywhere --set-cursor "~/.config/%"
abbr --add !! --position command --function sudo_last_cmd
abbr --add bench --position command --set-cursor "hyperfine %"
abbr --add benchmark --position command --set-cursor "hyperfine %"

# Setup thefuck aliases
thefuck --alias | source

# Load rtx (asdf rust clone)
rtx activate fish | source

# Load corepack (package manager for Node.js package managers)
corepack enable

# Load zoxide (smarter cd)
zoxide init fish | source

# Load mcfly (better shell history)
mcfly init fish | source

# TabTab source for packages
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# Setup PNPM

# Load 1password plugins
source /home/zakku/.config/op/plugins.sh
source /home/zakku/.op/plugins.sh

# Start starship prompt
starship init fish | source
