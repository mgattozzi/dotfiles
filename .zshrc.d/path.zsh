## Path Env Var
function p() {
  export PATH=$PATH:$1
}
p $HOME/.bin
p $HOME/.cargo/bin
p $HOME/.local/bin
p /usr/bin
p /usr/local/bin
