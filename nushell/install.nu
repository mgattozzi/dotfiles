const lock_file = '/home/michael/.config/nushell/install.lock'

export def main [] {
  if ($lock_file | path exists) {
    return
  }

  if (which rustup | is-empty) {
    curl https://sh.rustup.rs -sSf | sh
  }

  if (which cargo-binstall | is-empty) {
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  }

  if (which mise | is-empty) {
    curl https://mise.run | sh
  }
  cargo-binstall --locked atuin bat cargo-audit cargo-deny cargo-expand cargo-hakari cargo-insta cargo-nextest cargo-semver-checks cargo-udeps difftastic cargo-dist fd-find jj-cli just nu_plugin_polars nu_plugin_skim ripgrep sd sqlx-cli starship tokei topgrade xh zoxide

  /home/michael/.local/bin/mise install carapace erlang gleam go npm node elixir deno
  let mise_path = $nu.default-config-dir | path join mise.nu
  /home/michael/.local/bin/mise activate nu | save $mise_path --force

  touch $lock_file
}

export def clear-install-lockfile [] {
  rm $lock_file
}
