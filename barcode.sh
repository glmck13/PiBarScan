#!/bin/ksh

CONFIG=barcode.cfg

typeset -A Keymap
Keymap['MINUS']='-'
Keymap['EQUAL']='='
Keymap['LEFTBRACE']='{'
Keymap['RIGHTBRACE']='}'
Keymap['SEMICOLON']=';'
Keymap['APOSTROPHE']="'"
Keymap['GRAVE']='\`'
Keymap['BACKSLASH']='\\'
Keymap['COMMA']=','
Keymap['DOT']='.'
Keymap['SLASH']='/'
Keymap['SPACE']=' '

while true
do

#
# Get barcode /dev/input/event #
#
while true
do

Device=""

lsinput | while IFS=":" read Name Desc
do
	if [[ $Name == /dev/input/event* ]]; then
		Save=$Name
	elif [[ $Desc == *[Bb][Aa][Rr][Cc][Oo][Dd][Ee]* ]]; then
		Device=$Save
		break
	fi
done

[ "$Device" ] && break

unbuffer udevadm monitor -u | while read Type Stamp Action Device Comment
do
	[[ $Type == UDEV ]] || continue

	[[ $Action == add && $Device == */event[0-9] ]] || continue

	break
done

done

Device="${Device##*/event}"

#
# Read barcode scanner until EOF
#

BARCODE=""

unbuffer input-events -t 300 ${Device##*/event} |
while read Stamp Type Key Value Action
do
	[[ $Type == EV_KEY && $Action == pressed ]] || continue

	Key=${Key#KEY_}

	if [[ $Key == ? ]]; then
		BARCODE+=$Key
	elif [[ ${Keymap[$Key]} ]]; then
		BARCODE+=${Keymap[$Key]}
	elif [[ $Key == ENTER ]]; then
		print $BARCODE
		BARCODE=""
	fi
done | while read BARCODE
do
	while IFS='|' read Regex Action
	do
		[[ $BARCODE == $Regex ]] && eval $Action
	done <$CONFIG
done

done
