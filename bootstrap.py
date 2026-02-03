#!/usr/bin/env -S uv run

# /// script
# requires-python = ">=3.12"
# dependencies = ["rich"]
# ///

import shutil
import subprocess
import sys
from pathlib import Path

from rich.console import Console
from rich.panel import Panel

console = Console()

DOTFILES_DIR = Path(__file__).parent.resolve()
HOME = Path.home()
CONFIG = HOME / ".config"

DIR_SYMLINKS = [
    ("nushell", CONFIG / "nushell"),
    ("helix", CONFIG / "helix"),
    ("jj", CONFIG / "jj"),
    ("mise", CONFIG / "mise"),
]

FILE_SYMLINKS = [
    ("wezterm.lua", HOME / ".wezterm.lua"),
    ("gitconfig", HOME / ".gitconfig"),
    ("lesskey", HOME / ".lesskey"),
    ("tmux.conf", HOME / ".tmux.conf"),
    ("topgrade.toml", CONFIG / "topgrade.toml"),
]


def run(cmd: str, shell: bool = True) -> bool:
    """Run a command and return True if successful."""
    result = subprocess.run(cmd, shell=shell, capture_output=False)
    return result.returncode == 0


def install_tool(name: str, check_cmd: str, install_cmd: str) -> bool:
    """Install a tool if not present. Returns True if successful or already installed."""
    if shutil.which(check_cmd):
        console.print(f"  [green]✓[/green] {name} [dim](already installed)[/dim]")
        return True

    with console.status(f"  [yellow]Installing {name}...[/yellow]"):
        if run(install_cmd):
            console.print(f"  [green]✓[/green] {name}")
            return True
        else:
            console.print(f"  [red]✗[/red] {name} [red](installation failed)[/red]")
            return False


def install_tools() -> bool:
    """Install all required tools. Returns True if all successful."""
    console.print("\n[bold]Installing tools...[/bold]")

    # git (needed for cloning repos like TPM)
    if not install_tool(
        "git",
        "git",
        "sudo apt-get update && sudo apt-get install -y git",
    ):
        return False

    # rustup
    if not install_tool(
        "rustup",
        "rustc",
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y",
    ):
        return False

    # Refresh PATH to find cargo
    cargo_bin = HOME / ".cargo" / "bin"
    if cargo_bin.exists():
        import os
        os.environ["PATH"] = f"{cargo_bin}:{os.environ.get('PATH', '')}"

    # cargo-binstall
    if not install_tool(
        "cargo-binstall",
        "cargo-binstall",
        "curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash",
    ):
        return False

    # nushell
    if not install_tool(
        "nushell",
        "nu",
        "cargo binstall nu --locked -y",
    ):
        return False

    # wezterm
    if not install_tool(
        "wezterm",
        "wezterm",
        """curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg && \
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list && \
sudo apt update && sudo apt install -y wezterm""",
    ):
        return False

    # TPM (Tmux Plugin Manager)
    tpm_dir = HOME / ".tmux" / "plugins" / "tpm"
    if tpm_dir.exists():
        console.print("  [green]✓[/green] TPM [dim](already installed)[/dim]")
    else:
        with console.status("  [yellow]Installing TPM...[/yellow]"):
            if run(f"git clone https://github.com/tmux-plugins/tpm {tpm_dir}"):
                console.print("  [green]✓[/green] TPM")
            else:
                console.print("  [red]✗[/red] TPM [red](installation failed)[/red]")
                return False

    return True


def create_symlink(src: Path, dst: Path) -> bool:
    """Create a symlink, removing existing target. Returns True if successful."""
    try:
        # Ensure parent directory exists
        dst.parent.mkdir(parents=True, exist_ok=True)

        # Remove existing target
        if dst.is_symlink() or dst.exists():
            if dst.is_dir() and not dst.is_symlink():
                shutil.rmtree(dst)
            else:
                dst.unlink()

        # Create symlink
        dst.symlink_to(src)
        return True
    except Exception as e:
        console.print(f"  [red]✗[/red] {src.name} → {dst} [red]({e})[/red]")
        return False


def create_symlinks() -> bool:
    """Create all symlinks. Returns True if all successful."""
    console.print("\n[bold]Creating symlinks...[/bold]")
    all_success = True

    # Directory symlinks
    for name, dst in DIR_SYMLINKS:
        src = DOTFILES_DIR / name
        if create_symlink(src, dst):
            console.print(f"  [green]✓[/green] {name} → {dst}")
        else:
            all_success = False

    # File symlinks
    for name, dst in FILE_SYMLINKS:
        src = DOTFILES_DIR / name
        if create_symlink(src, dst):
            console.print(f"  [green]✓[/green] {name} → {dst}")
        else:
            all_success = False

    return all_success


def main() -> int:
    console.print(Panel("Bootstrap", expand=False))

    if not install_tools():
        console.print("\n[red]Bootstrap failed during tool installation.[/red]")
        return 1

    symlinks_ok = create_symlinks()

    if symlinks_ok:
        console.print("\n[green]Done![/green] Run [bold]'nu'[/bold] to start nushell.")
        return 0
    else:
        console.print("\n[yellow]Done with errors.[/yellow] Some symlinks failed.")
        return 1


if __name__ == "__main__":
    sys.exit(main())
