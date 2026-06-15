# Arch dotfiles

stable on `hp x360 15m-es0055`

## Setup

### Dependencies

`install.sh`

- `stow`

Programs listed in `pkglist.txt`.

### Installation

Install with `install.sh`

#### Manual steps

Filter foreign packages and install package list.

```sh
\# pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
```

Then, symlink or copy each directory to `~/.config/`. The directories are structured
for use with `stow`.

## System Maintenance

### System Upgrade

Before upgrading, check [Arch home page](https://archlinux.org/) for news. Upgrading packages
can raise unexcpected errors, but Arch won't force you to upgrade, so if you have
an important task or otherwise require a stable system, wait to upgrade.
I have good experience with upgrading every 2 weeks.
Also, backup any files. `pacman` won't brick your system, but certain files could be overwritten, especially
if you have custom files outside of `home/`.

Avoid partial upgrades; you should **never** run `pacman -Sy`. Arch is a _rolling realease_, therefore
`-Sy _package_` will update the _pacman_ sync database, without installing newer packages.

> If pacman `-Syu` fails to complete the upgrade, resolve the error and complete update before other package management operations, as the database syncing (the -Sy part) has succeeded first.

After a succesfull system upgrade and dealing with any errors, check for new or updated configuration
files for individual programs.

When you're all setup and happy, make sure to cleanup orphans: packages that are no longer
needed or maintained in official repositories.

```sh
# Check for orphans
\# pacman -Qtd
# For recursively removing orphans and their configuration files:
\# pacman -Qdtq | pacman -Rns -
```

Cliffnotes:

- regular system updates
- backup files and be aware of potential errors
- rolling realease: **NEVER** run partial upgrades
- `pacman -Syu` and inshallah

### Cleaning filesystem

Regularily check for unused or outdate files.

- `~/.config/`: where applications stores their configuration
- `~/.cache/`: cache of some programs may grow in size
- `~/.local/share/`: old files may be lying there

Even if you set base directories, programs might still pollute the home directory with
temporary files created at the long place. Consider using a program or script to
automate.

Old symlinks also have to be removed.
However, some broken symlinks serve a purpose. Instead, list old symlinks and inspect and
handle each.

```sh
\# find / -type d \( -path "/dev" -o -path "/proc" -o -path "/run" -o -path "/sys" \) -prune -o -xtype l -print
```

### Firmware

Depending on your harware manufactor, good luck.
`fwupd` is a really solid tool. Manual guides exist, but make sure
they are based on your OS, hardware manufactor, and comparable device.

Only use official firmware updates that is also compatible with your
device.
