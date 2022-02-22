# Environment Variables
export EDITOR='nvim'
export PAGER='less'
export TERM=xterm-256color
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
