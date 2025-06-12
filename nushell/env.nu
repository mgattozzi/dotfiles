$env.PATH = [
  ($env.HOME | path join .cargo bin),
  ($env.HOME | path join .local bin),
  ($env.HOME | path join .bin),
  ($env.HOME | path join .claude local),
  /usr/bin
  /usr/games
  /usr/local/bin
  /usr/local/games
  /usr/local/sbin
  /usr/sbin
  /snap/bin
  /bin
  /sbin
]
$env.EDITOR = 'hx'
$env.PAGER = 'less'
$env.TERM = 'xterm-256color'
$env.XDG_RUNTIME_DIR = "/run/user/" + (id -u)
$env.RUST_SRC_PATH = $"(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src"
$env.config.display_errors.exit_code = false
$env.config.display_errors.termination_signal = false

# Install Shell Programs
## Setup Starship Prompt
if (which starship | is-not-empty) {
  starship init nu | save -f ~/.cache/starship/init.nu
} else {
  cargo binstall starship
  mkdir ~/.cache/starship
  starship init nu | save -f ~/.cache/starship/init.nu
}

## Setup Carapace Autocomplete
if (which carapace | is-not-empty) {
  carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
} else {
  "deb [trusted=yes] https://apt.fury.io/rsteube/ /" | save temp
  sudo mv temp /etc/apt/sources.list.d/fury.list
  sudo apt-get update
  sudo apt-get install carapace-bin
  mkdir ~/.cache/carapace
  carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
}

## Setup Atuin History Search
if (which atuin | is-not-empty) {
  atuin init nu --disable-up-arrow | save -f ~/.local/share/atuin/init.nu
} else {
  cargo binstall atuin
  atuin import auto
  mkdir ~/.local/share/atuin/
  atuin init nu --disable-up-arrow | save -f ~/.local/share/atuin/init.nu
}

## Setup zoxide
if (which zoxide | is-not-empty) {
  zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
} else {
  cargo binstall zoxide
  zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
}

# Setup plugins

## Setup Polars
if (which polars | is-empty) {
  plugin add '/home/michael/.cargo/bin/nu_plugin_polars'
  plugin use polars
}
