# snag.zsh
#
# a minimal "plugin" manager for zsh
#
PLUG_DIR="$ZDOTDIR/plug"
function snag-sync() {
	if [ ! -d $PLUG_DIR ]; then; mkdir "$PLUG_DIR"; fi
	for plug ($PLUG_DIR/*/*); do
		print -P "%B%F{green}[SNAG] <======================== %B%F{red}Updating%B%F{green} \(%b%F{blue}$(echo $plug | cut -d '/' -f 8)%B%F{green}\)%b%F{white}"
		echo $plug
		git -C $plug/ pull
	done
	print -P "%B%F{magenta}Finished updating plugins! (enter to continue) %b%F{white}"
	read
}
function snag-use() {
	if [ ! -d $PLUG_DIR ]; then; mkdir "$PLUG_DIR"; fi
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
		print -P "%B%F{green}[SNAG] <======================== %B%F{red}Installing%B%F{green} \(%b%F{blue}$(echo $PLUGIN_DIR)%B%F{green}\)%b%F{white}"
        git clone "https://github.com/$1.git" "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME"
		print -P "%B%F{green}[SNAG] Sourcing \(%b%F{blue}$(echo $PLUGIN_DIR/$PLUGIN_NAME)%B%F{green}\)%b%F{white}"
		if [ -z "$2" ]; then
        	source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        	source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
		else
			source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$2.plugin.zsh" || \
			source "$PLUG_DIR/$PLUGIN_DIR/$PLUGIN_NAME/$2.zsh"
		fi
	fi
}
function snag-clean-everything() {
	print -P "%B%F{red}WARNING: THIS WILL CLEAR ALL PLUGS WITH ESCALATED PRIVILAGES"
	print -P "%B%F{red}Ctrl-c if you want to prevent this (enter to continue)%b%F{white}"
	read
	print -P "%B%F{red}Cleaning all plugins, asking for escalated prvilages...%b%F{white}"
	for plug ($PLUG_DIR/*); do
		sudo rm -r $plug && print -P "%b%F{blue}Removed $plug%b%F{white}" || echo "%b%F{red}An unexpected error occured!${fg[white]%}"
	done
}
