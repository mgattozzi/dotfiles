# Environment Variables
export EDITOR='nvim'
export PAGER='less'
export TERM=xterm-256color
export XDG_RUNTIME_DIR=/run/user/$(id -u)
if [[ -f "$HOME/.cargo/env" ]]; then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
  . "$HOME/.cargo/env"
fi
