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
snag -s
```
To list installed plugins:
```zsh
snag -l 
```
To look at info for a plugin:
```zsh
snag -i <pluin-name>
```
To remove a plugin (root privileges required):
```zsh
# this does not remove the plugin
# declaration from your .zshrc
snag -r <plugin-name>
```
To clean/delete all installed plugins (requires root access):
```zsh
snag -D
```

For more detailed documentation:
```zsh
man snag
```

## Installation:
```zsh
mkdir $ZDOTDIR/plug
git clone https://git.sr.ht/~theorytoe/snag/blob/main/snag.zsh
cd snag
make install
```
Source it in your .zshrc:
```zsh
# .zshrc

# by default snag is installed here
# if you install it somewhere else change accordingly
source "~/.local/share/bin/snag"
```

To install only man pages:
```zsh
make man
```

To uninstall:
```zsh
cd /path/to/snag/repo
make uninstall
```
manual method
```zsh
rm -f ~/.local/share/bin/snag
rm -f ~/.local/share/man/man1/snag.1.gz
```

## Notes:
This tool relies on having your `$ZDOTDIR` evironment variable set, and will not function properly if not set.
