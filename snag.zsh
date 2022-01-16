#!/usr/bin/env zsh
# vim:ft=zsh:fdm=marker
# This program is free software: you can redistribute it and/or modify it under the terms
# of the GNU General Public License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program.
# If not, see <https://www.gnu.org/licenses/>.
#
# ---------------------------------------------------------------------------
#
# snag.zsh
#
# a simple zsh "plugin" manager
# source code avalible at https://sr.ht/~theorytoe/snag
#

# define plugin dir, and make it if it does not exist
PLUG_DIR="$ZDOTDIR/plug"
if [ ! -d $PLUG_DIR ]; then mkdir "$PLUG_DIR"; fi

# snag current version
SNAG_VERSION="v0.1.0"

# pull changes from plugin repositories
snag-sync() { # {{{
	print -P "%B%F{green}[SNAG] <======================== %B%F{red}Updating Plugs%B%F{green}%b%F{white}"
	find ~/.config/zsh/plug -maxdepth 2 -mindepth 2 -type d -printf "%p -- " -exec git -C {} pull \;
} # }}}

# clone/source a plugin
snag-use() { # {{{
	PLUGIN_DIR=$(echo $1 | cut -d "/" -f 1)
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME" ]; then 
		if [ -z "$2" ]; then
        	source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        	source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
		else
			source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$2.plugin.zsh" || \
			source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$2.zsh"
		fi
    else
		print -P "%B%F{green}[SNAG] <======================== %B%F{red}Installing%B%F{green} \(%b%F{blue}$(echo $1)%B%F{green}\)%b%F{white}"
        git clone "https://github.com/$1.git" "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME"
		print -P "%B%F{green}[SNAG] Sourcing \(%b%F{blue}$(echo $1)%B%F{green}\)%b%F{white}"
		if [ -z "$2" ]; then
        	source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        	source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
		else
			source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$2.plugin.zsh" || \
			source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$2.zsh"
		fi
	fi
} # }}}

# remove a plugin
snag-remove-plugin() { # {{{
	if [ -z $1 ]; then
		echo "No arg provided"
	else
		if [ -d "$PLUG_DIR/$1" ]; then
			print -P "%B%F{red}Removing $(echo $PLUG_DIR/$1 | rev | cut -d "/" -f -2 | rev), asking for escalated prvilages...%b%F{white}"
			sudo rm -r $PLUG_DIR/$1 && print -P "%b%F{blue}Removed $PLUG_DIR/$1%b%F{white}" || echo "%b%F{red}An unexpected error occured!${fg[white]%}"
			echo "Please reomve the 'snag-use \""$1"\"' call from your rc file to prevent this plugin from re-installing"

		else
			echo "Plugin does not exist"
		fi
	fi
} # }}}

# purge all installed plugins
snag-purge() { # {{{
	print -P "%B%F{red}WARNING: THIS WILL CLEAR ALL PLUGS WITH ESCALATED PRIVILAGES"
	print -P "%B%F{red}Ctrl-c if you want to prevent this (enter to continue)%b%F{white}"
	read
	print -P "%B%F{red}Cleaning all plugins, asking for escalated prvilages...%b%F{white}"
	for plug ($PLUG_DIR/*); do
		sudo rm -r $plug && print -P "%b%F{blue}Removed $plug%b%F{white}" || echo "%b%F{red}An unexpected error occured!${fg[white]%}"
	done
} # }}}

# list all installed plugins
snag-list-plugs() { # {{{
	for plug ($PLUG_DIR/*/*); do
		item="$(echo $plug | rev | cut -d "/" -f -2 | rev)"
		print -P "%b%F{blue}$item%b%F{white}"
	done
} # }}}

# list info about a plugin
snag-plug-info() { # {{{
	if [ -z $1 ]; then
		echo "No argument provided"
	else
		if [ -z $SNAG_PAGER ]; then
			if [ $SNAG_MDCAT = "true" ]; then
				if command -v mdcat > /dev/null ; then
					mdcat $PLUG_DIR/$1/README.md || mdcat $PLUG_DIR/$1/README.txt
				else
					cat $PLUG_DIR/$1/README.md || cat $PLUG_DIR/$1/README.txt
				fi
			else
				cat $PLUG_DIR/$1/README.md || cat $PLUG_DIR/$1/README.txt
			fi
		else
			$SNAG_PAGER $PLUG_DIR/$1/README.md || $SNAG_PAGER $PLUG_DIR/$1/README.txt
		fi
	fi
} # }}}

# print help usage
snag-print-usage() { # {{{
cat << EOF
snag [OPTIONS] [PLUG]
  -u PLUG			install plugin from repo user/repo
  -r PLUG			remove installed plugin user/repo
  -D				purge all installed plugins
  -s				update installed plugins

  -l				list all plugins
  -i PLUG			get info on a plugin to stdout or pager if set

  -h, --help			print help dialouge
  -v, --version			print current snag version

EOF
} # }}}

if [ "$1" = "--help" ]; then
	snag-print-usage
	exit 0
fi
if [ "$1" = "--version" ]; then
	echo "$SNAG_VERSION"
	exit 0
fi

# parse arguments
while getopts sDhlr:u:i: o; do
	case $o in
		u) echo "This is not the prefered way of installing plugins, please install in your .zshrc" 
		   snag-use "$OPTARG"; echo "snag-use \"$1\"" >> $ZDOTDIR/.zshrc;;

		r) snag-remove-plugin $OPTARG;;
		s) snag-sync;;
		D) sang-purge;;

		i) snag-plug-info $OPTARG;;
		l) snag-list-plugs;;

		h) snag-print-usage;;

		v) echo "$SNAG_VERSION";;
		[?]) echo 'Unknown option... (try: "snag --help")';;
	esac
done
