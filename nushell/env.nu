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

if not (which rustup | is-empty) {
  $env.RUST_SRC_PATH = $"(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src"
} else {
  http get -r https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init o> rustup-init
  chmod +x rustup-init
  ./rustup-init
  $env.RUST_SRC_PATH = $"(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src"
  rm rustup-init
}

# Setup Starship Prompt
if not (which starship | is-empty) {
  starship init nu | save -f ~/.cache/starship/init.nu
} else {
  let tag = http get -H { 'Accept': 'application/json' } https://github.com/starship/starship/releases/latest
     | get tag_name
  let name = 'starship-x86_64-unknown-linux-gnu'
  http get -r ('https://github.com/starship/starship/releases/download/' ++ $tag ++ '/' ++ $name ++ '.tar.gz') o> starship.tar.gz
  tar -xvf starship.tar.gz
  sudo mv starship /usr/bin/starship
  rm -rf starship.tar.gz
  mkdir ~/.cache/starship
  starship init nu | save -f ~/.cache/starship/init.nu
}

# Setup Carapace Autocomplete
if not (which starship | is-empty) {
  carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
} else {
  "deb [trusted=yes] https://apt.fury.io/rsteube/ /" | save temp
  sudo mv temp /etc/apt/sources.list.d/fury.list
  sudo apt-get update
  sudo apt-get install carapace-bin
  mkdir ~/.cache/carapace
  carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
}

# Setup Atuin History Search
if not (which atuin | is-empty) {
  atuin init nu --disable-up-arrow | save -f ~/.local/share/atuin/init.nu
} else {
  let tag = http get -H { 'Accept': 'application/json' } https://github.com/atuinsh/atuin/releases/latest
     | get tag_name
  let name = 'atuin-' ++ $tag ++ '-x86_64-unknown-linux-gnu'
  http get -r ('https://github.com/atuinsh/atuin/releases/download/' ++ $tag ++ '/' ++ $name ++ '.tar.gz') o> atuin.tar.gz
  tar -xvf atuin.tar.gz
  sudo mv ($name ++ '/atuin') /usr/bin/atuin
  rm -rf atuin.tar.gz
  rm -rf $name
  atuin import auto
  mkdir ~/.local/share/atuin/
  atuin init nu --disable-up-arrow | save -f ~/.local/share/atuin/init.nu
}

# Setup zoxide
if not (which zoxide | is-empty) {
  zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
} else {
  let tag = http get -H { 'Accept': 'application/json' } https://github.com/ajeetdsouza/zoxide/releases/latest
    | get tag_name 
    | str substring 1..
  http get -r ('https://github.com/ajeetdsouza/zoxide/releases/download/v' ++ $tag ++ '/zoxide_' ++ $tag ++ '-1_amd64.deb') o> zoxide.deb
  sudo apt-get install ./zoxide.deb
  rm zoxide.deb
  zoxide init nushell | save -f ~/.config/nushell/zoxide.nu
}
