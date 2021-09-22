## sang
Snag is an ultra-simple and minimal "plugin manager" for zsh.

### Usage:
To install "plugins"
```zsh
# .zshrc

snag-use "zsh-users/zsh-syntax-highlighting"
snag-use "hlissner/zsh-autopair"
```
To update all installed plugins:
```zsh
$ snag-sync
```
To clean/delete all installed plugins (requires root access):
```zsh
snag-clean-everything
```

## Installation:
```zsh
$ wget https://raw.githubusercontent.com/Theory-of-Everything/snag/main/snag.zsh -O "$ZDOTDIR/"
```
Source it in your .zshrc:
```zsh
# .zshrc

source "$ZDOTDIR/snag.zsh"
# or source it wherever you have it installed
```

## Notes:
This tool relies on having your `$ZDOTDIR` evironment variable set, and will not function properly if not set.
