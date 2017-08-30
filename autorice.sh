#!/bin/bash

color=( $(convert $1 +dither +despeckle -colors 16 -unique-colors txt:-| grep -o --color=never "#[0-F]\{6\}") )
clist="ColorPalette=${colors[0]};${colors[1]};${colors[2]};${colors[3]};${colors[4]};${colors[5]};${colors[6]};${colors[7]};${colors[8]};${colors[9]};${colors[10]};${colors[11]};${colors[12]};${colors[13]};${colors[14]};${colors[15]};"
clist=$(echo $clist | tr -d " ")

#update saljs's term colorscheme
#sed -i "s/ColorPalette.*/$clist/g" ~/.config/xfce4/terminal/terminalrc

#pretty name for color
black=${color[0]}		#0
red=${color[9]}			#1
green=${color[10]}		#2
brown=${color[11]}		#3
blue=${color[12]}		#4
magenta=${color[13]}		#5
cyan=${color[14]}		#6
light_grey=${color[15]}		#7

# to give comments a consistant color across themes,
# assign this later based on the darkest color grabbed.
# dark_grey=			#8

light_red=${color[9]}		#9
light_green=${color[10]}	#10
yellow=${color[11]}		#11
light_blue=${color[12]}		#12
light_magenta=${color[13]}	#13
light_cyan=${color[14]}		#14
white=${color[15]}		#15


# pull the msb from the red portion.
# TODO: get brightness from all colors.
case $(echo $color[0]|cut -b 2) in
	[0-9])
		dark_grey="#999999"
		;;
	*)
		dark_grey=${color[8]}
		;;
esac

# note about the above:
# the color list is in order of darkest to brightest
# we are ok with the comment color being brighter than 50% grey
# but not below it.

sed -i "s/dmenu_run.*/dmenu_run\ -nb \"${color[0]}\" -nf \"${color[15]}\" -sb \"${color[14]}\" -sf \"${color[1]}\"/g" ~/.config/i3/config
sed -i "s/separator.*/separator\ $light_grey/g" ~/.config/i3/config
sed -i "s/background.*/background\ #2F343F/g" ~/.config/i3/config
sed -i "s/statusline.*/statusline\ $white/g" ~/.config/i3/config
sed -i "s/focused_workspace.*/focused_workspace\ $light_blue\ $light_blue\ $white/g" ~/.config/i3/config
sed -i "s/active_workspace.*/active_workspace\ #2F343F\ #2F343F\ $light_grey/g" ~/.config/i3/config
sed -i "s/inactive_workspace.*/inactive_workspace\ #2F343F\ #2F343F\ $white/g" ~/.config/i3/config
sed -i "s/urgent_workspace.*/urgent_workspace\ #2F343F\ $red\ #2F343F/g" ~/.config/i3/config

sed -i "s/client\.focused.*/client\.focused\ $light_blue\ $light_blue\ $white\ #2F343F/g" ~/.config/i3/config
sed -i "s/client\.focused_inactive.*/client\.focused_inactive\ #2F343F\ #2F343F\ $brown\ #2F343F/g" ~/.config/i3/config
sed -i "s/client\.unfocused.*/client\.unfocused\ #2F343F\ #2F343F\ $light_grey\ #2F343F/g" ~/.config/i3/config
sed -i "s/client\.urgent.*/client\.urgent\ $red\ $red\ #2F343F\ $light_red/g" ~/.config/i3/config

sed -i "s/color_good.*/color_good\ =\ \"$white\"/g" ~/.config/i3status/config
sed -i "s/color_degraded.*/color_degraded\ =\ \"$light_red\"/g" ~/.config/i3status/config
sed -i "s/color_bad.*/color_bad\ =\ \"$light_red\"/g" ~/.config/i3status/config


sed -i "s/cursorColor:.*/cursorColor:	$white/g" ~/.Xresources
sed -i "s/foreground:.*/foreground:	$white/g" ~/.Xresources
sed -i "s/background:.*/background:	$black/g" ~/.Xresources

sed -i "s/color0:.*/color0:	$black/g" ~/.Xresources
sed -i "s/color1:.*/color1:	$red/g" ~/.Xresources
sed -i "s/color2:.*/color2:	$green/g" ~/.Xresources
sed -i "s/color3:.*/color3:	$brown/g" ~/.Xresources
sed -i "s/color4:.*/color4:	$blue/g" ~/.Xresources
sed -i "s/color5:.*/color5:	$magenta/g" ~/.Xresources
sed -i "s/color6:.*/color6:	$cyan/g" ~/.Xresources
sed -i "s/color7:.*/color7:	$light_grey/g" ~/.Xresources
sed -i "s/color8:.*/color8:	$dark_grey/g" ~/.Xresources
sed -i "s/color9:.*/color9:	$light_red/g" ~/.Xresources
sed -i "s/color10:.*/color10:	$light_green/g" ~/.Xresources
sed -i "s/color11:.*/color11:	$yellow/g" ~/.Xresources
sed -i "s/color12:.*/color12:	$light_blue/g" ~/.Xresources
sed -i "s/color13:.*/color13:	$light_magenta/g" ~/.Xresources
sed -i "s/color14:.*/color14:	$light_cyan/g" ~/.Xresources
sed -i "s/color15:.*/color15:	$white/g" ~/.Xresources


feh  --bg-scale $1
i3-msg reload
i3-msg restart
xrdb .Xresources
