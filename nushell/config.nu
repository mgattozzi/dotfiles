$env.config = {
  show_banner: false,
}

# If not in tmux start it up and if we're in tmux skip
if $env.TMUX? == null {
  if (tmux attach -t default | complete | get exit_code) != 0 {
    tmux new -s default
  }
}

ulimit -n 4096

## Neovim Aliases
alias nedit = nvim ($env.HOME | path join .config nvim init.lua)
alias rmswap = rm ($env.HOME | path join .local share nvim swap *)
alias vi = nvim
alias vim = nvim
alias vimf = nvim (fzf)

## Ubuntu
alias clip = xclip -sel clip

## WSL2
alias pbcopy = /mnt/c/Windows/System32/clip.exe

# Setup Starship Prompt
source ~/.cache/starship/init.nu

# Setup Carapace Autocomplete
source ~/.cache/carapace/init.nu

# Setup Atuin History Search
source ~/.local/share/atuin/init.nu

# Setup zoxide
source ~/.config/nushell/zoxide.nu
