$env.config = {
  show_banner: false,
}

# If not in tmux start it up and if we're in tmux skip
if $env.TMUX? == null {
  if (tmux attach -t default | complete | get exit_code) != 0 {
    tmux new -s eva00
  }
}

ulimit -n 4096

## Alias hx for muscle memory reasons
alias vi = hx
alias vim = hx
alias vimf = hx (fzf)

alias fg = job unfreeze

# Setup Starship Prompt
source ~/.cache/starship/init.nu

# Setup Carapace Autocomplete
source ~/.cache/carapace/init.nu

# Setup Atuin History Search
source ~/.local/share/atuin/init.nu

# Setup zoxide
source ~/.config/nushell/zoxide.nu
