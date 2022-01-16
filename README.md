## sang
Snag is an ultra-simple and minimal "plugin manager" for zsh.

### Usage:
To install "plugins"
```zsh
# .zshrc
# all plugins are cloned to $ZDOTDIR/plug
# in the pattern user/repo
snag-use "zsh-users/zsh-syntax-highlighting"
snag-use "hlissner/zsh-autopair"

# to use plugins with script names not similar to the repo name,
# pass in a second argument of the filename relative path without '.plugin.zsh'/'.zsh' file extension
snag-use "ael-code/zsh-colored-man-pages" "colored-man-pages"
```

Command line options:
```
snag [OPTIONS] [PLUG]
  -u PLUG			install plugin from repo user/repo
  -r PLUG			remove installed plugin user/repo
  -D				purge all installed plugins
  -s				update installed plugins

  -l				list all plugins
  -i PLUG			get info on a plugin to stdout or pager if set

  -h, --help			print help dialouge
  -v, --version			print current snag version
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

## Contributing:
If you want to contibute, file issues in the [tracker](https://todo.sr.ht/~theorytoe/snag-bugs) and send patches to the [mailing list](https://lists.sr.ht/~theorytoe/snag)

## Notes:
This tool relies on having your `$ZDOTDIR` evironment variable set, and will not function properly if not set.
