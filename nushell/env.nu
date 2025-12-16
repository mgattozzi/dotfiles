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
$env.TERM = 'tmux-256color'
$env.XDG_RUNTIME_DIR = "/run/user/" + (id -u)
$env.RUST_SRC_PATH = $"(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src"
$env.config.display_errors.exit_code = false
$env.config.display_errors.termination_signal = false
$env.NEXTEST_SHOW_PROGRESS = 'only'

let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force
