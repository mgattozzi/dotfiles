# Check for if the program exists or not
function does_not_exist() {
  ! which "$1" &> /dev/null
}

function symlink_file() {
  echo "🔎 Checking if $1 is symlinked.";
  if [ ! -f $1 ]; then
    echo "❌ $1 is not symlinked. Symlinking.";
    ln -s "$config_dir/$1" .
    echo "✔️  $1 is symlinked.";
  else
    echo "✔️ $1 is already  symlinked. Skipping.";
  fi
}

function symlink_dir() {
  echo "🔎 Checking if $1 is symlinked.";
  if [ ! -d $1 ]; then
    echo "❌ $1 is not symlinked. Symlinking.";
    ln -s "$config_dir/$1" .
    echo "✔️ $1 is symlinked.";
    if [ "$#" -eq 2 ]; then
      echo "🏃 Running install step for $1";
      $2;
    fi
  else
    echo "✔️ $1 is already  symlinked. Skipping.";
  fi
}

config_dir=$(pwd);
mkdir -p "$HOME/.config";
cd "$HOME/.config" || exit;
symlink_dir "base16-shell";
symlink_dir "nvim" install_neovim_deps;

cd "$HOME" || exit;
# We just want to make sure these files are here. We'll actually will them with
# aliases and secrets over time
symlink_dir ".zshrc.d";
touch "$HOME/.zshrc.d/work.zsh";
touch "$HOME/.zshrc.d/private.zsh";
symlink_file ".zshrc";
symlink_file ".zshenv";
symlink_file ".zprofile";
symlink_file ".gitconfig";
symlink_file ".tmux.conf";
symlink_file ".lesskey";
if [ ! -f "$HOME/.less" ]; then
  lesskey $HOME/.lesskey
fi
