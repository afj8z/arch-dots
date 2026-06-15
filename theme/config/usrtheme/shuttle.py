#!/usr/bin/env python3
import os
import shutil
import sys
import subprocess
from pathlib import Path

# --- Configuration ---

HOME = Path.home()
CONFIG = Path(os.environ.get("XDG_CONFIG_HOME", HOME / ".config"))
THEME_BASE_DIR = Path.cwd()

FILE_MAPPING = {
    # Firefox
    "ffroot.css": HOME / ".mozilla/firefox/qb4ziph3.default-release/chrome/root.css",
    "fftheme.css": HOME
    / ".mozilla/firefox/qb4ziph3.default-release/chrome/theme/fftheme.css",
    # Neovim
    "colors.lua": CONFIG / "nvim/lua/ajf/colors.lua",
    "customss.lua": HOME / "dev/jome.nvim/lua/nvim-tundra/stylesheet/custom.lua",
    "custom.lua": HOME / "dev/jome.nvim/lua/nvim-tundra/palette/custom.lua",
    # Terminals & Shell
    "kitty-colors.conf": CONFIG / "kitty/kitty-theme.conf",
    "shell-theme.sh": CONFIG / "zsh/shell-theme.sh",
    # Apps (Inferred from your file list 'config' and 'zathuratheme')
    "config": CONFIG / "dunst/dunstrc",
    "zathuratheme": CONFIG / "zathura/zathuratheme",
    "tmux-theme.conf": CONFIG / "tmux/tmux-theme.conf",
    "theme.typ": HOME / "lib/typst/local/test/0.1.0/__theme.typ"
}

# Commands to run after copying files
RELOAD_COMMANDS = [
    # Reload Dunst
    ["killall", "-SIGUSR2", "dunst"],
    # Reload Kitty (SIGUSR1 usually forces config reload)
    ["pkill", "-SIGUSR1", "kitty"],
    # Reload Zathura (optional, usually auto-reloads)
    ["tmux", "source", "~/.tmux.conf"],
    ["reload-dwlb.sh"],
    ["reload-bemenu.sh"],
    # ["pkill", "-SIGHUP", "zathura"],
    # Run a script to refresh environment vars if needed,
    # though usually new shells pick up shell-theme.sh automatically.
]


def apply_theme(theme_name):
    """
    Copies files from the selected theme directory to system destinations.
    """
    source_dir = THEME_BASE_DIR / theme_name

    if not source_dir.exists():
        print(f"Error: Theme directory '{theme_name}' does not exist.")
        sys.exit(1)

    print(f"--> Applying theme: {theme_name}")

    for filename, dest_path in FILE_MAPPING.items():
        source_file = source_dir / filename
        dest_path = Path(dest_path)  # Ensure it's a Path object

        if source_file.exists():
            # Create parent directories if they don't exist
            try:
                dest_path.parent.mkdir(parents=True, exist_ok=True)
            except Exception as e:
                print(f"ERR: Creating dir {dest_path.parent} failed: {e}")
                continue

            # Copy the file
            try:
                # copy2 preserves permissions
                shutil.copy2(source_file, dest_path)
                print(f"OK: {filename} -> {dest_path}")
            except Exception as e:
                print(f"ERR: Copying {filename} failed: {e}")
        else:
            # it's common for some themes to miss a specific file, so just warn.
            print(f"SKIP: {filename} (not found in {theme_name})")


def run_post_actions():
    """
    Runs shell commands to reload applications.
    """
    print("\n--> Reloading applications...")
    for cmd in RELOAD_COMMANDS:
        try:
            subprocess.run(
                cmd, check=False, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
            )
            print(f"Ran: {' '.join(cmd)}")
        except FileNotFoundError:
            print(f"CMD Not Found: {cmd[0]}")
        except Exception as e:
            print(f"Error running {' '.join(cmd)}: {e}")


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 shuttle.py <theme_name>")
        print("Example: python3 shuttle.py dark")
        print("Available themes: ", end="")
        # list directories in current path that look like themes
        themes = [
            d.name
            for d in THEME_BASE_DIR.iterdir()
            if d.is_dir() and not d.name.startswith(".")
        ]
        print(", ".join(themes))
        sys.exit(1)

    theme_name = sys.argv[1]
    apply_theme(theme_name)
    run_post_actions()
    print("\nDone.")


if __name__ == "__main__":
    main()
