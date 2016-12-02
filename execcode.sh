#!/bin/ksh

CONFIG=barcode.cfg

while read BARCODE
do
	while IFS='|' read Regex Action
	do
		[[ $BARCODE == $Regex ]] && eval $Action
	done <$CONFIG
done
