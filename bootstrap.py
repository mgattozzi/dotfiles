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
            os.system("curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg")
            os.system("echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list")
            os.system("sudo apt-get upgrade && sudo apt-get install wezterm-nightly")
    # TODO: Symlink configs

def windows_install():
    if shutil.which("rust") is None:
        rust = "rustup-init.ext"
        res = httpx.get("https://win.rustup.rs/x86_64")
        with open(rust, 'ab') as out:
            out.write(res.content)
        os.system(rust)
        Path(rust).unlink()
    if shutil.which("carapace") is None:
        os.system("winget install -e --id rsteube.Carapace")
    if shutil.which("wezterm") is None:
        os.system("winget install wez.wezterm")
    # TODO: Symlink configs

def universal_install():
    if shutil.which("cargo-binstall") is None:
        os.system("cargo install --locked --force cargo-binstall")
    os.system(
        "cargo binstall jj-cli topgrade cargo-update git-cliff cargo-deny bat cargo-dist cargo-hakari cargo-nextest oranda difftastic ripgrep starship atuin zoxide nu_plugin_polars --force --locked --disable-telemetry -y"
    )

if sys.platform == "darwin" or sys.platform == "linux":
    unix_install()
else:
    windows_install()

universal_install()

