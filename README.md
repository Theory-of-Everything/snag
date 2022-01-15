## sang
Snag is an ultra-simple and minimal "plugin manager" for zsh.

### Usage:
To install "plugins"
```zsh
# .zshrc
# all plugins are cloned to $ZDOTDIR/plug
snag-use "zsh-users/zsh-syntax-highlighting"
snag-use "hlissner/zsh-autopair"

# to use plugins with script names not similar to the repo name,
# pass in a second argument of the filename relative path without '.plugin.zsh'/'.zsh' file extension
snag-use "ael-code/zsh-colored-man-pages" "colored-man-pages"
```
To update all installed plugins:
```zsh
$ snag-sync
```
To clean/delete all installed plugins (requires root access):
```zsh
$ snag-clean-everything
```

## Installation:
```zsh
$ mkdir $ZDOTDIR/plug
$ wget https://git.sr.ht/~theorytoe/snag/blob/main/snag.zsh -O "$ZDOTDIR/snag.zsh"
```
Source it in your .zshrc:
```zsh
# .zshrc

source "$ZDOTDIR/snag.zsh"
# or source it wherever you have it installed
```

## Notes:
This tool relies on having your `$ZDOTDIR` evironment variable set, and will not function properly if not set.
