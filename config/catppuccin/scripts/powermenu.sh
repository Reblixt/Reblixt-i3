#! /bin/sh

rofi_cmd() {
	rofi -dmenu \
		-theme ~/.config/rofi/powermenu.rasi
}

chosen=$(printf "⏻ poweroff\n󰜉 reboot\n󰗼 exit" | rofi_cmd)

case "$chosen" in

"⏻ poweroff") poweroff ;;
"󰜉 reboot") reboot ;;
"󰗼 exit") bspc quit ;;

#	"⏻ poweroff") sudo shutdown -h now ;;
#	"󰜉 reboot") sudo shutdown -r now ;;
#	"󰗼 exit") bspc quit ;;
#	*) exit 1 ;;

esac
