#!/bin/bash
echo ""
echo "-- Single file date changer --"
echo ""
echo "Use ctrl+c to exit"
echo ""

read -rp "Drag the file into the window, then hit enter: " file
file=$(echo $file | tr -d '\') # Remove the backslashes

read -p "Enter a date in MMDDYY format, then hit enter: " date

touch -t 20${date:4:2}${date:0:2}${date:2:2}0000 "$file"

SetFile -d "${date:0:2}/${date:2:2}/${date:4:2} 00:00:00" "$file"

read -p "Do you want to change another file? [Y/n]: " another

if [ $another == 'n' ]
then
  exit
else
  ./changeSingleFile.command
fi
