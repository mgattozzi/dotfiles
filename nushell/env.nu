$env.PATH = [
  ($env.HOME | path join .cargo bin),
  ($env.HOME | path join .local bin),
  ($env.HOME | path join .bin),
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
$env.EDITOR = 'nvim'
$env.PAGER = 'less'
$env.TERM = 'xterm-256color'
$env.XDG_RUNTIME_DIR = /run/user/(id -u)

# Install Rust
if (which rustup | is-empty) {
  http get -r https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init o> rustup-init
  chmod +x rustup-init
  ./rustup-init
  rm rustup-init
}

$env.RUST_SRC_PATH = $"(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src"

# Install rust programs
if (which cargo-binstall | is-empty) {
  cargo install --locked cargo-binstall
}

if (which cargo-install-update | is-empty) {
  cargo binstall cargo-update
}

if (which topgrade | is-empty) {
  cargo binstall topgrade
}

if (which jj | is-empty) {
  cargo binstall --strategies crate-meta-data jj-cli
}

if (which git-cliff | is-empty) {
  cargo binstall git-cliff
}

if (which cargo-deny | is-empty) {
  cargo binstall cargo-deny
}

if (which bat | is-empty) {
  cargo binstall bat
}

if (which cargo-dist | is-empty) {
  cargo binstall cargo-dist
}

if (which cargo-hakari | is-empty) {
  cargo binstall cargo-hakari
}

if (which cargo-nextest | is-empty) {
  cargo binstall cargo-nextest
}

if (which oranda | is-empty) {
  cargo binstall oranda
}

if (which alacritty | is-empty) {
  cargo binstall alacritty
}

if (which difft | is-empty) {
  cargo binstall difftastic
}

if (which rg | is-empty) {
  cargo binstall ripgrep
}

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

# Install and setup plugins

## Setup Polars
if (which polars | is-empty) {
  cargo binstall nu_plugin_polars
  plugin add ~/.cargo/bin/nu_plugin_polars 
  plugin use polars
}
