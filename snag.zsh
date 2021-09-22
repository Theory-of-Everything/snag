# snag.zsh
#
# a minimal "plugin" manager for zsh

PLUG_DIR="$ZDOTDIR/plug"

function snag-sync() {
	for plug ($PLUG_DIR/*); do
		print "${fg[green]%}[SNAG] <======================== ${fg[red]%}Updating${fg[green]%} \(${fg[blue]%}$(echo $plug | cut -d '/' -f 7)${fg[green]%}\)${fg[white]%}"
		git -C $plug pull
	done
	print "${fg[magenta]%}Finished updating plugins! (enter to continue) ${fg[white]%}"
	read
}

function snag-use() {
	SNAG_CONFIM=false
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$PLUG_DIR/$PLUGIN_NAME" ]; then 
        source "$PLUG_DIR/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source "$PLUG_DIR/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
		print "${fg[green]%}[SNAG] <======================== ${fg[red]%}Installing${fg[green]%} \(${fg[blue]%}$(echo $PLUGIN_NAME)${fg[green]%}\)${fg[white]%}"
        git clone "https://github.com/$1.git" "$PLUG_DIR/$PLUGIN_NAME"
		print "${fg[green]%}[SNAG] Sourcing \(${fg[blue]%}$(echo $PLUGIN_NAME)${fg[green]%}\)${fg[white]%}"
        source "$PLUG_DIR/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source "$PLUG_DIR/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
	fi
}
function snag-clean-everything() {
	print "${fg[red]%}WARNING: THIS WILL CLEAR ALL PLUGS WITH ESCALATED PRIVILAGES"
	print "${fg[red]%}Ctrl-c if you want to prevent this${fg[white]%}"
	read
	print "${fg[red]%}Cleaning all plugins, asking for escalated prvilages...${fg[white]%}"
	for plug ($PLUG_DIR/*); do
		sudo rm -r $plug && print "${fg[blue]%}Removed $plug${fg[white]%}" || echo "${fg[red]%}An unexpected error occured!${fg[white]%}"
	done
}
