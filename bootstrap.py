#!/usr/bin/env -S uv run

# /// script
# requires-python = ">=3.12"
# dependencies = ["httpx == 0.27.0"]
# ///

import httpx
import os
from pathlib import Path
import shutil
import sys


def unix_install():
    if shutil.which("rust") is None:
        os.system("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh")
    if shutil.which("carapace") is None:
        os.system("curl termux.carapace.sh | sh")
    if shutil.which("wezterm") is None:
        if sys.platform == "darwin":
            os.system("brew install --cask wezterm")
        else:
            os.system(
                "curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg"
            )
            os.system(
                "echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list"
            )
            os.system("sudo apt-get upgrade && sudo apt-get install wezterm-nightly")


def windows_install():
    if shutil.which("rust") is None:
        rust = "rustup-init.ext"
        res = httpx.get("https://win.rustup.rs/x86_64")
        with open(rust, "ab") as out:
            out.write(res.content)
        os.system(rust)
        Path(rust).unlink()
    if shutil.which("carapace") is None:
        os.system("winget install -e --id rsteube.Carapace")
    if shutil.which("wezterm") is None:
        os.system("winget install wez.wezterm")


def src(name: str):
    if sys.platform == "darwin" or sys.platform == "linux":
        return Path("/home/michael/dotfiles/" + name)
    else:
        # TODO: Symlink on windows
        pass


def dst(name: [str]):
    if sys.platform == "darwin" or sys.platform == "linux":
        return Path("/home/michael/" + name)
    else:
        # TODO: Symlink on windows
        pass


# TODO: Symlink on windows
def symlink(dirs: [str], files: [(str, str)]):
    for dir in dirs:
        os.makedirs(name=dst(dir), exist_ok=True)
    for src_path, dst_path in files:
        dst_path = dst(dst_path)
        # Remove the file if it already exists so we can link the actual file we
        # want to the config location
        dst_path.unlink(missing_ok=True)
        os.symlink(src=src(src_path), dst=dst_path)


def universal_install():
    if shutil.which("cargo-binstall") is None:
        os.system("cargo install --locked --force cargo-binstall")
    os.system(
        "cargo binstall jj-cli topgrade cargo-update git-cliff cargo-deny bat cargo-dist cargo-hakari cargo-nextest oranda difftastic ripgrep starship atuin zoxide nu_plugin_polars --force --locked --disable-telemetry -y"
    )


if sys.platform == "darwin" or sys.platform == "linux":
    unix_install()
    symlink(
        # Directories to create if they don't exist relative to home dir
        [".config/nushell", ".config/helix"],
        # (Dotfile relaive path, home dir relative path)
        [
            ("nushell/config.nu", ".config/nushell/config.nu"),
            ("nushell/env.nu", ".config/nushell/env.nu"),
            ("helix/config.toml", ".config/helix/config.toml"),
            ("helix/languages.toml", ".config/helix/languages.toml"),
            ("wezterm.lua", ".wezterm.lua"),
            ("topgrade.toml", ".config/topgrade.toml"),
            ("gitconfig", ".gitconfig"),
            ("lesskey", ".lesskey"),
            ("tmux.conf", ".tmux.conf"),
            ("tmux.conf", ".tmux.conf"),
        ],
    )
else:
    windows_install()
    symlink([], [])

universal_install()
