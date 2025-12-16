use install.nu *

$env.config = {
  show_banner: false,
}

install

# If not in tmux start it up and if we're in tmux skip
if $env.TMUX? == null {
  if (tmux attach -t code | complete | get exit_code) != 0 {
    tmux new -s code
  }
}

ulimit -n 4096

## Alias hx for muscle memory reasons
alias vi = hx
alias vim = hx
alias vimf = hx (fd | lines |sk)
alias hxf = hx (fd | lines |sk)

alias fg = job unfreeze

# Setup Starship Prompt
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
source ~/.cache/starship/init.nu

# Setup Carapace Autocomplete
mkdir ~/.cache/carapace
carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
source ~/.cache/carapace/init.nu

# Setup Atuin History Search
mkdir ~/.local/share/atuin/
atuin init nu --disable-up-arrow | save -f ~/.local/share/atuin/init.nu
source ~/.local/share/atuin/init.nu

# Setup zoxide
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

use ($nu.default-config-dir | path join mise.nu)

# Setup Plugins
if (plugin list | where name == 'polars' | is-empty) {
  plugin add /home/michael/.cargo/bin/nu_plugin_polars
}

if (plugin list | where name == 'skim' | is-empty) {
  plugin add /home/michael/.cargo/bin/nu_plugin_skim
}

plugin use polars
plugin use skim
