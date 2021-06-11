#!/bin/bash
trap "exit" INT;
refreshed=false;

# Check for if the program exists or not
function does_not_exist() {
  ! which "$1" &> /dev/null
}

function install() {
  echo "🔎 Checking if $1 is installed.";
  if does_not_exist "$1"; then
    if [ "$refreshed" == "false" ]; then
      $update &> /dev/null;
      refreshed=true;
    fi
    echo "❌ $1 is not installed. Installing.";
    $install "$1" &> /dev/null;
    echo "✔️ $1 is  installed.";
  else
    echo "✔️ $1 is already installed. Skipping.";
  fi
}

function cargo_install() {
  # Sometimes the name of the program is not the name of the binary
  # Handle that by checking for a second value to use for the display
  # name, but use the first one as the install name
  if [ -z "$2" ]; then
    prog=$1;
  else
    prog=$2;
  fi
  echo "🔎 Checking if $prog is installed."
  if does_not_exist "$prog"; then
    if [ "$refreshed" == "false" ]; then
      $update;
      refreshed=true;
    fi
    echo "❌ $prog is not installed. Installing."
    cargo install "$1" &> /dev/null;
    echo "✔️ $prog is installed.";
  else
    echo "✔️ $prog is already installed. Skipping.";
  fi
}

function install_neovim() {
  echo "🔎 Checking if neovim is installed.";
  if does_not_exist "nvim"; then
    if [ "$refreshed" == "false" ]; then
      $update;
      refreshed=true;
    fi
    echo "❌ neovim is not installed. Installing.";
    if [ "$operating_system" == "Arch Linux" ]; then
      cd yay || exit;
      makepkg --syncdeps &> /dev/null;
      yes | makepkg --install &> /dev/null;
      yay -Syy neovim-nightly-bin &> /dev/null;
      cd - || exit;
    elif [ "$operating_system" == "Ubuntu" ]; then
      sudo add-apt-repository ppa:neovim-ppa/unstable;
      sudo apt-get update;
      sudo apt-get install neovim;
    else
      echo Unsupported OS for dotfiles;
      exit 1;
    fi
    echo "✔️ neovim is installed.";
  else
    echo "✔️ neovim is already installed. Skipping.";
  fi
}

# Get the operating system on so that commands that differ can be carried out
operating_system=$(cat < /etc/os-release | head -n 1 | cut -d= -f 2 | cut -d'"' -f2);

if [ "$operating_system" == "Arch Linux" ]; then
  install="sudo pacman --noconfirm -S";
  update="sudo pacman -Syy";
  # Hack way to check if base-devel is installed
  ls /usr/sbin/make &> /dev/null
  out=$?
  if [ $out -ne 0 ]; then
    install "base-devel";
    install "openssl";
  fi
elif [ "$operating_system" == "Ubuntu" ]; then
  install="sudo apt-get -y install";
  update="sudo apt-get update";
  dpkg -l build-essential &> /dev/null;
  out=$?;
  if [ $out -ne 0 ]; then
    install "build-essential";
    install "libssl-dev";
  fi
else
  echo Unsupported OS for dotfiles;
  exit 1;
fi

# Try Arch package name and then Ubuntu package name if there is a failure
# If they have the same name then just use the one command
install "git";
git submodule update --recursive --init;
install "zsh";
install "tmux";
install "wget";
install "curl";
install "jq";
install "bmake";
install "cmake";
install "autoconf";
install_neovim;
zsh_location="/bin/zsh";
current_shell="$(cat < /etc/passwd | grep "$USER" | cut -d':' -f 7)";

if [ "$zsh_location" != "$current_shell" ]; then
  sudo chsh -s "$zsh_location" "$USER";
fi

# Install Rust programs
if does_not_exist "rustup"; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;
  rustup install stable &> /dev/null;
  rustup target add wasm32-wasi &> /dev/null;
  rustup target add wasm32-unknown-unknown &> /dev/null;
  rustup component add rustfmt &> /dev/null;
  rustup component add rust-src &> /dev/null;
fi

cargo_install "exa";
cargo_install "fd-find" "fd";
cargo_install "starship";
cargo_install "ripgrep" "rg";

echo "🔎 Checking if rust-analyzer is installed.";
if does_not_exist "rust-analyzer"; then
  echo "❌ rust-analyzer is not installed. Installing.";
  cd rust-analyzer || exit;
  cargo xtask install --server
  cd - || exit
  echo "✔️ rust-analyzer is installed.";
else
  echo "✔️ rust-analyzer is already installed. Skipping.";
fi

mkdir -p "$HOME/.config";
config_dir=$(pwd);
cd "$HOME/.config" || exit;
if [ ! -d base16-shell ]; then
  ln -s "$config_dir/base16-shell" .;
fi

if [ ! -d nvim ]; then
  ln -s "$config_dir/nvim" .
  git clone https://github.com/wbthomason/packer.nvim \
    "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim";
  nvim --headless +PackerInstall +q &> /dev/null;
fi
cd "$config_dir" || exit;

touch "$HOME/.work.zsh";
touch "$HOME/.private.zsh";
cd "$HOME" || exit;
if [ ! -d .zshrc.d ]; then
  ln -s "$config_dir/.zshrc.d" .
fi
if [ ! -d .fzf ]; then
  ln -s "$config_dir/fzf" .fzf
  # Install fzf
  cd .fzf || exit;
  ./install --bin &> /dev/null;
  cd .. || exit;
fi
if [ ! -f .zshrc ]; then
  ln -s "$config_dir/.zshrc" .
fi
if [ ! -f .zshenv ]; then
  ln -s "$config_dir/.zshenv" .
fi
if [ ! -f .zprofile ]; then
  ln -s "$config_dir/.zprofile" .
fi
if [ ! -f .gitconfig ]; then
  ln -s "$config_dir/.gitconfig" .
fi
if [ ! -f .tmux.conf ]; then
  ln -s "$config_dir/.tmux.conf" .
fi
rm -rf .bash* &> /dev/null;
