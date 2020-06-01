#!/bin/bash
# gsetting helper for i3-like navigation

keys=(exclam at numbersign dollar percent asciicircum ampersand asterisk)
wmschema=org.gnome.desktop.wm.keybindings
shellschema=org.gnome.shell.keybindings
keysschema=org.gnome.settings-daemon.plugins.media-keys

read -r -d '' terminal << EOF
[custom0]
binding='<Super>Return'
command='gnome-terminal'
name='Terminal'
EOF

for k in $(seq 0 7) ; do
	index=$(($k+1))
	key=${keys[$k]}
	gsettings set $shellschema switch-to-application-$index []
	gsettings set $wmschema switch-to-workspace-$index "['<Super>$index']"
	gsettings set $wmschema move-to-workspace-$index "['<Super><Shift>$key']"
done

gsettings set $shellschema toggle-application-view "['<Super>d']"

gsettings set $wmschema switch-applications []
gsettings set $wmschema cycle-windows "['<Super>Tab']"
gsettings set $wmschema move-to-monitor-up []
gsettings set $wmschema move-to-monitor-down []
gsettings set $wmschema move-to-workspace-up "['<Shift><Super>Up']"
gsettings set $wmschema move-to-workspace-down "['<Super><Shift>Down']"

gsettings set $wmschema close "['<Super>q']"
gsettings set $keysschema screensaver "['<Super>Escape']"

echo "$terminal" | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
gsettings set $keysschema custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
